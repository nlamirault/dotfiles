#!/bin/zsh

function ai-agentic() {
  ln -s "${HOME}/Projects/agentic/.rules" .rules
  ln -s "${HOME}/Projects/agentic/.rules" .clinerules
  ln -s "${HOME}/Projects/agentic/AGENTS.md" AGENTS.md
  ln -s "${HOME}/Projects/agentic/AGENTS.md" CLAUDE.md
  mkdir -p .kiro/steering/
  # ln -s "${HOME}/Projects/agentic/AGENTS.md" .kiro/steering
  ln -s "${HOME}/Projects/agentic/.mcp.json" "${HOME}/.mcp.json"
  ln -s "${HOME}/Projects/agentic/.mcp.json" "${HOME}/.gemini/antigravity/mcp_config.json"
}

# function ai-claude() {
#   local env_vars=(
#     "CLAUDE_CODE_ENABLE_TELEMETRY=0"
#     "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=true"
#   )

#   local claude_args=("") # ("--dangerously-skip-permissions")
#   claude_args+=("$@")
#   env "${env_vars[@]}" "claude" "${claude_args[@]}"
# }

function ai-claude-otel() {
  log_info "[Claude] Setting up OpenTelemetry environment"

  export CLAUDE_CODE_ENABLE_TELEMETRY=1

  export OTEL_RESOURCE_ATTRIBUTES="env=production,department=engineering,team=sre,ai=claude"

  export OTEL_LOGS_EXPORTER=console,otlp
  export OTEL_METRICS_EXPORTER=console,otlp
  export OTEL_TRACES_EXPORTER=console,otlp

  # export OTEL_EXPORTER_OTLP_PROTOCOL=http/protobuf # http/json
  export OTEL_EXPORTER_OTLP_PROTOCOL=grpc
  # export OTEL_EXPORTER_OTLP_LOGS_PROTOCOL=http/protobuf # grpc, http/json
  # export OTEL_EXPORTER_OTLP_METRICS_PROTOCOL=http/protobuf # grpc, http/json
  # export OTEL_EXPORTER_OTLP_TRACES_PROTOCOL=http/protobuf # grpc, http/json

  log_info "[Claude] Use local OpenTelemetry Collector"
  export OTEL_EXPORTER_OTLP_ENDPOINT=http://127.0.0.1:4317 # gRPC
  # export OTEL_EXPORTER_OTLP_ENDPOINT=http://127.0.0.1:4318 # HTTP
  # export OTEL_EXPORTER_OTLP_LOGS_ENDPOINT=http://127.0.0.1:4318/v1/logs
  # export OTEL_EXPORTER_OTLP_METRICS_ENDPOINT=http://127.0.0.1:4318/v1/metrics
  # export OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=http://127.0.0.1:4318/v1/traces

  # log_info "[Claude] Use Langsmith"
  # export OTEL_EXPORTER_OTLP_LOGS_ENDPOINT=https://api.smith.langchain.com/otel/v1/claude_code
  # export OTEL_EXPORTER_OTLP_HEADERS="x-api-key=${langsmith_api_key},Langsmith-Project=${langsmith_project}"

  # log_info "[Claude] Use Grafana Cloud"
  # export OTEL_EXPORTER_OTLP_ENDPOINT="https://otlp-gateway-prod-eu-west-0.grafana.net/otlp"
  # export OTEL_EXPORTER_OTLP_HEADERS="Authorization=Basic%20${GRAFANA_CLOUD_AI_TOKEN}"

  log_final "[Claude] Open Telemetry configured"
  # env|grep OTEL

  # For debugging: reduce export intervals
  export OTEL_METRIC_EXPORT_INTERVAL=10000 # 10 seconds (default: 60000ms)
  export OTEL_LOGS_EXPORT_INTERVAL=5000    # 5 seconds (default: 5000ms)

  export OTEL_LOG_USER_PROMPTS=1
  export OTEL_LOG_TOOL_DETAILS=1
  export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=true

  # local env_vars=(
  #   "CLAUDE_CODE_ENABLE_TELEMETRY=1"
  #   "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=true"
  # )
  # local claude_args=("") # ("--dangerously-skip-permissions")
  # claude_args+=("$@")
  # env "${env_vars[@]}" "claude" "${claude_args[@]}"
}

