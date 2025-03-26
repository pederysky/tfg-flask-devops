apiVersion: apps/v1
kind: Deployment
metadata:
  name: flask-tienda
spec:
  replicas: 2
  selector:
    matchLabels:
      app: flask-tienda
  template:
    metadata:
      labels:
        app: flask-tienda
    spec:
      containers:
        - name: flask-tienda
          image: ghcr.io/pederysky/tfg_1/flask_tienda:latest
          imagePullPolicy: Always
          ports:
            - containerPort: 5000
          env:
            - name: FLASK_ENV
              value: "production"
          resources:
            requests:
              cpu: "250m"
              memory: "512Mi"
            limits:
              cpu: "500m"
              memory: "1Gi"
