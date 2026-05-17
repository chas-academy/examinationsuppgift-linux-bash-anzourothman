#!/bin/bash

#  kontroll att scriptet körs som root
if [ "$EUID" -ne 0 ]; then
    echo "Du måste köra scriptet som root"
    exit 1
fi

  # loppar genom alla användare som skickas  in 
for username in "$@"
do
   # skapar användare
       useradd "$username"
# skapar mappar till varje användare
mkdir -p "/home/$username/Documents"
mkdir -p "/home/$username/Downloads"
mkdir -p "/home/$username/Work"

#  sätter rättigheter till privata

chmod 700 "/home/$username/Documents"
chmod 700 "/home/$username/Downloads"
chmod 700 "/home/$username/Work"
   
done

# Skapar welcome.txt efter att alla användare är skapade och listar dem.
# Ger varje användare rätt till sin egen hemmkatalog
for username in "$@"
do
    echo "Välkommen $username" > "/home/$username/welcome.txt"
    cut -d: -f1 /etc/passwd >> "/home/$username/welcome.txt"
    chown "$username:$username" "/home/$username/welcome.txt"
    chown -R "$username:$username" "/home/$username"    
done

