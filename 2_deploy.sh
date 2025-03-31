#!/bin/bash

# Definir las variables
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

# Construir la imagen de Docker si no existe
echo "Construyendo imagen de Docker..."
docker build -t $IMAGE_NAME .

# Subir la imagen a GHCR
echo "Subiendo imagen a GHCR..."
docker push $IMAGE_NAME

# Aplicar la configuración de Kubernetes para la aplicación Flask
echo "Aplicando Deployment y Service para Flask App..."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

# Aplicar la configuración de Kubernetes para Grafana
echo "Aplicando Deployment y Service para Grafana..."
kubectl apply -f k8s/grafana/deployment.yaml
kubectl apply -f k8s/grafana/service.yaml

# Aplicar la configuración de Kubernetes para Prometheus
echo "Aplicando Deployment y Service para Prometheus..."
kubectl apply -f k8s/prometheus/deployment.yaml
kubectl apply -f k8s/prometheus/service.yaml

# Aplicar la configuración de Kubernetes para ELK (Elasticsearch, Logstash y Kibana)
echo "Aplicando Deployment y Service para ELK..."
kubectl apply -f k8s/elk/elasticsearch-deployment.yaml
kubectl apply -f k8s/elk/elasticsearch-service.yaml
kubectl apply -f k8s/elk/logstash-deployment.yaml
kubectl apply -f k8s/elk/logstash-service.yaml
kubectl apply -f k8s/elk/kibana-deployment.yaml
kubectl apply -f k8s/elk/kibana-service.yaml

# Exponer el servicio de la aplicación Flask en Minikube
echo "Exponiendo el servicio de Flask en Minikube..."
minikube service flask-tienda-service

# Exponer el servicio de Grafana en Minikube
echo "Exponiendo el servicio de Grafana en Minikube..."
minikube service grafana-service

# Exponer el servicio de Prometheus en Minikube
echo "Exponiendo el servicio de Prometheus en Minikube..."
minikube service prometheus-service

# Verificar el estado de los pods
echo "Verificando los pods..."
kubectl get pods

# Verificar el estado de los servicios
echo "Verificando los servicios..."
kubectl get services

# Exponer el servicio en Minikube nuevamente
echo "Exponiendo el servicio en Minikube nuevamente..."
minikube service flask-tienda-service
