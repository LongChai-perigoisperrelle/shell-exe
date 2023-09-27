#!/bin/bash

# Récupérer le nom d'utilisateur
USER="jerome"

# Récupérer la date et l'heure actuelles au format jj-mm-aaaa-HH:MM
DATE=$(date +"%d-%m-%Y-%H:%M")

# Compter le nombre de connexions de l'utilisateur
CONNECTION_COUNT=$(last -n 1000 | grep $USER | wc -l)

# Créer un fichier avec le nombre de connexions
echo $CONNECTION_COUNT > ~/Job8/number_connection-$DATE

# Archiver le fichier avec tar
tar -cvf ~/Job8/Backup/number_connection-$DATE.tar ~/Job8/number_connection-$DATE

# Supprimer le fichier original
rm ~/Job8/number_connection-$DATE

