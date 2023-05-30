# Backend RESTful API using Django
This repository contains the backend RESTful API of Shades Cast written with Python and the Django framework. This API provides endpoints to perform CRUD (Create, Read, Update, Delete) operations on a specific resource. It can be used as a template or starting point for building your own RESTful API.

## Requirements
- Python 3.8 or higher
- Pip package manager

## Installation
### 1. Clone the repository:
    git clone https://github.com/ffekirnew/shades-cast.git
### 2. Install Python (with pip) and PostgresSQL:
This might differ based on the operating system that you have. We'll provide how to do it on debian-based linux systems here.

    sudo apt update

    sudo apt install postgresql
    sudo apt install python3
    sudo apt install python3-pip

### 3. Start the PostgresSQL database and configure it to set the password for the user postgres 'admin' and create the database 'podcasts':
#### a. To start postgres:

    sudo service postgresql start

#### b. Switch to the 'postgres' user account, which is the default superuser for PostgreSQL, using the following command:

    sudo -u postgres psql

#### c. After this command, the terminal will be visibly different. Continue and set the password for the 'postgres' user by executing the following SQL command:

    ALTER USER postgres PASSWORD 'admin';

#### d. Create the 'podcasts' database by running the following SQL command:

    CREATE DATABASE podcasts;

#### e. Change to the newly created database and install the postgres trigram extension used for similarity search:

    \c podcasts;
    CREATE EXTENSION pg_trgm;

#### f. Exit the PostgreSQL prompt by typing \q and pressing Enter. 

    \q

### 4. Create and start a virtual environment in the backend folder to contain python and packages of the project:
    cd backend

    python3 -m venv venv
    source venv/bin/activate

To deactivate, you can use the command:
    
    deactivate

### 4. Install the required python dependencies of the project:
    pip install -r requirements.txt
### 5. Create the database tables:
    python3 manage.py migrate
## Usage
### Start the development server:
    python3 manage.py runserver
The complete api documentation can be found after running the development server at:
    
    http://localhost:8000/api/v2/docs
## License
This project is licensed under the MIT License. Feel free to use it for your own projects.