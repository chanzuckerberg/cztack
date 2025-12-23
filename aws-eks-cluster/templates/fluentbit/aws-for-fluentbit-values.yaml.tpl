global:

service:
  parsersFiles:
    - /fluent-bit/parsers/parsers.conf
  extraParsers: |
    [PARSER]
        Name    kubernetes
        Format  regex
        Regex   ^(?<namespace_name>[^_]+)\.(?<container_name>.+)\.(?<pod_name>[a-z0-9](?:[-a-z0-9]*[a-z0-9])?(?:\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*)\.(?<docker_id>[a-z0-9]{64})-$

input:
  name: "tail"
  enabled: true
  tag: "kube.*"
  path: "/var/log/containers/*.log"
  db: "/var/log/flb_kube.db"
  memBufLimit: 5MB
  skipLongLines: "On"
  refreshInterval: 10
  extraInputs: |
    multiline.parser  docker, cri
    Exclude_Path ${exclude_path}

additionalInputs: |
  [INPUT]
      Name systemd
      Tag host.*
      Systemd_Filter _SYSTEMD_UNIT=kubelet.service
      Read_From_Tail On

filter:
  name: "kubernetes"
  match: "kube.*"
  kubeURL: "https://kubernetes.default.svc.cluster.local:443"
  mergeLog: "On"
  mergeLogKey: "data"
  k8sLoggingParser: "On"
  k8sLoggingExclude: "On"
  bufferSize: "32k"


additionalOutputs: |
  [OUTPUT]
      Name cloudwatch_logs
      Match *
      region ${region}
      log_group_name /aws/eks/${cluster_name}/services/fallback
      log_group_template /aws/eks/${cluster_name}/services/$data['service']
      log_stream_prefix fluentbit-
      auto_create_group true
      log_retention_days 14