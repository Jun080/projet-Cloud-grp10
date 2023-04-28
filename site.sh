#!/bin/bash

# Installation de Nginx
sudo apt update
sudo apt install nginx -y

# Configuration de Nginx pour créer un site web par utilisateur
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/$USER
sudo sed -i "s//var/www/html//home/$USER/site/g" /etc/nginx/sites-available/$USER
sudo sed -i "s/servername /server_name $USER/g" /etc/nginx/sites-available/$USER
sudo ln -s /etc/nginx/sites-available/$USER /etc/nginx/sites-enabled/

# Création du dossier pour le site web de l'utilisateur
mkdir /home/$USER/site
echo "<html><head><title>$USER's site</title></head><body><h1>Welcome to $USER's site!</h1></body></html>" > /home/$USER/site/index.html

# Redémarrage de Nginx pour appliquer les modifications
sudo service nginx restart
