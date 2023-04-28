#!/bin/bash

echo "Bonjour $1 $2 <br><br>"
# Vérification de deux paramètres entrés
if  [ $# -ne 2 ];then
echo "Erreur, il doit y avoir 2 paramètres<br><br>"
exit 1
fi

# Utilisateur déjà créé
if cat /etc/passwd | cut -d\; -f1 | grep $1 > /dev/null;then
echo "Utilisateur déjà présent dans le système<br><br>"
exit 1
fi

# Création user
sudo useradd -m $1

# Ajoute l'utilisateur dans nos fichiers utilisateur /home

# Génération du mot de passe
echo "$1:$1" | sudo chpasswd

# Génaration du fichier de configuration
sed -e "s/MYUSERNAME/$1" -e "s/MYDOMAIN/$2/" /etc/nginx/templateSite > /etc/nginx/sites-enabled/$2

# Partie MySql
sudo mysql -e "CREATE DATABASE $1;"
sudo mysql -e "CREATE USER '$1'@'localhost' IDENTIFIED BY '$1';"
sudo mysql -e "GRANT ALL PRIVILEGES ON $1.* TO '$1'@'localhost';"
sudo mysql -e "CREATE TABLE `users` (  `username` varchar(20) NOT NULL,  `password` varchar(30) NOT NULL,  `domain` varchar(255) NOT NULL,  `id` int(11) NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8;"
sudo mysql -e "ALTER TABLE `users`  ADD PRIMARY KEY (`id`);"
sudo mysql -e "ALTER TABLE `users`  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;"
sudo mysql -e "INSERT INTO `users` (username, password, domain) VALUES ($1, $1, $2);"

# Crée une database avec le nom de l'utilisateur
# Crée
