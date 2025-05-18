# MecHero – Car Maintenance & Appointment Web App

**MecHero** is a web-based application designed to manage automobile repair and maintenance processes. It provides distinct interfaces for users, employees, and admins, allowing vehicle owners to register vehicles, book service appointments, and track maintenance history.

---

## Features

### Guest Interface
- Register as a user
- View dealership locations
- Learn about the platform

### User Interface
- Login and access personal dashboard
- Add, delete, and view registered vehicles
- Book, cancel, and view appointments
- Update profile and password

### Employee Interface
- Login using institutional email (e.g., 2018@mechero.com)
- View assigned appointments in calendar format
- Popup details for each appointment

### Admin Interface
- Login as `admin@admin.com`
- View interactive analytics:
  - Most popular maintenance type per month
  - Monthly appointment trends per city
  - Cities with highest annual appointments
  - Busiest dealership hours
  - Average working hours of employees

---

## Technologies Used
- **Backend**: Python (Flask), Flask-WTF, Flask-Login, SQLAlchemy
- **Database**: PostgreSQL
- **Frontend**: HTML, CSS, Bootstrap, Jinja2
- **Environment Management**: python-dotenv
- **Visualization**: Chart.js or similar via admin dashboard templates

---

## Installation & Setup

### 1. Clone the Repository
```bash
git clone <repo_url>
cd mechero
```

### 2. Create Virtual Environment (Optional but Recommended)
```bash
python -m venv venv
source venv/bin/activate       # macOS/Linux
venv\Scripts\activate        # Windows
```

### 3. Install Dependencies
```bash
pip install -r requirements.txt
```

### 4. Import Database Dump
Make sure PostgreSQL is installed and a database named `mechero` exists.

Then import the provided SQL dump:
```bash
psql -U <username> -d mechero -f path/to/mechero_dump.sql
```

### 5. Set Environment Variables
In your project root, ensure a `.env` file exists and contains:
```
DATABASE_URL=postgresql://<username>:<password>@localhost:5432/mechero
SECRET_KEY=dev-key
```

### 6. Run the Application
```bash
python run.py
```
Open your browser and visit: `http://127.0.0.1:5000`

---

## Login Information

### Admin
```
Email: admin@admin.com
Password: 123456
```

### User Example
```
Example:
Email: gmurat2427@google.com
Password: M3V41AGC3P3
```

### Employee Example
```
Example:
Email: 2018@mechero.com
Password: 2018
```

> ⚠️ NOTE: When copying email or password values from the database, remove surrounding quotation marks (e.g., "user@example.com") before using them.

---

## 📁 Project Structure
```
├── app/
│   ├── __init__.py
│   ├── models.py
│   ├── forms.py
│   ├── decorators.py
│   ├── routes/
│   │   ├── guest_routes.py
│   │   ├── user_routes.py
│   │   ├── employee_routes.py
│   │   └── admin_routes.py
│   ├── templates/
│   └── static/
├── config.py
├── run.py
├── requirements.txt
├── .env
└── mechero_dump.sql
```

---

## Final Notes
- Admin queries are implemented inside `admin_routes.py` using SQLAlchemy and raw SQL.
- The dump file includes all necessary data to test logins and functionality.
- For help or collaboration, contact the project members.

---

🧠 Developed for BIM216 – Database Management Systems Term Project