#!/bin/zsh

function aws-ecr-login {
  local registry=$1
  local region=$2

  if [ -z "${registry}" || -z "${region}" ]; then
    log_error "Usage: $0 <registry> <region>"
    return 1
  fi

  log_info "[AWS ECR] Logging into Docker registry: ${registry}"

  if ! command -v aws >/dev/null 2>&1; then
    log_error "[AWS] AWS CLI not found"
    return 1
  fi

  if ! command -v docker >/dev/null 2>&1; then
    log_error "[AWS] Docker not found"
    return 1
  fi

  if ! aws ecr get-login-password --region "${region}" | docker login --username AWS --password-stdin "${registry}"; then
    log_error "[AWS] Docker login failed"
    return 1
  fi

  log_final "[AWS] Docker login successful"
}

function aws-ecr-helm-login {
  local registry=$1
  local region=$2

  if [ -z "${registry}" || -z "${region}" ]; then
    log_error "Usage: $0 <registry> <region>"
    return 1
  fi

  log_info "[AWS ECR] Logging into Helm registry: ${registry}"

  if ! command -v aws >/dev/null 2>&1; then
    log_error "[AWS ECR] AWS CLI not found"
    return 1
  fi

  if ! command -v helm >/dev/null 2>&1; then
    log_error "[AWS ECR] Helm not found"
    return 1
  fi

  if ! aws ecr get-login-password --region "${region}" | helm registry login --username AWS --password-stdin "${registry}"; then
    log_error "[AWS ECR] Helm login failed"
    return 1
  fi

  log_final "[AWS ECR] Helm login successful"
}
