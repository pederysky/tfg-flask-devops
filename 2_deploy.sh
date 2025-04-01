#!/bin/bash

# Definir variables
GHCR_SERVER="ghcr.io"
GHCR_USERNAME="pederysky"
GHCR_PASSWORD="Aqui va el GHCR_TOKEN"
GHCR_EMAIL="pedroegeaortega@gmail.com"
IMAGE_NAME="ghcr.io/pederysky/tfg_1/flask_tienda:latest"

# Eliminar el secreto si ya existe
echo "Eliminando secreto anterior (si existe)..."
kubectl delete secret github-registry-secret --ignore-not-found=true

# Crear el secreto en Kubernetes
echo "Creando secreto en Kubernetes..."
kubectl create secret docker-registry github-registry-secret \
  --docker-server=$GHCR_SERVER \
  --docker-username=$GHCR_USERNAME \
  --docker-password=$GHCR_PASSWORD \
  --docker-email=$GHCR_EMAIL

# Verificar que el secreto fue creado
echo "Verificando secreto..."
kubectl get secrets github-registry-secret

# Iniciar sesión en GitHub Container Registry
echo "Iniciando sesión en GHCR..."
echo $GHCR_PASSWORD | docker login $GHCR_SERVER -u $GHCR_USERNAME --password-stdin

# Construir la imagen de Docker
echo "Construyendo imagen de Docker..."
docker build -t $IMAGE_NAME .

# Subir la imagen a GHCR
echo "Subiendo imagen a GHCR..."
docker push $IMAGE_NAME

# Aplicar la configuración de Kubernetes para la aplicación Flask
echo "Aplicando Deployment y Service para Flask App..."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

# Aplicar la configuración de Prometheus
echo "Aplicando configuración de Prometheus..."
helm upgrade --install prometheus helm/prometheus --values helm/prometheus/values.yaml

# Aplicar la configuración de Grafana
echo "Aplicando configuración de Grafana..."
helm upgrade --install grafana helm/grafana --values helm/grafana/values.yaml

# Aplicar la configuración de Kubernetes para ELK (Elasticsearch, Logstash y Kibana)
echo "Aplicando Deployment y Service para ELK..."
kubectl apply -f k8s/elk/deployment.yaml
kubectl apply -f k8s/elk/service.yaml
kubectl apply -f k8s/elk/elasticsearch-pvc.yaml
kubectl apply -f k8s/elk/deployment-logstash.yaml
kubectl apply -f k8s/elk/service-logstash.yaml
kubectl apply -f k8s/elk/deployment-kibana.yaml
kubectl apply -f k8s/elk/service-kibana.yaml

# Verificar el estado de los pods
echo "Verificando los pods..."
kubectl get pods

# Verificar el estado de los servicios
echo "Verificando los servicios..."
kubectl get services

# Exponer los servicios en Minikube
echo "Exponiendo servicios en Minikube..."
minikube service flask-tienda-service
minikube service grafana
minikube service prometheus
