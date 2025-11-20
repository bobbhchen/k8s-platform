{{/*
Render a simple Ingress resource
Usage: include "common.ingress" (dict "context" $ "ingress" .Values.ingress)
*/}}
{{- define "common.ingress" -}}
{{- $ingress := .ingress -}}
{{- $context := .context -}}
{{- if $ingress.enabled }}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ include "common.fullname" $context }}
  labels:
    {{- include "common.labels" $context | nindent 4 }}
  {{- with $ingress.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  {{- if $ingress.className }}
  ingressClassName: {{ $ingress.className }}
  {{- end }}
  {{- if $ingress.tls }}
  tls:
    {{- range $ingress.tls }}
    - hosts:
        {{- range .hosts }}
        - {{ . | quote }}
        {{- end }}
      {{- if .secretName }}
      secretName: {{ .secretName }}
      {{- end }}
    {{- end }}
  {{- end }}
  rules:
    {{- range $ingress.hosts }}
    - host: {{ .host | quote }}
      http:
        paths:
          {{- range .paths }}
          - path: {{ .path }}
            pathType: {{ .pathType | default "Prefix" }}
            backend:
              service:
                name: {{ .serviceName }}
                port:
                  {{- if .servicePort }}
                  number: {{ .servicePort }}
                  {{- else if .servicePortName }}
                  name: {{ .servicePortName }}
                  {{- end }}
          {{- end }}
    {{- end }}
{{- end }}
{{- end }}
