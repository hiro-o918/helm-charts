{{/*
Expand the name of the chart.
*/}}
{{- define "redash-searcher.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "redash-searcher.fullname" -}}
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

{{/*
Create redash-searcher web server name and version as used by the chart label.
*/}}
{{- define "redash-searcher.web.fullname" -}}
{{- printf "%s-%s" (include "redash-searcher.fullname" .) .Values.web.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create redash-searcher sync server name and version as used by the chart label.
*/}}
{{- define "redash-searcher.sync.fullname" -}}
{{- printf "%s-%s" (include "redash-searcher.fullname" .) .Values.sync.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "redash-searcher.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "redash-searcher.labels" -}}
helm.sh/chart: {{ include "redash-searcher.chart" . }}
{{ include "redash-searcher.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "redash-searcher.selectorLabels" -}}
app.kubernetes.io/name: {{ include "redash-searcher.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the server service account to use
*/}}
{{- define "redash-searcher.web.serviceAccountName" -}}
{{- if .Values.web.serviceAccount.create -}}
    {{ default (include "redash-searcher.web.fullname" .) .Values.web.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.web.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Set redash public url for web server
*/}}
{{- define "redash-searcher.web.redashPublicUrl" -}}
{{- if .Values.redash.publicUrl }}
    {{- .Values.redash.publicUrl }}
{{- else }}
    {{- .Values.redash.url }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the sync service account to use
*/}}
{{- define "redash-searcher.sync.serviceAccountName" -}}
{{- if .Values.sync.serviceAccount.create -}}
    {{ default (include "redash-searcher.sync.fullname" .) .Values.sync.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.sync.serviceAccount.name }}
{{- end -}}
{{- end -}}
