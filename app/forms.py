from flask_wtf import FlaskForm
from wtforms import (
    StringField, PasswordField, SubmitField, SelectField,
    IntegerField, DateField, TimeField
)
from wtforms.validators import DataRequired, Email, EqualTo, Length, NumberRange

# 👤 Kullanıcı Kayıt Formu
class RegisterForm(FlaskForm):
    fname = StringField('Ad', validators=[DataRequired(), Length(min=2, max=50)])
    lname = StringField('Soyad', validators=[DataRequired(), Length(min=2, max=50)])
    phone = StringField('Telefon', validators=[DataRequired(), Length(min=10, max=15)])
    email = StringField('E-posta', validators=[DataRequired(), Email(), Length(max=100)])
    password = PasswordField('Şifre', validators=[DataRequired(), Length(min=6)])
    confirm_password = PasswordField('Şifre Tekrar', validators=[DataRequired(), EqualTo('password', message='Şifreler uyuşmuyor.')])
    submit = SubmitField('Kayıt Ol')

# 🔐 Giriş Formu
class LoginForm(FlaskForm):
    email = StringField('E-posta', validators=[DataRequired(), Email()])
    password = PasswordField('Şifre', validators=[DataRequired()])
    submit = SubmitField('Giriş Yap')

# 🚗 Araç Kayıt Formu
class VehicleForm(FlaskForm):
    plate_number = StringField('Plaka', validators=[DataRequired(), Length(max=20)])
    brand = StringField('Marka', validators=[DataRequired(), Length(max=50)])
    model = StringField('Model', validators=[DataRequired(), Length(max=50)])
    model_year = IntegerField('Model Yılı', validators=[DataRequired(), NumberRange(min=1900, max=2100)])
    fuel_type = SelectField('Yakıt Türü', choices=[
        ('Gas', 'Benzin'), ('Diesel', 'Dizel'),
        ('Electricity', 'Elektrik'), ('LPG', 'LPG')
    ], validators=[DataRequired()])
    km = IntegerField('Kilometre', validators=[DataRequired()])
    ownership_count = SelectField('Kaçıncı El', choices=[
        ('1', '1. El'), ('2', '2. El'), ('3', '3. El'), ('4', '4. El'), ('5', '5. El')
    ], validators=[DataRequired()])
    submit = SubmitField('Aracı Kaydet')

# 📅 Randevu Formu
class AppointmentForm(FlaskForm):
    date = DateField('Tarih', validators=[DataRequired()])
    time = TimeField('Saat', validators=[DataRequired()])
    vehicle_id = SelectField('Araç', coerce=int, validators=[DataRequired()])
    dealership_id = SelectField('Bayi', coerce=int, validators=[DataRequired()])
    type_id = SelectField('Bakım Türü', coerce=int, validators=[DataRequired()])
    submit = SubmitField('Randevu Al')
