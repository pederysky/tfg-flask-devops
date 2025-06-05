# Implantación de un sistema CI/CD para una aplicación basada en contenedores.

Este proyecto forma parte de mi Trabajo de Fin de Grado (TFG) y tiene como objetivo diseñar e implantar un sistema completo de Integración y Despliegue Continuo (CI/CD) para una aplicación web desarrollada con Flask. 

La aplicación y su infraestructura se ejecutan en contenedores Docker y se despliegan en un clúster de Kubernetes utilizando Minikube. Además, se han incorporado herramientas de monitorización (Prometheus, Grafana) y observabilidad (ELK Stack) para asegurar la trazabilidad y supervisión del sistema.

## Requisitos previos

Para poder desplegar correctamente este proyecto en tu entorno local, necesitas tener instaladas las siguientes herramientas:

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Kubernetes](https://kubernetes.io/)
- [Minikube](https://minikube.sigs.k8s.io/)

Ejecuta el script `check_pre-requisites.sh` incluido en este repositorio para verificar que todo está correctamente instalado.

### Requisitos mínimos del sistema

Además, la máquina host debe cumplir con los siguientes requisitos mínimos (recomendados para ejecutar Minikube con Kubernetes y los contenedores del proyecto):

- **CPU:** 2 núcleos
- **Memoria RAM:** 4 GB (mínimo), idealmente 6–8 GB
- **Almacenamiento:** 25 GB libres


## Tecnologías y herramientas utilizadas

- **Flask** — Aplicación web principal
- **Docker / Docker Compose** — Contenerización
- **Kubernetes / Minikube** — Orquestación de contenedores
- **GitHub Actions** — Integración y despliegue continuo
- **Prometheus + Grafana** — Monitorización de métricas
- **ELK Stack (Elasticsearch, Logstash, Kibana)** — Observabilidad y análisis de logs


## Estructura del Proyecto

```bash
tfg-flask-devops/
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
├── check_pre-requisites.sh             # Script para comprobar si tu máquina puede desplegar el proyecto
└── README.md                           # Descripción del proyecto
└── memoria.pdf                         # Memoria del proyecto

```
## Configuración de Self-hosted Runner en GitHub y Creación de Secrets en Kubernetes

### Creación del Secret GHCR_TOKEN
El secret GHCR_TOKEN se utiliza para autenticar el acceso al GitHub Container Registry (GHCR). Para crear este secret, sigue estos pasos:

#### Generar un Token de Acceso Personal en GitHub:

##### Ve a GitHub y accede a tu cuenta.
##### Navega a Configuración (Settings) > Configuración de desarrollador (Developer settings) > Tokens de acceso personal (Personal access tokens).
##### Haz clic en Generar nuevo token (Generate new token).
##### Asigna un nombre al token y selecciona el permiso read:packages.
##### Genera el token y cópialo.

### Creación del Secret KUBE_CONFIG
El secret KUBE_CONFIG se utiliza para almacenar la configuración de acceso a tu clúster de Kubernetes.

#### Obtener el Archivo de Configuración de Kubernetes:

##### Ejecuta en tu consola:
```bash
cp ~/.kube/config kubeconfig.yaml
cat kubeconfig.yaml
```

### Configuración del Self-hosted Runner en GitHub
#### Paso 1: Crear un Nuevo Self-hosted Runner
En GitHub, navega a la página principal del repositorio.
Haz clic en Configuración.
En la barra lateral izquierda, haz clic en Actions y luego en Runners.
Haz clic en New Self-hosted runner.
Sigue las instrucciones para descargar y configurar el ejecutor en tu máquina.
#### Paso 2: Registrar el Self-hosted Runner
Ejecuta el script proporcionado por GitHub para registrar el ejecutor.
### Verifica que el self-hosted runner esté registrado correctamente en la sección de runners del repositorio.
Creación de Secretos en Kubernetes
#### Paso 1: Crear el Secreto de Registro de Docker
Ejecuta el siguiente comando para crear un secreto de registro de Docker:
```bash
kubectl create secret docker-registry github-registry-secret \
  --docker-server=ghcr.io \
  --docker-username="GITHUB_USER" \
  --docker-password="GHCR_TOKEN" \
  --docker-email="EMAIL"
```
Paso 2: Verificar el Secret
Ejecuta el siguiente comando para verificar que el secret se haya creado correctamente:

```bash
kubectl get secrets github-registry-secret
```
### Creación de Secrets en GitHub
#### Paso 1: Navegar a la Configuración del Repositorio
En GitHub, ve a la página principal de tu repositorio.
Haz clic en Configuración (Settings).
#### Paso 2: Acceder a la Sección de Secrets
En la barra lateral izquierda, haz clic en Seguridad (Security).
Selecciona Secretos y variables (Secrets and variables) y luego Acciones (Actions).
#### Paso 3: Crear un New Secret
Haz clic en Nuevo secreto de repositorio (New repository secret).
En el campo Nombre (Name), escribe el nombre del secreto (GHCR_TOKEN o KUBE_CONFIG).
En el campo Secreto (Secret), ingresa el valor del secreto.
#### Paso 4: Guardar el Secret
Haz clic en Agregar secreto (Add secret).

## Enlace al video demostración
https://www.youtube.com/watch?v=bK3Z4MMksrk
