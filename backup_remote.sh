#!/bin/bash
SUB_DIR="bros"
BACKUP_DIR="/backup"
SOURCE_DIR="/home/${SUB_DIR}"
SERVER="deb"

# Datum im Format YYYYMMDD
DATE=$(date +%Y%m%d)

FULLB="${BACKUP_DIR}/Vollbackup"
INCRB="${BACKUP_DIR}/Inkrementell/${DATE}"
DIFFB="${BACKUP_DIR}/Differentiell/${DATE}"
LASTB="${BACKUP_DIR}/Latest"

# Backup-Art je nach Argument
case "$1" in
  full)
    # Stelle sicher, dass Zielverzeichnis auf dem Server existiert 
    ssh ${SERVER} "[[ -d ${FULLB} ]] || mkdir -p -m 777 ${FULLB}"
    # Synchronisiere
    rsync -av ${SOURCE_DIR} ${SERVER}:${FULLB}
    # Link to Latest
    ssh ${SERVER} "ln -snf ${FULLB} ${LASTB}"
    ;;
  incremental)
    # Stelle sicher, dass der Link auf /backup/Latest existiert und auf ein
    # Verzeichnis verweist
      ssh ${SERVER} "[[ -L ${LASTB} && -d ${FULLB} ]]" || cat << _ && exit 1
      Es exitiert kein Backup zum Vergleich. Erstellen Sie ein Vollback
      mit $0 full.
_
    # Stelle sicher, dass Zielverzeichnis existiert 
    ssh ${SERVER} "[[ -d ${INCRB} ]] || mkdir -p -m 777 ${INCRB}"
    # Synchronisiere
    rsync -av --link-dest=../../Latest ${SOURCE_DIR} ${SERVER}:${INCRB}
    # Link to Latest
    ssh ${SERVER} "ln -snf ${INCRB} ${LASTB}"
    ;;
  differential)
    # Stelle sicher, dass Zielverzeichnis existiert 
    ssh ${SERVER} "[[ -d ${DIFFB} ]] || mkdir -p -m 777 ${DIFFB}"
    # Synchronisiere
    rsync -av --link-dest=../../Vollbackup ${SOURCE_DIR} ${SERVER}:${DIFFB}
    # Link to Latest
    ssh ${SERVER} "ln -snf ${DIFFB} ${LASTB}"
    ;;
  *)
    echo "Usage: $0 {full|differential|incremental}"
    exit 1
    ;;
esac
