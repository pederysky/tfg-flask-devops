tienda_8_2/
├── aplicacion/
│   ├── app.py                         # Tu aplicación Flask principal
│   ├── config.py                      # Configuración de la app Flask
│   ├── forms.py                       # Formulario de la aplicación
│   ├── inicializacion_datos.py        # Inicialización de datos de la app
│   ├── __init__.py                    # Inicialización del módulo Flask
│   ├── login.py                       # Funcionalidad de login
│   ├── models.py                      # Modelos de base de datos
│   ├── static/                        # Archivos estáticos
│   │   ├── css/
│   │   │   └── style.css
│   │   └── upload/
│   │       └── [archivos de imágenes]
│   └── templates/                     # Plantillas HTML
│       └── [plantillas de la app]
├── Dockerfile                         # Dockerfile para contenerizar la app
├── .dockerignore                      # Archivos a excluir del contenedor Docker
├── requirements.txt                   # Dependencias de la app Flask
├── .github/
│   └── workflows/
│       └── ci.yml                     # Workflow de GitHub Actions
├── k8s/
│   ├── deployment.yaml                # Configuración de Kubernetes para desplegar la app
│   └── service.yaml                   # Configuración de servicio en Kubernetes
├── helm/
│   ├── zabbix/
│   │   └── values.yaml                # Configuración de Helm para Zabbix
│   └── elk/
│       ├── elasticsearch-values.yaml  # Configuración de Helm para Elasticsearch
│       ├── kibana-values.yaml         # Configuración de Helm para Kibana
│       └── logstash-values.yaml       # Configuración de Helm para Logstash
└── README.md                          # Descripción del proyecto
