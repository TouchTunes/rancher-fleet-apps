{{/*
Subset of labels specific for selectors.
*/}}
{{- define "default-selector-labels" -}}
app.kubernetes.io/name: {{ .Chart.Name | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end }}

{{/*
Default helm labels.
*/}}
{{- define "default-helm-labels" -}}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}"
{{- end }}

{{/*
Default resource labels.
*/}}
{{- define "default-labels" -}}
{{ include "default-selector-labels" . }}
{{ include "default-helm-labels" . }}
{{- end }}

{{/*
Default resource metadata.
*/}}
{{- define "default-metadata" -}}
name: {{ .Release.Name | quote }}
labels: {{- include "default-labels" . | nindent 2 }}
{{- end }}

{{/*
Default selector.
*/}}
{{- define "default-selector" -}}
matchLabels: {{- include "default-selector-labels" . | nindent 2 }}
{{- end }}

{{/*
Restricted security context (allows running with restricted pod policy enforced).
*/}}
{{- define "restricted-security-context" -}}
runAsNonRoot: true
readOnlyRootFilesystem: true
allowPrivilegeEscalation: false
seccompProfile:
  type: RuntimeDefault
capabilities:
  drop: ["ALL"]
{{- end }}
