name: Build, Deploy, and Monitor Flask App with Docker and ELK

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      # Paso 1: Revisar el código
      - name: Check out code
        uses: actions/checkout@v2

      # Paso 2: Configurar Docker Buildx
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2

      # Paso 3: Iniciar sesión en GitHub Container Registry
      - name: Log in to GitHub Container Registry
        uses: docker/login-action@v2
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GHCR_TOKEN }}

      # Paso 4: Construir la imagen Docker
      - name: Build Docker image
        run: |
          docker build -t ghcr.io/${{ github.repository }}/flask_tienda:latest .

      # Paso 5: Subir la imagen Docker a GitHub Container Registry
      - name: Push Docker image
        run: |
          docker push ghcr.io/${{ github.repository }}/flask_tienda:latest

  deploy:
    runs-on: ubuntu-latest
    needs: build

    steps:
      # Paso 1: Revisar el código
      - name: Check out code
        uses: actions/checkout@v2

      # Paso 2: Instalar kubectl
      - name: Install kubectl
        run: |
          curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
          chmod +x kubectl
          sudo mv kubectl /usr/local/bin/

      # Paso 3: Configurar kubeconfig
      - name: Configure kubeconfig
        run: |
          echo "${{ secrets.KUBE_CONFIG }}" > kubeconfig.yaml
          export KUBECONFIG=$PWD/kubeconfig.yaml
          echo "KUBECONFIG=$PWD/kubeconfig.yaml" >> $GITHUB_ENV

      # Paso 4: Debug: Verificar conexión con Kubernetes
      - name: Debug kubectl config
        run: |
          echo "Verificando configuración de kubectl..."
          kubectl config view
          kubectl config current-context
          kubectl get nodes

      # Paso 5: Desplegar en Kubernetes
      - name: Deploy to Kubernetes
        run: |
          kubectl apply -f k8s/deployment.yaml
          kubectl apply -f k8s/service.yaml

      # Paso 6: Desplegar ELK Stack (solo si deseas monitoreo/logging)
      - name: Deploy ELK Stack
        run: |
          kubectl apply -f k8s/elk/deployment.yaml
          kubectl apply -f k8s/elk/service.yaml

      # Paso 7: Esperar a que ELK Stack se inicie
      - name: Wait for ELK Stack
        run: |
          kubectl rollout status deployment/elasticsearch
          kubectl rollout status deployment/kibana
          kubectl rollout status deployment/logstash

