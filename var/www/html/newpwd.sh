#!/bin/bash

# Vérification de deux paramètres entrés
if  [ $# -ne 3 ];then
echo "Erreur, il doit y avoir 3 paramètres<br><br>"
exit 1
fi

# Utilisateur non existant
if ! cat /etc/passwd | cut -d\; -f1 | grep $1 > /dev/null;then
#if id -u $1 > /dev/null 2>&1;then
echo "Utilisateur non présent dans le système<br><br>"
exit 1
fi

username="$1"
current_pwd="$2"
new_pwd="$3"

# Récupérer le hash du mot de passe actuel dans la base de données
hashed_pwd=$(sudo grep "^${username}:" /etc/shadow | cut -d ":" -f 2)

# Générer le hash pour le nouveau mot de passe
new_hashed_pwd=$(openssl passwd -6 -stdin <<< "$new_pwd")

hash_pwd_use=$(echo "$current_pwd" | openssl passwd -6 -stdin -salt "$(echo "$hashed_pwd" | cut -d'$' -f3)")

# Vérifier si le mot de passe actuel est correct
if [[ "$hash_pwd_use" == "$hashed_pwd" ]]; then
  # Mettre à jour le mot de passe dans la base de données
  sudo usermod -p "$new_hashed_pwd" "$username"
  echo "Mot de passe mis à jour pour l'utilisateur $username."
else
  echo "Le mot de passe actuel pour l'utilisateur $username est incorrect."
fi
