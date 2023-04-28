!/bin/bash
DATE=$(date +%Y-%m-%d)

# Vérifier si le répertoire de sauvegarde existe
if [ ! -d "/home/$1/backups/$DATE" ]; then

      	# Créer le répertoire de sauvegarde s'il n'existe pas
    	sudo mkdir -p "/home/$1/backups/$DATE"
fi

sudo chmod a+w /home/$1/backups/$DATE

# Vérifier les permissions de l'utilisateur
if [ ! -w "/home/$1/backups/$DATE" ]; then
    echo "$1 n'a pas les permissions nécessaires pour écrire dans le répertoire de sauvegarde."
    exit 1
fi

# Créer une archive compressée de /home/$1/site
tar -czvf /home/$1/backups/$DATE/backup.tar.gz /home/$1/site >/dev/null

# "tar" est utilisé pour créer une archive compressée des fichiers de l'utilisateur.
# L'option "-c" signifie "créer une archive",
# "-z" signifie "compresser avec gzip" et "-v" signifie "afficher les fichiers qui sont ajoutés à l'archive".
# L'argument /home/$1/site est le chemin absolu du dossier contenant les fichiers de l'utilisateur.

# Sauvegarder la base de données
sudo mysqldump -u "$1" -p"$1" "$1" > /home/$1/backups/$DATE/backup.sql

# "mysqldump" est utilisé pour créer une sauvegarde de la base de données.
# L'option "-u" spécifie le nom d'utilisateur et "-p" demande le mot de passe pour accéder à la base de données suivi du nom de la base de données que vous souhaitez sauvegarder.

echo "Sauvegarde terminée."
