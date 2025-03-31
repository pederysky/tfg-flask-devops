#!/bin/bash

set -e  # Detiene el script si hay un error

# Definir las variables
GHCR_SERVER="ghcr.io"
GHCR_USERNAME="pederysky"
GHCR_PASSWORD="Aqui va el GHCR_TOKEN"
GHCR_EMAIL="pedroegeaortega@gmail.com"
IMAGE_NAME="ghcr.io/pederysky/tfg_1/flask_tienda:latest"

echo "=====> Eliminando secreto anterior (si existe)..."
kubectl delete secret github-registry-secret --ignore-not-found=true

echo "=====> Creando nuevo secreto en Kubernetes..."
kubectl create secret docker-registry github-registry-secret \
  --docker-server=$GHCR_SERVER \
  --docker-username=$GHCR_USERNAME \
  --docker-password=$GHCR_PASSWORD \
  --docker-email=$GHCR_EMAIL

echo "=====> Verificando secreto..."
kubectl get secrets github-registry-secret

echo "=====> Iniciando sesión en GHCR..."
echo $GHCR_PASSWORD | docker login $GHCR_SERVER -u $GHCR_USERNAME --password-stdin

echo "=====> Construyendo imagen de Docker..."
docker build -t $IMAGE_NAME .

echo "=====> Subiendo imagen a GHCR..."
docker push $IMAGE_NAME

# Aplicar la configuración de Kubernetes para la aplicación Flask
echo "=====> Aplicando Deployment y Service para Flask App..."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

# Aplicar la configuración de Kubernetes para Prometheus y Grafana
echo "=====> Aplicando Deployment y Service para Prometheus y Grafana..."
kubectl apply -f k8s/prometheus-flask-exporter.yaml
kubectl apply -f k8s/grafana/service.yaml
kubectl apply -f k8s/grafana/deployment.yaml
kubectl apply -f k8s/prometheus/service.yaml
kubectl apply -f k8s/prometheus/deployment.yaml

# Aplicar la configuración de Kubernetes para ELK (Elasticsearch, Logstash y Kibana)
echo "=====> Aplicando PersistentVolumeClaim para Elasticsearch..."
kubectl apply -f k8s/elk/elasticsearch-pvc.yaml

echo "=====> Aplicando Deployment y Service para Elasticsearch..."
kubectl apply -f k8s/elk/deployment.yaml
kubectl apply -f k8s/elk/service.yaml

# Esperar a que Elasticsearch esté listo antes de continuar
echo "=====> Esperando a que Elasticsearch esté listo..."
kubectl wait --for=condition=available --timeout=300s deployment/elasticsearch

echo "=====> Aplicando Deployment y Service para Logstash..."
kubectl apply -f k8s/elk/deployment-logstash.yaml
kubectl apply -f k8s/elk/service-logstash.yaml

echo "=====> Aplicando Deployment y Service para Kibana..."
kubectl apply -f k8s/elk/deployment-kibana.yaml
kubectl apply -f k8s/elk/service-kibana.yaml

# Exponer servicios en Minikube (opcional)
if command -v minikube &> /dev/null; then
    echo "=====> Exponiendo servicios en Minikube..."
    minikube service flask-tienda-service
    minikube service grafana-service
    minikube service prometheus-service
fi

# Verificar estado final
echo "=====> Verificando el estado de los pods..."
kubectl get pods

echo "=====> Verificando el estado de los servicios..."
kubectl get services

echo "=====> Despliegue completado con éxito 🎉"

# Exponer el servicio en Minikube nuevamente
echo "Exponiendo el servicio en Minikube nuevamente..."
minikube service flask-tienda-service
