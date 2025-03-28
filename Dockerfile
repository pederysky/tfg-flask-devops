# Usamos una imagen base de Python
FROM python:3.9-slim

# Establecemos el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiamos los archivos de la aplicación al contenedor
COPY ./aplicacion /app/aplicacion
COPY ./app.py /app/
COPY ./requirements.txt /app/

# Verificamos que los archivos se copiaron correctamente
RUN ls -la /app  # Verificar los archivos copiados en el directorio /app

# Instalamos las dependencias del archivo requirements.txt con logs detallados
RUN pip install -v --no-cache-dir -r requirements.txt || (tail -n 10 /root/.pip/pip.log && exit 1)

# Exponemos el puerto 5000 para la aplicación Flask
EXPOSE 5000

# Comando para ejecutar la aplicación Flask
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
