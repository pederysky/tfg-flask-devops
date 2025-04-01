#!/bin/bash

# Agregar los repositorios de Prometheus y Grafana
echo "Agregando repositorios de Helm..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts

# Actualizar los repositorios
echo "Actualizando repositorios de Helm..."
helm repo update

# Instalar Prometheus
echo "Instalando Prometheus..."
helm upgrade --install prometheus prometheus-community/kube-prometheus-stack --values helm/prometheus/values.yaml

# Instalar Grafana
echo "Instalando Grafana..."
helm upgrade --install grafana grafana/grafana --values helm/grafana/values.yaml

# Verificar los pods desplegados
echo "Verificando los pods desplegados..."
kubectl get pods
