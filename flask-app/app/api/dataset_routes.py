from flask import Blueprint, jsonify, session, request
from app.models import User, db, Dataset
from app.forms import LoginForm
from app.forms import SignUpForm
from flask_login import current_user, login_user, logout_user, login_required

dataset_routes = Blueprint('dataset_routes', __name__)

# Get all datasets 
@dataset_routes.route('/datasets', methods=['GET'])
def get_all_datasets():
    datasets = Dataset.query.all()
    #print(datasets)
    return "Hello World!"

@app.route('/')
def index():
    return 'Index Page'