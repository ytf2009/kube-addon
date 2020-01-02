{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "common.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "common.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "common.chart.name" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Create a default fully qualified chart name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "common.containers.name" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s" $name -}}
{{- end -}}

{{- define "init-install-shell" -}}
- name: "init-install-shell"
  image: "{{ .Values.global.imageRepositoryName }}/{{ .Values.initInstallContainersImage }}"
  imagePullPolicy: {{ .Values.imagePullPolicy | quote }}
  command:
  - sh
  - -xc
  - |
    echo "download--qloudkernel.sh"

    {{- if .Values.imageTag }}
    curl http://qlouddeployer:8888/repository/raw?path={{ .Values.imageRepository }}/{{ .Values.imageTag }}/deploy.tgz  -o deploy.tgz
    {{- else }}
    curl http://qlouddeployer:8888/repository/raw?path={{ .Values.imageRepository }}/{{.Chart.AppVersion}}/deploy.tgz  -o deploy.tgz
    {{- end }}
    tar -zxvf deploy.tgz  && cd deploy/ && bash install.sh
    cd ..
    rm -r deploy.tgz  deploy
    echo "install is ok"
{{- end -}}
