from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, DecimalField, IntegerField,\
    TextAreaField, SelectField, PasswordField, EmailField, HiddenField
from flask_wtf.file import FileField
from wtforms.validators import DataRequired, InputRequired,NumberRange

#Nuevo del Carrito
class FormCarrito(FlaskForm):
    id = HiddenField()
    cantidad = IntegerField('Cantidad', default=1,
                validators=[NumberRange(min=1,
                message="Debe ser un número positivo"),
                DataRequired("Tienes que introducir el dato")]
                )
    submit = SubmitField('Aceptar')

#Codigo Anteriror
class FormCategoria(FlaskForm):
    nombre = StringField("Nombre:",
                validators=[DataRequired("Tienes que introducir el dato")]
                )
    submit = SubmitField('Enviar')


class FormArticulo(FlaskForm):
    nombre = StringField("Nombre:",
                validators=[DataRequired("Tienes que introducir el dato")]
                )
    precio = DecimalField("Precio:", default=0,
                validators=[DataRequired("Tienes que introducir el dato")]
                )
    iva = IntegerField("IVA:", default=21,
                validators=[DataRequired("Tienes que introducir el dato")])
    descripcion = TextAreaField("Descripción:")
    photo = FileField('Selecciona imagen:')
    stock = IntegerField("Stock:", default=1,
                validators=[DataRequired("Tienes que introducir el dato")]
                )
    CategoriaId = SelectField("Categoría:", coerce=int)
    submit = SubmitField('Enviar')


class FormSINO(FlaskForm):
    si = SubmitField('Si')
    no = SubmitField('No')


class LoginForm(FlaskForm):
    username = StringField('Login', validators=[DataRequired()])
    password = PasswordField('Password', validators=[DataRequired()])
    submit = SubmitField('Entrar')



class FormUsuario(FlaskForm):
    username = StringField('Login', validators=[DataRequired()])
    password = PasswordField('Password', validators=[DataRequired()])
    nombre = StringField('Nombre completo')
    email = EmailField('Email')
    submit = SubmitField('Aceptar')


class FormChangePassword(FlaskForm):
    password = PasswordField('Password', validators=[DataRequired()])
    submit = SubmitField('Aceptar')
