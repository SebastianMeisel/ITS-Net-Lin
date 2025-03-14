#!/bin/bash
SUB_DIR="bros"
BACKUP_DIR="/backup"
# Für remote Backups, z.B. BACKUP_DIR="deb:/backup"
SOURCE_DIR="/home/${SUB_DIR}"

# Datum im Format YYYYMMDD
DATE=$(date +%Y%m%d)

FULLB="${BACKUP_DIR}/Vollbackup"
INCRB="${BACKUP_DIR}/Inkrementell/${DATE}"
DIFFB="${BACKUP_DIR}/Differentiell/${DATE}"
LASTB="${BACKUP_DIR}/Latest"

# Wenn Datei mit Auschlussmustern (die nicht gesichert werden existiert, dann nutze sie)
[[ -f "/home/${SUB_DIR}/.exclude" ]] && EXCLUDE='--exclude-from="/home/${SUB_DIR}/.exclude"' || EXCLUDE=''

# Backup-Art je nach Argument
case "$1" in
  full)
    # Stelle sicher, dass Zielverzeichnis existiert 
    [[ -d ${FULLB} ]] || mkdir -p -m 777 ${FULLB}
    # Synchronisiere
    rsync -av $EXCLUDE ${SOURCE_DIR} ${FULLB}
    # Link to Latest
    ln -snf ${FULLB} ${LASTB}
    ;;
  incremental)
    # Stelle sicher, dass Zielverzeichnis existiert 
    [[ -d ${INCRB} ]] || mkdir -p -m 777 ${INCRB}
    # Synchronisiere
    rsync -av --link-dest=../../Latest $EXCLUDE ${SOURCE_DIR} ${INCRB}
    # Link to Latest
    ln -snf ${INCRB} ${LASTB}
    ;;
  differential)
    # Stelle sicher, dass Zielverzeichnis existiert 
    [[ -d ${DIFFB} ]] || mkdir -p -m 777 ${DIFFB}
    # Synchronisiere
    rsync -av --link-dest=../../Vollbackup $EXCLUDE ${SOURCE_DIR} ${DIFFB}
    # Link to Latest
    ln -snf ${DIFFB} ${LASTB}
    ;;
  *)
    echo "Usage: $0 {full|differential|incremental}"
    exit 1
    ;;
esac
