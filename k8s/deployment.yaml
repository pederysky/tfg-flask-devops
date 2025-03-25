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
          image: ghcr.io/${{ github.repository }}/flask_tienda:latest
          ports:
            - containerPort: 5000
