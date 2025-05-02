#!/bin/bash

: <<'tash'
This script installs dependencies, prepares Docker, and deploys a Django app.
tash

code_clone() {
    echo "Cloning the Django app..."
    if [ ! -d "django-notes-app" ]; then
        git clone https://github.com/LondheShubham153/django-notes-app.git
    else
        echo "Directory already exists. Skipping clone."
    fi
}

write_dockerfile() {
    echo "Writing Dockerfile..."
    cat > django-notes-app/Dockerfile <<EOF
FROM python:3.8

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt

EXPOSE 8000

CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
EOF
}

install_requirements() {
    echo "Installing Docker, Nginx, Git..."
    sudo yum update -y
    sudo yum install -y docker nginx git
}

required_restarts() {
    echo "Starting Docker and Nginx..."
    sudo systemctl start docker
    sudo systemctl enable docker

    sudo systemctl start nginx
    sudo systemctl enable nginx

    sudo chown $USER /var/run/docker.sock
}

deploy() {
    echo "Building and running Docker container..."
    cd django-notes-app || exit 1
    docker build -t notes-app .
    docker run -d -p 8000:8000 notes-app
}

echo "******** Deployment Started ********"

code_clone || { echo "Git clone failed"; exit 1; }
write_dockerfile
install_requirements || { echo "Dependency install failed"; exit 1; }
required_restarts || { echo "Service setup failed"; exit 1; }
deploy || { echo "Deployment failed"; exit 1; }

echo "******** Deployment Completed Successfully ********"

