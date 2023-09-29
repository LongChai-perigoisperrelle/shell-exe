#!/bin/bash

# Vérifier le nombre d'arguments
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <nouveauFichier.txt> <contenu.txt>"
  exit 1
fi

# Assigner les noms de fichiers aux variables
nouveauFichier.txt="$1"
contenu.txt="$2"

# Vérifier si le fichier source existe
if [ ! -e "$contenuFichier" ]; then
  echo "Le fichier $contenuFichier n'existe pas."
  exit 1
fi

# Copier le contenu du fichier source dans le nouveau fichier en utilisant la redirection
cat "$contenuFichier" > "$nouveauFichier"

# Vérifier si la copie a réussi
if [ $? -eq 0 ]; then
  echo "Le contenu de $contenuFichier a été copié dans $nouveauFichier."
else
  echo "Une erreur est survenue lors de la copie."
fi
