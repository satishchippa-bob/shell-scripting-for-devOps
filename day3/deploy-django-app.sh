#!/bin/bash

<< tash
deploy Django app 
and handle the code error
tash

code_clone() {
	echo " clonging the django cod app..."

	git clone https://github.com/LondheShubham153/django-notes-app.git
}

install_requirements() {

	echo "installlig dependances"
	sudo yum install docker  nginx -y
}

required_restarts(){
        sudo chown $USER /var/run/docker.sock
	sudo systemctl enable docker
	sudo systemctl enable nginx
	sudo systemctl restart docker
	sudo systemctl restart nginx
}

deploy() {
	docker build -t notes-app .
	docker run -d -p 8000:8000 notes-app:latest
}


echo  "********deployment started**************"

if ! code_clone; then
	echo " the code directory already exists"
	cd django-notes-app
fi
if ! install_requirements; then
	echo "installatiob failed"
	exit 1
fi
if ! required_restarts; then
	echo "system filed identical"
	exit 1
fi

if ! deploy; then
	echo " code is collect from django-app"
	cd django-notes-app
	exit 1
fi

echo  "********deployment started**************"



