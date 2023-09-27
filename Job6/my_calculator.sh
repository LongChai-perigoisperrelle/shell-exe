#!/bin/bash

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <nombre1> <opérateur> <nombre2>"
  exit 1
fi

nombre1="$1"
opérateur="$2"
nombre2="$3"

case "$opérateur" in
  +)
    résultat=$(echo "$nombre1 + $nombre2" | bc)
    ;;
  -)
    résultat=$(echo "$nombre1 - $nombre2" | bc)
    ;;
  /)
    if [ "$nombre2" -eq 0 ]; then
      echo "Erreur : Division par zéro impossible."
      exit 1
    fi
    résultat=$(echo "scale=2; $nombre1 / $nombre2" | bc)
    ;;
  *)
    echo "Opérateur invalide. Utilisation : $0 <nombre1> +|-|/ <nombre2>"
    exit 1
    ;;
esac

echo "Résultat : $résultat"

