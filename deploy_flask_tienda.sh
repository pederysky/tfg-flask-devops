#!/bin/bash

# Definir las variables
GHCR_SERVER="ghcr.io"
GHCR_USERNAME="pederysky"
GHCR_PASSWORD="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"
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

# Aplicar la configuración de Kubernetes (Deployment y Service)
echo "Aplicando Deployment y Service..."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

# Exponer el servicio en Minikube
echo "Exponiendo el servicio en Minikube..."
minikube service flask-tienda-service

# Verificar el estado de los pods
echo "Verificando los pods..."
kubectl get pods

# Verificar el estado de los servicios
echo "Verificando los servicios..."
kubectl get services

# Exponer el servicio en Minikube nuevamente
echo "Exponiendo el servicio en Minikube nuevamente..."
minikube service flask-tienda-service
