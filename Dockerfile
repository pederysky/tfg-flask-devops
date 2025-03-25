# Usamos una imagen base de Python
FROM python:3.9-slim

# Establecemos el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiamos el archivo requirements.txt a la raíz del contenedor
COPY requirements.txt /app/

# Mostramos el contenido de requirements.txt para asegurarnos que está correcto
RUN cat requirements.txt

# Instalamos las dependencias del archivo requirements.txt
RUN pip install --no-cache-dir -r requirements.txt || (tail -n 10 /root/.pip/pip.log && exit 1)

# Copiamos los archivos de la aplicación al contenedor
COPY ./aplicacion /app

# Exponemos el puerto 5000 para la aplicación Flask
EXPOSE 5000

# Comando para ejecutar la aplicación Flask
CMD ["python", "aplicacion/app.py"]
