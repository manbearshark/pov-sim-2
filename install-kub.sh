helm repo add grafana https://grafana.github.io/helm-charts &&
  helm repo update &&
  helm upgrade --install --rollback-on-failure --timeout 300s grafana-k8s-monitoring grafana/k8s-monitoring \
    --namespace "povsim" --create-namespace --values - <<'EOF'
cluster:
  name: sample-chart-sample-chart-7f4fb5f84-sghk4
destinations:
  - name: grafana-cloud-metrics
    type: prometheus
    url: https://prometheus-prod-67-prod-us-west-0.grafana.net./api/prom/push
    auth:
      type: basic
      username: "2939661"
      password: glc_eyJvIjoiMTY1MjM4NiIsIm4iOiJzdGFjay0xNTA3NzE0LWludGVncmF0aW9uLXBvdnNpbWt1Yi1wb3ZzaW1rdWIiLCJrIjoiMVE1b3RKMWlYUmswOTgzRjhtN3VGa005IiwibSI6eyJyIjoicHJvZC11cy13ZXN0LTAifX0=
  - name: grafana-cloud-logs
    type: loki
    url: https://logs-prod-021.grafana.net./loki/api/v1/push
    auth:
      type: basic
      username: "1465504"
      password: glc_eyJvIjoiMTY1MjM4NiIsIm4iOiJzdGFjay0xNTA3NzE0LWludGVncmF0aW9uLXBvdnNpbWt1Yi1wb3ZzaW1rdWIiLCJrIjoiMVE1b3RKMWlYUmswOTgzRjhtN3VGa005IiwibSI6eyJyIjoicHJvZC11cy13ZXN0LTAifX0=
  - name: gc-otlp-endpoint
    type: otlp
    url: https://otlp-gateway-prod-us-west-0.grafana.net./otlp
    protocol: http
    auth:
      type: basic
      username: "1507714"
      password: glc_eyJvIjoiMTY1MjM4NiIsIm4iOiJzdGFjay0xNTA3NzE0LWludGVncmF0aW9uLXBvdnNpbWt1Yi1wb3ZzaW1rdWIiLCJrIjoiMVE1b3RKMWlYUmswOTgzRjhtN3VGa005IiwibSI6eyJyIjoicHJvZC11cy13ZXN0LTAifX0=
    metrics:
      enabled: true
    logs:
      enabled: true
    traces:
      enabled: true
clusterMetrics:
  enabled: true
  opencost:
    enabled: true
    metricsSource: grafana-cloud-metrics
    opencost:
      exporter:
        defaultClusterId: sample-chart-sample-chart-7f4fb5f84-sghk4
      prometheus:
        existingSecretName: grafana-cloud-metrics-grafana-k8s-monitoring
        external:
          url: https://prometheus-prod-67-prod-us-west-0.grafana.net./api/prom
  kepler:
    enabled: true
clusterEvents:
  enabled: true
podLogs:
  enabled: true
applicationObservability:
  enabled: true
  receivers:
    otlp:
      grpc:
        enabled: true
        port: 4317
      http:
        enabled: true
        port: 4318
    zipkin:
      enabled: true
      port: 9411
alloy-metrics:
  enabled: true
  alloy:
    extraEnv:
      - name: GCLOUD_RW_API_KEY
        valueFrom:
          secretKeyRef:
            name: alloy-metrics-remote-cfg-grafana-k8s-monitoring
            key: password
      - name: CLUSTER_NAME
        value: sample-chart-sample-chart-7f4fb5f84-sghk4
      - name: NAMESPACE
        valueFrom:
          fieldRef:
            fieldPath: metadata.namespace
      - name: POD_NAME
        valueFrom:
          fieldRef:
            fieldPath: metadata.name
      - name: GCLOUD_FM_COLLECTOR_ID
        value: grafana-k8s-monitoring-$(CLUSTER_NAME)-$(NAMESPACE)-$(POD_NAME)
  remoteConfig:
    enabled: true
    url: https://fleet-management-prod-014.grafana.net
    auth:
      type: basic
      username: "1507714"
      password: glc_eyJvIjoiMTY1MjM4NiIsIm4iOiJzdGFjay0xNTA3NzE0LWludGVncmF0aW9uLXBvdnNpbWt1Yi1wb3ZzaW1rdWIiLCJrIjoiMVE1b3RKMWlYUmswOTgzRjhtN3VGa005IiwibSI6eyJyIjoicHJvZC11cy13ZXN0LTAifX0=
