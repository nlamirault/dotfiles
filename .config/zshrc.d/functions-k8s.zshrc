#!/bin/zsh

function k8s-node-pods {
  local node=$1

  if [ -z "${node}" ]; then
    log_error "Usage: k8s-node-pods <node name>"
    return 1
  fi

  kubectl get pods -A -o wide --field-selector "spec.nodeName=${node}"
}

function k8s-nodes-events {
  kubectl get events --field-selector involvedObject.kind=Node --sort-by=.lastTimestamp
}

function k8s-node-events {
  local node=$1

  if [ -z "${node}" ]; then
    log_error "Usage: k8s-node-events <node name>"
    return 1
  fi
  kubectl get events --field-selector "involvedObject.kind=Node,involvedObject.name=${node}"
}

function k8s-karpenter-nodepool-nodes {
  local nodeclass=$1

  if [ -z "${nodeclass}" ]; then
    log_error "Usage: k8s-karpenter-nodepool-nodes <ec2nodeclass>"
    return 1
  fi

  local nodes=($(kubectl get nodes -l "karpenter.k8s.aws/ec2nodeclass=${nodeclass}" -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}' | tr -d '\r'))
  if [ ${#nodes[@]} -eq 0 ]; then
    log_info "No nodes found for ec2nodeclass=${nodeclass}" >&2
    return 0
  fi

  log_debug "Found nodes:"
  for node in "${nodes[@]}"; do
    echo "- ${node}"
  done
}

function k8s-karpenter-nodepool-pods {
  local nodeclass=$1

  if [ -z "${nodeclass}" ]; then
    log_error "Usage: k8s-karpenter-nodepool-pods <ec2nodeclass>"
    return 1
  fi

  local nodes=($(kubectl get nodes -l "karpenter.k8s.aws/ec2nodeclass=${nodeclass}" -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}' | tr -d '\r'))
  if [ ${#nodes[@]} -eq 0 ]; then
    log_info "No nodes found for ec2nodeclass=${nodeclass}" >&2
    return 0
  fi

  # log_info "Found nodes:"
  # for node in "${nodes[@]}"; do
  #   echo "- ${node}"
  # done

  for node in "${nodes[@]}"; do
    log_debug "Pods on node: ${node}"
    kubectl get pods -A -o wide --field-selector "spec.nodeName=${node}"
  done
}

function k8s-node-viewer {
  local nodeclass=$1

  if [ -z "${nodeclass}" ]; then
    log_error "Usage: k8s-karpenter-nodepool-pods <ec2nodeclass>"
    return 1
  fi

  eks-node-viewer --resources cpu,memory --node-selector "karpenter.k8s.aws/ec2nodeclass=${nodeclass}"
}


function k8s-pods-image {
  local image=$1
  if [ -z "${image}" ]; then
    log_error "Usage: k8s-pods-image <image>"
    return 1
  fi

  for kind in deployment daemonset statefulset job cronjob; do
    log_info "$kind"
    # kubectl get $kind -A -o json |
    #   jq -r --arg img "${image}" \
    #     '.items[] | select(.spec.template.spec.containers[].image == $img)
    #   | "\(.metadata.namespace)/\(.metadata.name)"'
    kubectl get pods -A -o jsonpath='{range .items[?(@.spec.containers[*].image=="${image}")]}{.metadata.namespace}/{.metadata.name}{"\n"}{end}'
  done
}

function k8s-pdb {
  local namespace=$1
  if [ -z "${namespace}" ]; then
    log_error "Usage: k8s-pdb <namespace>"
    return 1
  fi

  for kind in deployment statefulset; do
    kubectl get "$kind" -n "$namespace" -o json | jq -r --arg kind "$kind" '
      .items[] |
      {
        name: .metadata.name,
        kind: $kind,
        # prefer pod template labels; fallback to metadata.labels if absent
        labels: (.spec.template.metadata.labels // .metadata.labels // {})
      }' | jq -c '.' | while read -r item; do

      name=$(echo "$item" | jq -r '.name')
      kind=$(echo "$item" | jq -r '.kind')
      labels=$(echo "$item" | jq -c '.labels')

      # On cherche les PDB dont chaque matchLabel est présent et égal dans les labels du workload
      pdbs=$(kubectl get pdb -n "$namespace" -o json | jq -r --argjson labels "$labels" '
        .items[] |
        select(.spec.selector.matchLabels != null) |
        select(.spec.selector.matchLabels as $pdbSel |
               # pour chaque entrée du pdbSel, vérifier que labels[key] == value
               ($pdbSel | to_entries | all(. as $e | ($labels[$e.key] == $e.value)))) |
        .metadata.name
      ')

      if [ -n "$pdbs" ]; then
        log_info "$kind/$name →  $pdbs"
      else
        log_warn "$kind/$name"
      fi
    done
  done

}
