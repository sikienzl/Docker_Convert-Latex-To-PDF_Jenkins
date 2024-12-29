#!/bin/bash

# Standard-Benutzer und Gruppen-IDs (über Umgebungsvariablen oder Standardwerte)
USERID=${LOCAL_USER_ID:-9999}
USERNAME=${LOCAL_USER:-user}
GROUPID=${LOCAL_GROUP_ID:-100}
GROUPNAME=${LOCAL_GROUP_NAME:-users}

# Gruppe hinzufügen, falls nicht vorhanden
if [ ! $(getent group $GROUPID) ]; then
  addgroup -g $GROUPID $GROUPNAME
fi

# Benutzer hinzufügen
adduser -D --shell /bin/bash -u $USERID $USERNAME $GROUPNAME

# Home-Verzeichnis des Benutzers setzen
export HOME=/home/$USERNAME

# Benutzer wechseln
su - $USERNAME -c "/usr/local/bin/$1 $2"