alloy-singleton:
  enabled: true
  alloy:
    extraEnv:
      - name: GCLOUD_RW_API_KEY
        valueFrom:
          secretKeyRef:
            name: alloy-singleton-remote-cfg-grafana-k8s-monitoring
            key: password
      - name: CLUSTER_NAME
        value: sample-chart-sample-chart-7f4fb5f84-sghk4
      - name: NAMESPACE
        valueFrom:
          fieldRef:
            fieldPath: metadata.namespace
      - name: POD_NAME
        valueFrom:
          fieldRef:
            fieldPath: metadata.name
      - name: GCLOUD_FM_COLLECTOR_ID
        value: grafana-k8s-monitoring-$(CLUSTER_NAME)-$(NAMESPACE)-$(POD_NAME)
  remoteConfig:
    enabled: true
    url: https://fleet-management-prod-014.grafana.net
    auth:
      type: basic
      username: "1507714"
      password: glc_eyJvIjoiMTY1MjM4NiIsIm4iOiJzdGFjay0xNTA3NzE0LWludGVncmF0aW9uLXBvdnNpbWt1Yi1wb3ZzaW1rdWIiLCJrIjoiMVE1b3RKMWlYUmswOTgzRjhtN3VGa005IiwibSI6eyJyIjoicHJvZC11cy13ZXN0LTAifX0=
alloy-logs:
  enabled: true
  alloy:
    extraEnv:
      - name: GCLOUD_RW_API_KEY
        valueFrom:
          secretKeyRef:
            name: alloy-logs-remote-cfg-grafana-k8s-monitoring
            key: password
      - name: CLUSTER_NAME
        value: sample-chart-sample-chart-7f4fb5f84-sghk4
      - name: NAMESPACE
        valueFrom:
          fieldRef:
            fieldPath: metadata.namespace
      - name: POD_NAME
        valueFrom:
          fieldRef:
            fieldPath: metadata.name
      - name: NODE_NAME
        valueFrom:
          fieldRef:
            fieldPath: spec.nodeName
      - name: GCLOUD_FM_COLLECTOR_ID
        value: grafana-k8s-monitoring-$(CLUSTER_NAME)-$(NAMESPACE)-alloy-logs-$(NODE_NAME)
  remoteConfig:
    enabled: true
    url: https://fleet-management-prod-014.grafana.net
    auth:
      type: basic
      username: "1507714"
      password: glc_eyJvIjoiMTY1MjM4NiIsIm4iOiJzdGFjay0xNTA3NzE0LWludGVncmF0aW9uLXBvdnNpbWt1Yi1wb3ZzaW1rdWIiLCJrIjoiMVE1b3RKMWlYUmswOTgzRjhtN3VGa005IiwibSI6eyJyIjoicHJvZC11cy13ZXN0LTAifX0=
alloy-receiver:
  enabled: true
  alloy:
    extraPorts:
      - name: otlp-grpc
        port: 4317
        targetPort: 4317
        protocol: TCP
      - name: otlp-http
        port: 4318
        targetPort: 4318
        protocol: TCP
      - name: zipkin
        port: 9411
        targetPort: 9411
        protocol: TCP
    extraEnv:
      - name: GCLOUD_RW_API_KEY
        valueFrom:
          secretKeyRef:
            name: alloy-receiver-remote-cfg-grafana-k8s-monitoring
            key: password
      - name: CLUSTER_NAME
        value: sample-chart-sample-chart-7f4fb5f84-sghk4
      - name: NAMESPACE
        valueFrom:
          fieldRef:
            fieldPath: metadata.namespace
      - name: POD_NAME
        valueFrom:
          fieldRef:
            fieldPath: metadata.name
      - name: NODE_NAME
        valueFrom:
          fieldRef:
            fieldPath: spec.nodeName
      - name: GCLOUD_FM_COLLECTOR_ID
        value: grafana-k8s-monitoring-$(CLUSTER_NAME)-$(NAMESPACE)-alloy-receiver-$(NODE_NAME)
  remoteConfig:
    enabled: true
    url: https://fleet-management-prod-014.grafana.net
    auth:
      type: basic
      username: "1507714"
      password: glc_eyJvIjoiMTY1MjM4NiIsIm4iOiJzdGFjay0xNTA3NzE0LWludGVncmF0aW9uLXBvdnNpbWt1Yi1wb3ZzaW1rdWIiLCJrIjoiMVE1b3RKMWlYUmswOTgzRjhtN3VGa005IiwibSI6eyJyIjoicHJvZC11cy13ZXN0LTAifX0=
EOF
