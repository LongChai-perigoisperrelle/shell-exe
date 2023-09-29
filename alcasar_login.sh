#!/bin/bash

# Vérifier que les arguments email et password sont fournis
if [ $# -ne 2 ]; then
    echo "Utilisation : $0 email password"
    exit 1
fi

# URL de la page de connexion Alcasar
ALCASAR_LOGIN_URL="https://alcasar.laplateforme.io/intercept.php?res=notyet&uamip=10.10.0.1&uamport=3990&challenge=de0fc31c35b0c4d5d53e510a8734ccab&called=68-05-CA-3A-2E-49&mac=70-32-17-AF-B2-E8&ip=10.10.5.215&nasid=alcasar.laplateforme.io&sessionid=1695973810000001ec&ssl=https%3a%2f%2f1.0.0.1%3a3991%2f&userurl=http%3a%2f%2fneverssl.com%2f&md=EC1F0B0D351CC7F29426020C7E4B52DC"

# Adresse e-mail et mot de passe fournis en arguments
EMAIL="$1"
PASSWORD="$2"

# Utiliser curl pour envoyer une requête POST avec les informations d'identification
# -s : Mode silencieux pour masquer la sortie de curl
# -c : Stocker les cookies dans un fichier
# -d : Les données POST pour le formulaire de connexion
"curl" -s -c cookies.txt -d "email=$EMAIL" -d "password=$PASSWORD" -o /dev/null "$ALCASAR_LOGIN_URL"

# Vérifier le code de retour de la commande curl pour déterminer si la connexion a réussi
if [ $? -eq 0 ]; then
    echo "Connexion réussie à Alcasar en tant que $EMAIL"
else
    echo "Échec de la connexion à Alcasar"
fi

# Nettoyer les fichiers temporaires
rm -f cookies.txt
