#!/bin/bash

set -e

echo "🔹 Verificando herramientas necesarias..."

echo -e "\n🔸 Docker Version:"
docker --version || { echo "❌ Docker no está instalado o no es accesible."; exit 1; }

echo -e "\n🔸 Docker Compose Version:"
docker compose version || { echo "❌ Docker Compose no está instalado o no es accesible."; exit 1; }

echo -e "\n🔸 kubectl Client Version:"
kubectl version --client || { echo "❌ kubectl no está instalado o no es accesible."; exit 1; }

echo -e "\n🔸 Minikube Version:"
minikube version || { echo "❌ Minikube no está instalado o no es accesible."; exit 1; }

echo -e "\n🔸 Kubernetes Full Version (Client & Server):"
kubectl version --output=yaml || echo "⚠️ No se pudo obtener la versión del servidor. ¿Está Minikube en ejecución?"

echo -e "\n🔹 Verificando requisitos del sistema..."

# Comprobar núcleos de CPU
CPU_CORES=$(nproc)
if [ "$CPU_CORES" -lt 2 ]; then
    echo "❌ Número de núcleos insuficiente: se requieren al menos 2 (actual: $CPU_CORES)"
else
    echo "✅ Núcleos de CPU: $CPU_CORES"
fi

# Comprobar memoria RAM (en MB)
TOTAL_MEM=$(free -m | awk '/^Mem:/{print $2}')
if [ "$TOTAL_MEM" -lt 4000 ]; then
    echo "❌ Memoria RAM insuficiente: se requieren al menos 4 GB (actual: $(($TOTAL_MEM / 1024)) GB)"
else
    echo "✅ Memoria RAM: $(($TOTAL_MEM / 1024)) GB"
fi

# Comprobar espacio libre en /
AVAILABLE_DISK=$(df / --output=avail | tail -1)
AVAILABLE_DISK_GB=$((AVAILABLE_DISK / 1024 / 1024))
if [ "$AVAILABLE_DISK_GB" -lt 25 ]; then
    echo "❌ Espacio en disco insuficiente en '/': se requieren al menos 25 GB (actual: ${AVAILABLE_DISK_GB} GB)"
else
    echo "✅ Espacio libre en disco: ${AVAILABLE_DISK_GB} GB"
fi

echo -e "\n✅ Comprobación finalizada."
