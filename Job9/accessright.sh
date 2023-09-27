#!/bin/bash

# Chemin vers le fichier CSV contenant les informations des utilisateurs
CSV_FILE="/chemin/vers/votre/fichier.csv"

# Chemin vers le fichier qui stocke la somme de contrôle (checksum) du fichier CSV
CHECKSUM_FILE="/chemin/vers/le/fichier_checksum.txt"

# Fonction pour créer un utilisateur avec des privilèges d'administrateur (super utilisateur)
create_admin_user() {
    username="$1"
    
    # Vérifier si l'utilisateur existe déjà
    if id "$username" &>/dev/null; then
        echo "L'utilisateur $username existe déjà."
    else
        # Créer l'utilisateur avec des privilèges d'administrateur
        useradd -m -G sudo "$username"
        echo "L'utilisateur $username a été créé avec des privilèges d'administrateur."
    fi
}

# Fonction pour vérifier si le fichier CSV a été modifié
is_csv_modified() {
    current_checksum=$(md5sum "$CSV_FILE" | awk '{print $1}')
    previous_checksum=$(cat "$CHECKSUM_FILE")
    
    if [ "$current_checksum" != "$previous_checksum" ]; then
        echo "Le fichier CSV a été modifié."
        echo "$current_checksum" > "$CHECKSUM_FILE"  # Mettre à jour la somme de contrôle
        return 0  # Le fichier a été modifié
    else
        return 1  # Le fichier n'a pas été modifié
    fi
}

# Exécuter la fonction process_csv si le fichier CSV a été modifié
if is_csv_modified; then
    # Le fichier CSV a été modifié, traitons-le
    process_csv
fi

# Fonction pour lire le fichier CSV et traiter chaque ligne
process_csv() {
    while IFS=',' read -r username role; do
        if [ "$role" == "admin" ]; then
            create_admin_user "$username"
        fi
    done < "$CSV_FILE"
}

# Ajouter une tâche cron pour exécuter ce script à intervalles réguliers
# Remplacez '/chemin/vers/accessrights.sh' par le chemin complet de votre script
(crontab -l ; echo "*/5 * * * * /chemin/vers/accessrights.sh") | crontab -

echo "Script configuré avec succès pour s'exécuter automatiquement toutes les 5 minutes."

