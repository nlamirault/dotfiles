#!/bin/zsh

# # Check SSL certificate expiry for a host
# Usage: cert-check example.com [port]
cert-check() {
  local host="${1:?Usage: cert-check <host> [port]}"
  local port="${2:-443}"

  local info
  info=$(echo | openssl s_client -connect "${host}:${port}" -servername "${host}" 2>/dev/null \
    | openssl x509 -noout -dates -subject -issuer 2>/dev/null)

  if [[ -z "$info" ]]; then
    echo "ERROR: could not retrieve certificate for ${host}:${port}" >&2
    return 1
  fi

  echo "$info"

  local expiry expiry_ts now_ts days
  expiry=$(echo "$info" | grep notAfter | cut -d= -f2)
  expiry_ts=$(date -j -f "%b %d %H:%M:%S %Y %Z" "$expiry" +%s)
  now_ts=$(date +%s)
  days=$(( (expiry_ts - now_ts) / 86400 ))

  if (( days < 0 )); then
    echo "\n⚠️  EXPIRED ${days#-} days ago"
  elif (( days <= 14 )); then
    echo "\n⚠️  Expires in ${days} days"
  else
    echo "\n✓  Expires in ${days} days"
  fi
}
