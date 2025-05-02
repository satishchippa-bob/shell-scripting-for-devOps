#!/bin/bash


read -p  "enter yourname:" username
echo " you entered $username "

sudo useradd -m $username
echo "createing useradd"
