#!/bin/bash

# Cargar las variables de entorno desde el archivo .env
if [ -f .env ]; then
  source .env
else
  echo ".env file not found!"
  exit 1
fi

# Crear el secreto en Kubernetes
echo "Creando secreto en Kubernetes..."
kubectl create secret docker-registry $REGISTRY_SECRET \
  --docker-server=$GHCR_SERVER \
  --docker-username=$GHCR_USERNAME \
  --docker-password=$GHCR_PASSWORD \
  --docker-email=$GHCR_EMAIL --dry-run=client -o yaml | kubectl apply -f -

# Verificar que el secreto fue creado
echo "Verificando secreto..."
kubectl get secrets $REGISTRY_SECRET

# Iniciar sesión en GitHub Container Registry
echo "Iniciando sesión en GHCR..."
echo $GHCR_PASSWORD | docker login $GHCR_SERVER -u $GHCR_USERNAME --password-stdin

# Subir imagen a GHCR
echo "Subiendo imagen a GHCR..."
docker push $IMAGE_NAME

# Aplicar configuración de Kubernetes
echo "Aplicando Deployment y Service..."
kubectl apply -f tfg_1/k8s/deployment.yaml
kubectl apply -f tfg_1/k8s/service.yaml

# Exponer el servicio en Minikube
echo "Exponiendo el servicio..."
minikube service flask-tienda-service


