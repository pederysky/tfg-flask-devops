from aplicacion.app import db
from aplicacion.models import Categorias, Articulos,Usuarios
from werkzeug.security import generate_password_hash,check_password_hash

def create_tables():
    #"Create relational database tables."
    db.create_all()

def drop_tables():
    #"Drop all project relational database tables. THIS DELETES DATA."
    db.drop_all()

def add_data_tables():
    db.create_all()
    categorias = ("Deportes", "Arcade", "Carreras", "Acción")
    for cat in categorias:
        categoria = Categorias(nombre=cat)
        db.session.add(categoria)
        db.session.commit()
    
    juegos = [
        {"nombre": "Fernando Martín Basket", "precio": 12, "descripcion":
         "Fernando Martín Basket Master es un videojuego de baloncesto, uno "
         "contra uno, publicado por Dinamic Software en 1987", "stock": 10,"image":"basket.jpeg",
         "CategoriaId": 1},
        {"nombre": "Hyper Soccer", "precio": 10, "descripcion": "Konami Hyper "
         "Soccer fue el primer videojuego de fútbol de Konami para una consola"
         " Nintendo, y considerado la semilla de las posteriores sagas "
         "International Superstar Soccer y Winning Eleven.", "stock": 7,"image":"soccer.jpeg",
         "CategoriaId": 1},
        {"nombre": "Arkanoid", "precio": 15, "descripcion": "Arkanoid es un "
         "videojuego de arcade desarrollado por Taito en 1986. Está basado en "
         "los Breakout de Atari de los años 70.", "stock": 1,"image":"arkanoid.jpeg",
         "CategoriaId": 2},
        {"nombre": "Tetris", "precio": 6, "descripcion": "Tetris es un "
         "videojuego de puzzle originalmente diseñado y programado por Alekséi"
         " Pázhitnov en la Unión Soviética.", "stock": 5, "image":"tetris.jpeg",
         "CategoriaId": 2},
        {"nombre": "Road Fighter", "precio": 15, "descripcion": "Road Fighter "
         "es un videojuego de carreras producido por Konami y lanzado en los "
         "arcades en 1984. Fue el primer juego de carreras desarrollado por "
         "esta compañía.", "stock": 10, "image":"road.jpeg", "CategoriaId": 3},
        {"nombre": "Out Run", "precio": 10, "descripcion": "Out Run es un "
         "videojuego de carreras creado en 1986 por Yū Suzuki y Sega-AM2, y "
         "publicado inicialmente para máquinas recreativas.", "stock": 3,"image":"outrun.jpeg",
         "CategoriaId": 3},
        {"nombre": "Army Moves", "precio": 8, "descripcion": "Army Moves es un"
         " arcade y primera parte de la trilogía Moves diseñado por Víctor "
         "Ruiz, de Dinamic Software para Commodore Amiga, Amstrad CPC, Atari "
         "ST, Commodore 64, MSX y ZX Spectrum en 1986.", "stock": 8,"image":"army.jpeg",
         "CategoriaId": 4},
        {"nombre": "La Abadia del Crimen", "precio": 4, "descripcion": "La "
         "Abadía del Crimen es un videojuego desarrollado inicialmente de "
         "forma freelance y publicado por la Academia Mister Chip en noviembre"
         " de 1987, posteriormente se publica bajo el sello de Opera Soft ya "
         "entrado 1988.", "stock": 10, "image":"abadia.jpeg", "CategoriaId": 4}, ]
    for jue in juegos:
        juego = Articulos(**jue)
        db.session.add(juego)
        db.session.commit()

    # id = Column(Integer, primary_key=True)
    # username = Column(String(100),nullable=False)
    # password_hash = Column(String(128),nullable=False)
    # nombre = Column(String(200),nullable=False)
    # email = Column(String(200),nullable=False)
    # admin = Column(Boolean, default=False)
    #todos los password son 1234
    usuarios = [
        {"username": "Luis", "password_hash":generate_password_hash( "1234"), "nombre":
         "Luis Martín Basket ", "email": "l@gmail.com",
         "admin": False},
        {"username": "Ana", "password_hash": generate_password_hash("1234"), "nombre":
         "Ana Martín Basket ", "email": "a@gmail.com",
         "admin": False},
         {"username": "Maria", "password_hash": generate_password_hash("1234"), "nombre":
         "Maria Martín Basket ", "email": "m@gmail.com",
         "admin": False},
        {"username": "admin", "password_hash": generate_password_hash("1234"), "nombre":
         "Administrador ", "email": "admin@miapp.com",
         "admin": True},
    ]

    for usu in usuarios:
        usuario = Usuarios(**usu)
        db.session.add(usuario)
        db.session.commit()

