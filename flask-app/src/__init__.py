# Some set up for the application

from flask import Flask
from flaskext.mysql import MySQL

# create a MySQL object that we will use in other parts of the API
db = MySQL()


def create_app():
    app = Flask(__name__)

    # secret key that will be used for securely signing the session
    # cookie and can be used for any other security related needs by
    # extensions or your application
    app.config['SECRET_KEY'] = 'joshandrachel'

    # these are for the DB object to be able to connect to MySQL.
    app.config['MYSQL_DATABASE_USER'] = 'webapp'
    # app.config['MYSQL_DATABASE_PASSWORD'] = open(
    #     '/secrets/db_password.txt').readline()
    app.config['MYSQL_DATABASE_PASSWORD'] = 'joshandrachel'
    app.config['MYSQL_DATABASE_HOST'] = 'db'
    app.config['MYSQL_DATABASE_PORT'] = 3306
    # Change this to your DB name
    app.config['MYSQL_DATABASE_DB'] = 'gym'

    # Initialize the database object with the settings above.
    db.init_app(app)

    # Import the various routes
    from src.views import views
    from src.employees.employees import employees
    from src.members.members import members
    from src.nonmembers.nonmembers import nonmembers

    # Register the routes that we just imported so they can be properly handled
    app.register_blueprint(views,       url_prefix='/summit')
    app.register_blueprint(employees,   url_prefix='/summit')
    app.register_blueprint(members,    url_prefix='/summit')
    app.register_blueprint(nonmembers,   url_prefix='/summit')

    return app
