from flask_wtf import FlaskForm
from wtforms import (
    StringField, PasswordField, SubmitField, SelectField,
    IntegerField, DateField, TimeField
)
from wtforms.validators import DataRequired, Email, EqualTo, Length, NumberRange

class RegisterForm(FlaskForm):
    fname = StringField('Name:', validators=[DataRequired(), Length(min=2, max=50)])
    lname = StringField('Surname:', validators=[DataRequired(), Length(min=2, max=50)])
    phone = StringField('Phone:', validators=[DataRequired(), Length(min=10, max=15)])
    email = StringField('E-mail:', validators=[DataRequired(), Email(), Length(max=100)])
    password = PasswordField('Password:', validators=[DataRequired(), Length(min=6)])
    confirm_password = PasswordField('Confirm Password:', validators=[DataRequired(), EqualTo('password', message='Passwords do not match!')])
    submit = SubmitField('Register')

class LoginForm(FlaskForm):
    email = StringField('E-mail:', validators=[DataRequired(), Email()])
    password = PasswordField('Password:', validators=[DataRequired()])
    submit = SubmitField('Log In')

class VehicleForm(FlaskForm):
    plate_number = StringField('Plate Number:', validators=[DataRequired(), Length(max=20)])
    brand = StringField('Brand:', validators=[DataRequired(), Length(max=50)])
    model = StringField('Model:', validators=[DataRequired(), Length(max=50)])
    model_year = IntegerField('Model Year:', validators=[DataRequired(), NumberRange(min=1900, max=2100)])
    fuel_type = SelectField('Fuel Type:', choices=[
        ('Gas', 'Benzin'), ('Diesel', 'Dizel'),
        ('Electricity', 'Elektrik'), ('LPG', 'LPG')
    ], validators=[DataRequired()])
    km = IntegerField('Kilometer:', validators=[DataRequired()])
    ownership_count = SelectField('Ownership Count:', choices=[
        ('1', '1. Hand'), ('2', '2. Hand'), ('3', '3. Hand'), ('4', '4. Hand'), ('5', '5. Hand')
    ], validators=[DataRequired()])
    submit = SubmitField('Save the Vehicle')

class AppointmentForm(FlaskForm):
    date = DateField('Date:', validators=[DataRequired()])
    time = TimeField('Hour:', validators=[DataRequired()])
    vehicle_id = SelectField('Vehicle:', coerce=int, validators=[DataRequired()])
    dealership_id = SelectField('Dealership:', coerce=int, validators=[DataRequired()])
    type_id = SelectField('Maintenance Type:', coerce=int, validators=[DataRequired()])
    submit = SubmitField('Book Appointment')