function ai-gemini-otel() {
  log_info "[Gemini] Setting up Open Telemetry environment"

  export OTEL_RESOURCE_ATTRIBUTES="deployment.environment.name=production,deployment.environment=production,department=engineering,team=sre,ai=gemini"

  export GEMINI_TELEMETRY_ENABLED=true
  export GEMINI_TELEMETRY_TRACES_ENABLED=true
  export GEMINI_TELEMETRY_LOG_PROMPTS=true
  export GEMINI_TELEMETRY_USE_COLLECTOR=true
  export GEMINI_TELEMETRY_TARGET=local

  # For debugging: reduce export intervals
  export OTEL_METRIC_EXPORT_INTERVAL=10000 # 10 seconds (default: 60000ms)
  export OTEL_METRIC_EXPORT_TIMEOUT=10000
  export OTEL_LOGS_EXPORT_INTERVAL=5000    # 5 seconds (default: 5000ms)
  export OTEL_LOGS_EXPORT_TIMEOUT=5000

  log_info "[Gemini] Use local OpenTelemetry Collector"

  # export OPENCODE_OTLP_PROTOCOL=grpc
  # export OTEL_EXPORTER_OTLP_ENDPOINT=http://127.0.0.1:4317 # gRPC

  export OTEL_EXPORTER_OTLP_ENDPOINT=http://127.0.0.1:4318 # HTTP
  # export OTEL_EXPORTER_OTLP_LOGS_ENDPOINT=http://127.0.0.1:4318/v1/logs
  # export OTEL_EXPORTER_OTLP_METRICS_ENDPOINT=http://127.0.0.1:4318/v1/metrics
  # export OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=http://127.0.0.1:4318/v1/traces
  export OTEL_EXPORTER_OTLP_PROTOCOL=http/protobuf

  export GEMINI_TELEMETRY_OTLP_ENDPOINT="${OTEL_EXPORTER_OTLP_ENDPOINT}"
  export GEMINI_TELEMETRY_OTLP_PROTOCOL="${OTEL_EXPORTER_OTLP_PROTOCOL}"

  # log_info "[Gemini] Use Langsmith"
  # export GEMINI_TELEMETRY_OTLP_ENDPOINT=https://api.smith.langchain.com/otel
  # export GEMINI_TELEMETRY_LOG_PROMPTS=true
  # export OTEL_EXPORTER_OTLP_HEADERS="x-api-key=${langsmith_api_key},Langsmith-Project=${langsmith_project}"

  log_final "[Gemini] Open Telemetry configured"
  # env|grep OTEL

  # gemini_args+=("$@")
  # gemini "${gemini_args[@]}"
}

function ai-opencode-otel() {
  log_info "[OpenCode] Setting up Open Telemetry environment"

  export OPENCODE_ENABLE_TELEMETRY=1
  export OTEL_RESOURCE_ATTRIBUTES="deployment.environment.name=production,deployment.environment=production,department=engineering,team=sre,ai=opencode"

  log_info "[Gemini] Use local OpenTelemetry Collector"

  # export OTEL_EXPORTER_OTLP_PROTOCOL=grpc
  # export OTEL_EXPORTER_OTLP_ENDPOINT=http://127.0.0.1:4317 # gRPC

  export OTEL_EXPORTER_OTLP_ENDPOINT=http://127.0.0.1:4318 # HTTP
  # export OTEL_EXPORTER_OTLP_LOGS_ENDPOINT=http://127.0.0.1:4318/v1/logs
  # export OTEL_EXPORTER_OTLP_METRICS_ENDPOINT=http://127.0.0.1:4318/v1/metrics
  # export OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=http://127.0.0.1:4318/v1/traces
  export OTEL_EXPORTER_OTLP_PROTOCOL=http/protobuf

  export OPENCODE_OTLP_ENDPOINT="${OTEL_EXPORTER_OTLP_ENDPOINT}"
  export OPENCODE_OTLP_PROTOCOL="${OTEL_EXPORTER_OTLP_PROTOCOL}"
  export OPENCODE_RESOURCE_ATTRIBUTES="${OTEL_RESOURCE_ATTRIBUTES}"

  # export OPENCODE_OTLP_ENDPOINT="https://ingest.us.signoz.cloud:443"
  # export OPENCODE_OTLP_HEADERS="signoz-ingestion-key=<your-ingestion-key>"
}

function ai-qwen-otel() {
  log_info "[Qwen] Setting up OpenTelemetry environment"

  export OTEL_RESOURCE_ATTRIBUTES="deployment.environment.name=production,deployment.environment=production,department=engineering,team=sre,ai=qwen"
  export OTEL_SERVICE_NAME="qwen-code"

  log_info "[Qwen] Use local OpenTelemetry Collector"
  # Qwen Code is configured via ~/.qwen/settings.json:
  #   {
  #     "telemetry": {
  #       "enabled": true,
  #       "otlpProtocol": "grpc",
  #       "otlpEndpoint": "http://127.0.0.1:4317"
  #     }
  #   }
  export OTEL_EXPORTER_OTLP_ENDPOINT=http://127.0.0.1:4317 # gRPC
  export OTEL_EXPORTER_OTLP_PROTOCOL=grpc

  # For debugging: reduce export intervals
  export OTEL_METRIC_EXPORT_INTERVAL=10000 # 10 seconds (default: 60000ms)
  export OTEL_LOGS_EXPORT_INTERVAL=5000    # 5 seconds

  # log_info "[Qwen] Use SigNoz Cloud"
  # export OTEL_EXPORTER_OTLP_ENDPOINT="https://ingest.<region>.signoz.cloud:443"
  # export OTEL_EXPORTER_OTLP_HEADERS="signoz-ingestion-key=<your-ingestion-key>"

  log_final "[Qwen] Open Telemetry configured"
}

