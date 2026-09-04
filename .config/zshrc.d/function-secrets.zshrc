#!/usr/bin/env zsh

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

# Infisical configuration
INFISICAL_PROJECT_ID=${INFISICAL_PROJECT_ID:-""}
INFISICAL_ENVIRONMENT=${INFISICAL_ENVIRONMENT:-"prod"}

function _infisical_validate() {
  if [[ -z "${INFISICAL_PROJECT_ID}" ]]; then
    log_error "[secrets] INFISICAL_PROJECT_ID environment variable must be set"
    return 1
  fi

  if ! command -v infisical >/dev/null 2>&1; then
    log_error "[secrets] Infisical CLI not found. Please install it first."
    return 1
  fi

  log_info "[infisical] Authentication"
  if ! infisical secrets --projectId="${INFISICAL_PROJECT_ID}" --env="${INFISICAL_ENVIRONMENT}" --path="/" --silent >/dev/null 2>&1; then
    log_error "[secrets] Failed to authenticate with Infisical. Run: infisical login"
    return 1
  fi
}

function _infisical_get_secret() {
  local secret_name="$1"
  local infisical_path="${2:-/}"
  local var_name="$3"

  local secret_value
  log_info "[secrets] Retrieve secret: ${secret_name}"
  secret_value=$(infisical secrets get "${secret_name}" \
    --projectId="${INFISICAL_PROJECT_ID}" \
    --env="${INFISICAL_ENVIRONMENT}" \
    --path="${infisical_path}" \
    --silent --plain)

  if [[ $? -ne 0 ]] || [[ -z "${secret_value}" ]]; then
    log_error "[secrets] Failed to retrieve ${secret_name} from ${infisical_path}"
    return 1
  fi

  log_debug "[secrets] Retrieved ${secret_name} from ${infisical_path}"
  export "${var_name}=${secret_value}"
}

function ai-credentials() {
  log_info "[secrets] Loading AI secrets from Infisical"

  _infisical_validate || return 1
  _infisical_get_secret "GEMINI_API_KEY" "/google-cloud" "GEMINI_API_KEY" || return 1
  _infisical_get_secret "OPENCODE_GEMINI_PROJECT_ID" "/google-cloud" "OPENCODE_GEMINI_PROJECT_ID" || return 1
  _infisical_get_secret "MOONSHOT_API_KEY" "/kimi" "MOONSHOT_API_KEY" || return 1
  # _infisical_get_secret "ANTHROPIC_API_KEY" "/anthropic" "ANTHROPIC_API_KEY" || return 1
  _infisical_get_secret "ANTHROPIC_PRO_API_KEY" "/anthropic" "ANTHROPIC_API_KEY" || return 1
  _infisical_get_secret "ANTHROPIC_ADMIN_KEY" "/anthropic" "ANTHROPIC_ADMIN_KEY" || return 1
  _infisical_get_secret "HF_TOKEN" "/huggingface" "HF_TOKEN" || return 1
  _infisical_get_secret "MISTRAL_API_KEY" "/mistral" "MISTRAL_API_KEY" || return 1
  _infisical_get_secret "NVIDIA_API_KEY" "/nvidia" "NVIDIA_API_KEY" || return 1
  _infisical_get_secret "OPENAI_API_KEY" "/openai" "OPENAI_API_KEY" || return 1
  _infisical_get_secret "OPENROUTER_API_KEY" "/openrouter" "OPENROUTER_API_KEY" || return 1

  log_final "[secrets] AI secrets loaded"
}
