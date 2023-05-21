# Backend RESTful API using Django
This repository contains the backend RESTful API of Shades Cast written with Python and the Django framework. This API provides endpoints to perform CRUD (Create, Read, Update, Delete) operations on a specific resource. It can be used as a template or starting point for building your own RESTful API.

## Requirements
- Python 3.10 or higher (For django 4.2, but django 3.2 will do for all functionalities)
- Pip package manager

## Installation
### 1. Clone the repository:
    git clone https://github.com/ffekirnew/shades-cast.git
### 2. Install Python (with pip) and PostgreSQL:
This might differ based on the operating system that you have. We'll provide how to do it on debian-based linux systems here.

    sudo apt update

    sudo apt install postgresql
    sudo apt install python3
    sudo apt install python3-pip

### 3. Start the PostgreSQL database and configure it to set the password for the user postgres 'admin' and create the database 'podcasts':
To start postgre:

    sudo service postgresql start

Switch to the 'postgres' user account, which is the default superuser for PostgreSQL, using the following command:

    sudo -u postgres psql

After this command, the terminal will be visibly different. Continue and set the password for the 'postgres' user by executing the following SQL command:

    ALTER USER postgres PASSWORD 'admin';

Create the 'podcasts' database by running the following SQL command:

    CREATE DATABASE podcasts;

Exit the PostgreSQL prompt by typing \q and pressing Enter. 

    \q

### 4. Create and start a virtual environment to contain python and packages of the project:
    python3 -m venv venv
    source venv/bin/activate

To deactivate, you can use the command:
    
    deactivate

### 4. Install the required python dependencies of the project:
    pip install -r requirements.txt
### 5. Create the database tables:
    python3 manage.py migrate
### 6. Start the development server:
    python3 manage.py runserver

## Usage
The complete api documentation can be found after running the development server at:
    
    http://localhost:8000/api/docs
## License
This project is licensed under the MIT License. Feel free to use it for your own projects.