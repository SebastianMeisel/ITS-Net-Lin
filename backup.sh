#!/bin/bash
SUB_DIR="bros"
BACKUP_DIR="/backup/"
SOURCE_DIR="/home/${SUB_DIR}"

# Datum im Format YYYYMMDD
DATE=$(date +%Y%m%d)

FULLB="${BACKUP_DIR}/Vollbackup
INCRB="${BACKUP_DIR}/Inkrementell/${DATE}"
DIFFB="${BACKUP_DIR}/Differentiell"
LASTB="${BACKUP_DIR}/Latest"

# Backup-Art je nach Argument
case "$1" in
  full)
    # Stelle sicher, dass Zielverzeichnis existiert 
    [[ -d "${FULLB}"]] || mkdir -p -m 777 "${FULLB}"
    # Synchronisiere
    rsync -av "${SOURCE_DIR/}" "${FULLB}"
    # Link to Latest
    ln -snf "${FULLB}/${SUB_DIR" "${LASTB}"
    ;;
  incremental)
    # Stelle sicher, dass Zielverzeichnis existiert 
    [[ -d "${INCRB}"]] || mkdir -p -m 777 "${INCRB}"
    # Synchronisiere
    rsync -av --link-dest="${LASTB}" "${SOURCE_DIR}" "${INCRB}"
    # Link to Latest
    ln -snf "${INCRB}/${SUB_DIR" "${LASTB}"
    ;;
  differential)
    # Stelle sicher, dass Zielverzeichnis existiert 
    [[ -d "${DIFFB}"]] || mkdir -p -m 777 "${DIFFB}"
    # Synchronisiere
    rsync -av --link-dest="${FULLB}" "${SOURCE_DIR}" "${DIFFB}"
    # Link to Latest
    ln -snf "${DIFFB}/${SUB_DIR" "${LASTB}"
    ;;
  *)
    echo "Usage: $0 {full|differential|incremental}"
    exit 1
    ;;
esac
