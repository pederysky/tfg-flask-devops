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


### Despliegue Local

Para desplegar la aplicación en un entorno local, ejecute el siguiente script:

```bash
./deploy_flask_tienda.sh
