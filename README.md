# Implantación de un sistema CI/CD para una aplicación basada en contenedores.

Este proyecto implementa un sistema de Integración y Despliegue Continuo (CI/CD) para una aplicación basada en contenedores.

## Estructura del Proyecto

```bash
tfg_1/
├── aplicacion/
│   ├── app.py                         # Tu aplicación Flask principal
│   ├── config.py                      # Configuración de la app Flask
│   ├── forms.py                       # Formulario de la aplicación
│   ├── inicializacion_datos.py        # Inicialización de datos de la app
│   ├── __init__.py                    # Inicialización del módulo Flask
│   ├── login.py                       # Funcionalidad de login
│   ├── models.py                      # Modelos de base de datos
│   ├── static/                         # Archivos estáticos
│   │   ├── css/
│   │   │   └── style.css
│   │   └── upload/
│   │       └── [archivos de imágenes]
│   └── templates/                      # Plantillas HTML
│       └── [plantillas de la app]
├── Dockerfile                          # Dockerfile para contenerizar la app
├── .dockerignore                       # Archivos a excluir del contenedor Docker
├── requirements.txt                    # Dependencias de la app Flask
├── .github/
│   └── workflows/
│       └── ci-cd.yml                    # Workflow de GitHub Actions
├── k8s/
│   ├── deployment.yaml                 # Configuración de Kubernetes para desplegar la app
│   ├── service.yaml                    # Configuración de servicio en Kubernetes
│   ├── prometheus-flask-exporter.yaml  # Configuración de Kubernetes para el exporter de métricas Flask
│   └── elk/
│       ├── deployment.yaml             # Despliegue de Elasticsearch, Kibana y Logstash
│       ├── service.yaml                # Servicios de Elasticsearch, Kibana y Logstash
│       ├── elasticsearch-pvc.yaml      # PersistentVolumeClaim para Elasticsearch
│       ├── deployment-logstash.yaml    # Despliegue de Logstash
│       ├── service-logstash.yaml       # Servicio de Logstash
│       ├── deployment-kibana.yaml      # Despliegue de Kibana
│       ├── service-kibana.yaml         # Servicio de Kibana
├── helm/
│   ├── prometheus/
│   │   └── values.yaml                 # Configuración de Helm para Prometheus
│   ├── grafana/
│   │   └── values.yaml                 # Configuración de Helm para Grafana
├── deploy.sh                           # Script para automatizar el despliegue de la app y ELK
└── README.md                           # Descripción del proyecto

```
## Configuración de Self-hosted Runner en GitHub y Creación de Secretos en Kubernetes

### Configuración del Self-hosted Runner en GitHub
#### Paso 1: Crear un Nuevo Self-hosted Runner
En GitHub, navega a la página principal del repositorio.
Haz clic en Configuración.
En la barra lateral izquierda, haz clic en Actions y luego en Runners.
Haz clic en New Self-hosted runner.
Sigue las instrucciones para descargar y configurar el ejecutor en tu máquina.
#### Paso 2: Registrar el Self-hosted Runner
Ejecuta el script proporcionado por GitHub para registrar el ejecutor.
### Verifica que el ejecutor esté registrado correctamente en la sección de ejecutores del repositorio.
Creación de Secretos en Kubernetes
#### Paso 1: Crear el Secreto de Registro de Docker
Ejecuta el siguiente comando para crear un secreto de registro de Docker:
```bash
kubectl create secret docker-registry github-registry-secret \
  --docker-server=ghcr.io \
  --docker-username="USER" \
  --docker-password="GHCR_TOKEN" \
  --docker-email="EMAIL"
```
Paso 2: Verificar el Secreto
Ejecuta el siguiente comando para verificar que el secreto se haya creado correctamente:

```bash
kubectl get secrets github-registry-secret
```
