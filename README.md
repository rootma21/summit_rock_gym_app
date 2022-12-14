# Summit Rock Gym App

This database design project supports a simple app for a new indoor indoor rock climbing gym. It is meant to support three distinct personas: employees, members, and nonmembers of the gym. The app allows members to sign up and view teams, nonmembers to sign waivers and purchase passes, and employees to check in members. The front-end of the application runs on AppSmith, while the data is stored in a MySQL database, and the routes are supported in Flask. 

A live demo can be accessed at https://www.dropbox.com/s/7u4oh7vl6ebeo3e/summit_rock.mp4?dl=0

The App Smith page can be accessed at https://appsmith.cs3200.net/app/summit-rock-gym/home-page-638919a1ffea3148102ab8de

This repo contains a setup for spinning up 2 docker containers required to run the Summit Rock Gym App: 
1. A MySQL 8 container
1. A Python Flask container to implement the Summit Rock Gym REST API

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. In the file named `db_root_password.txt` in the `secrets/` folder, put inside of it the root password for MySQL. 
1. In the file named `db_password.txt` in the `secrets/` folder, put inside of it the password you want to use for the `webapp` user. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 

## For setting up a Conda Web-Dev environment:

1. `conda create -n webdev python=3.9`
1. `conda activate webdev`
1. `pip install flask flask-mysql flask-restful cryptography flask-login`




