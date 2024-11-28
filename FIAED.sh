#!/bin/bash

# Überprüfen, ob ein Verzeichnis namens "Python" existiert. 
# Falls nicht, wird das Verzeichnis erstellt und darin die Unterordner "Projekt1", "Projekt2", "Projekt3"
# jeweils mit den Unterordnern "src" und "test".
[[ -d Python ]] || mkdir -p Python/Projekt{1..3}/{src,test}

# Überprüfen, ob eine Datei namens "bigfile" existiert.
# Falls nicht, wird eine Datei mit zufälligem Inhalt und einer Größe von 1 GB (1024*1024 Blöcke à 1024 Byte) erstellt.
[[ -f bigfile ]] || dd if=/dev/random of=bigfile bs=1024 count=$((1024*1024))

# Wechsel in das Verzeichnis "Python/Projekt1/src".
cd Python/Projekt1/src

# Überprüfen, ob die Datei "datei1" existiert.
# Falls nicht, wird eine leere Datei namens "datei1" erstellt.
[[ -f datei1 ]] || touch datei1

# Überprüfen, ob die Datei "hello.py" existiert.
# Falls nicht, wird eine Datei "hello.py" erstellt, die ein einfaches Python-Skript enthält, 
# das "hello world" ausgibt.
[[ -f hello.py ]] || cat << . > hello.py
print("hello world")
.

# Überprüfen, ob die Datei "hello2" existiert.
# Falls nicht, wird eine Datei "hello2" erstellt, die ein weiteres Python-Skript enthält, 
# aber mit einer Shebang, die angibt, dass das Skript mit python3 ausgeführt werden soll 
[[ -f hello2 ]] || cat << . > hello2
#!/bin/env python3
print("hello world")
.

# Die Datei "hello2" wird ausführbar gemacht für den Besitzer und die Gruppe.
chmod u+x,g+x hello2

# Überprüfen, ob eine Datei "bigfile" existiert.
# Falls nicht, wird eine harte Verknüpfung zur Datei "bigfile" im Home-Verzeichnis erstellt.
[[ -f bigfile ]] || ln ${HOME}/bigfile .

# Überprüfen, ob eine Datei "grosseDatei" existiert.
# Falls nicht, wird ein symbolischer Link zur Datei "bigfile" im Home-Verzeichnis erstellt.
[[ -f grosseDatei ]] || ln -s ${HOME}/bigfile grosseDatei