function ai-grok-otel() {
  log_info "[Grok] Setting up OpenTelemetry environment"

  export OTEL_RESOURCE_ATTRIBUTES="deployment.environment.name=production,deployment.environment=production,department=engineering,team=sre,ai=grok"

  # Master switch + at least one exporter (either alone emits nothing)
  export GROK_EXTERNAL_OTEL=1
  export OTEL_METRICS_EXPORTER=otlp
  export OTEL_LOGS_EXPORTER=otlp

  log_info "[Grok] Use local OpenTelemetry Collector"
  # WARNING: grpc fails silently in grok 1.0.3, must use http/protobuf
  export OTEL_EXPORTER_OTLP_PROTOCOL=http/protobuf
  export OTEL_EXPORTER_OTLP_ENDPOINT=http://127.0.0.1:4318 # HTTP

  # For debugging: reduce export intervals
  export OTEL_METRIC_EXPORT_INTERVAL=10000 # 10 seconds (default: 60000ms)

  # log_info "[Grok] Use SigNoz Cloud"
  # export OTEL_EXPORTER_OTLP_ENDPOINT="https://ingest.<region>.signoz.cloud:443"
  # export OTEL_EXPORTER_OTLP_HEADERS="signoz-ingestion-key=<your-ingestion-key>"

  log_final "[Grok] Open Telemetry configured"
}

function ai-cmux() {
  cmux new-workspace --cwd ${HOME}/Projects/Pilotariak/website --name pilotariak
  cmux new-workspace --cwd ${HOME}/Projects/Pilotariak/xilo --name xilo
  cmux new-workspace --cwd ${HOME}/Projects/Pilotariak/kancha --name kancha
  cmux new-workspace --cwd ${HOME}/Projects/Pilotariak/frontis --name frontis
  cmux new-workspace --cwd ${HOME}/Projects/Portefaix/ --name portefaix-misc
  cmux new-workspace --cwd ${HOME}/Projects/Portefaix/portefaix-infrastructure --name portefaix-infra
  cmux new-workspace --cwd ${HOME}/Projects/Portefaix/portefaix-kubernetes --name portefaix-k8s
  cmux new-workspace --cwd ${HOME}/Projects/openspec-hub --name openspec
  cmux new-workspace --cwd ${HOME}/Projects/Divona/divona-agent --name divona
  cmux new-workspace --cwd ${HOME}/Projects/agentic --name agentic
  cmux new-workspace --cwd ${HOME}/Projects/dotfiles --name dotfiles
  cmux new-workspace --cwd ${HOME}/Projects
}

function claude-glm() {
  export ANTHROPIC_BASE_URL="https://api.z.ai/api/anthropic"
  export ANTHROPIC_AUTH_TOKEN="${Z_AI_API_KEY}"
  glm_model="glm-5.2[1m]"
  export ANTHROPIC_DEFAULT_OPUS_MODEL="${glm_model}"
  export ANTHROPIC_DEFAULT_SONNET_MODEL="${glm_model}"
  export ANTHROPIC_DEFAULT_HAIKU_MODEL="${glm_model}"
  export ANTHROPIC_DEFAULT_FABLE_MODEL="${glm_model}"
  export CLAUDE_CODE_SUBAGENT_MODEL="${glm_model}"
  export CLAUDE_CODE_AUTO_COMPACT_WINDOW="1000000"
  claude "$@"
}

function claude-kimi() {
  export ANTHROPIC_BASE_URL="https://api.moonshot.ai/anthropic"
  export ANTHROPIC_AUTH_TOKEN="${MOONSHOT_API_KEY}"
  kimi_model="kimi-k3[1m]"
  export ANTHROPIC_MODEL="${kimi_model}"
  export ANTHROPIC_DEFAULT_OPUS_MODEL="${kimi_model}"
  export ANTHROPIC_DEFAULT_SONNET_MODEL="${kimi_model}"
  export ANTHROPIC_DEFAULT_HAIKU_MODEL="${kimi_model}"
  export ANTHROPIC_DEFAULT_FABLE_MODEL="${kimi_model}"
  export CLAUDE_CODE_SUBAGENT_MODEL="${kimi_model}"
  export CLAUDE_CODE_AUTO_COMPACT_WINDOW="1048576"
  export CLAUDE_CODE_EFFORT_LEVEL="max"
  claude "$@"
}

function claude-huggingface() {
  export ANTHROPIC_BASE_URL="https://router.huggingface.co"
  export ANTHROPIC_AUTH_TOKEN="${HF_TOKEN}"
  export ANTHROPIC_API_KEY="${HF_TOKEN}"
  # choose here: https://huggingface.co/inference/models
  hf_model="deepseek-ai/DeepSeek-V4-Pro-0813:fireworks-ai"
  export ANTHROPIC_MODEL="${hf_model}"
  export ANTHROPIC_DEFAULT_OPUS_MODEL="${hf_model}"
  export ANTHROPIC_DEFAULT_SONNET_MODEL="${hf_model}"
  export ANTHROPIC_DEFAULT_HAIKU_MODEL="${hf_model}"
  export CLAUDE_CODE_SUBAGENT_MODEL="${hf_model}"
  claude "$@"
}
