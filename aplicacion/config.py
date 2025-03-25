import os

SECRET_KEY = 'A0Zr98j/3yX R~XHH!jmN]LWX/,?RT'
PWD = os.path.abspath(os.curdir)

DEBUG = True # En despliegue esto pasa a FALSE
#SQLALCHEMY_DATABASE_URI = 'sqlite:///{}/dbase.db'.format(PWD)
SQLALCHEMY_DATABASE_URI = "postgresql://tienda_8_2_user:oTufaBIdBGEsJz0iNVCsijNbRBMGYqLU@dpg-ctn5trrtq21c73fe2860-a.frankfurt-postgres.render.com/tienda_8_2"
SQLALCHEMY_TRACK_MODIFICATIONS = False

# Ejemplo basico de postgresql
# Comparalo con ejemplo de Mysql
#SQLALCHEMY_DATABASE_URI= 'postgresql+psycopg2://root:password@localhost/base_datos'
#SQLALCHEMY_TRACK_MODIFICATIONS=False

