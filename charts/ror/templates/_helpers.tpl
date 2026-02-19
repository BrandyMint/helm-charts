{{/*
Expand the name of the chart.
*/}}
{{- define "ror.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ror.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "ror.jobProcessingName" -}}
{{- printf "%s-%s" .Release.Name "job-processing" | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ror.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ror.labels" -}}
helm.sh/chart: {{ include "ror.chart" . }}
{{ include "ror.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ror.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ror.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ror.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ror.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Generate envs list from Values.env and Values.envMap
*/}}
{{- define "ror.env" -}}
{{- with .env }}
{{- toYaml .  }}
{{- end }}
{{- range $key, $value := .envMap }}
- name: {{ $key | quote }}
  value: {{ $value | quote }}
{{- end }}
{{- end }}

{{/*
Merge two envMap dicts (base + override) and render as env vars.
Override keys take precedence over base keys, eliminating duplicates.
Usage: include "ror.mergedEnvMap" (dict "base" .Values.envMap "override" .Values.jobsProcessing.envMap)
*/}}
{{- define "ror.mergedEnvMap" -}}
{{- $merged := dict }}
{{- range $key, $value := .base }}
  {{- $_ := set $merged $key $value }}
{{- end }}
{{- range $key, $value := .override }}
  {{- $_ := set $merged $key $value }}
{{- end }}
{{- range $key, $value := $merged }}
- name: {{ $key | quote }}
  value: {{ $value | quote }}
{{- end }}
{{- end }}
