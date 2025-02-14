#!/bin/bash
# Das Skript zeigt eine digitale Uhr im Terminal mit großen ASCII-Ziffern an.

# In Zeile 88 verstecken wir den Cursor. Der folgende macht ihn wieder sicher, wenn das Programm
# durch ein SIGNAL wie KILL, TERM oder INT (Str-C) empfängt.
trap 'tput cnorm ; exit 0' SIGKILL SIGTERM SIGINT SIGSTOP

source ASCIIZiffern
# Endlosschleife, um die Uhr kontinuierlich zu aktualisieren.
while true; do
	clear      # Bildschirm leeren,
	tput civis # Cursor ausblende,
	echo       # und eine Leerzeile ausgeben.

	# Die ASCII-Zeilen der Uhr werden nacheinander ausgegeben.
	for zeile in {1..5}; do # Jede Ziffer besteht aus 5 Zeilen.
		# Das aktuelle Datum im Format HH:MM:SS wird zeichenweise durchlaufen.
		for char in $(date +%H:%M:%S | fold -w1); do
			# Jeder einzelne Buchstabe/Ziffer wird über ein `case`-Statement verarbeitet.
			case $char in
			1)
				echo -n "${ONE[$zeile]}" # Ziffer 1 in der aktuellen Zeile ausgeben.
				;;
			2)
				echo -n "${TWO[$zeile]}" # Ziffer 2 ...
				;;
			3)
				echo -n "${THREE[$zeile]}" # Ziffer 3 ...
				;;
			4)
				echo -n "${FOUR[$zeile]}" # Ziffer 4 ...
				;;
			5)
				echo -n "${FIVE[$zeile]}" # Ziffer 5 ...
				;;
			6)
				echo -n "${SIX[$zeile]}" # Ziffer 6 ...
				;;
			7)
				echo -n "${SEVEN[$zeile]}" # Ziffer 7 ...
				;;
			8)
				echo -n "${EIGHT[$zeile]}" # Ziffer 8 ...
				;;
			9)
				echo -n "${NINE[$zeile]}" # Ziffer 9 ...
				;;
			0)
				echo -n "${ZERO[$zeile]}" # Ziffer 0 ...
				;;
			:)
				echo -n "${COLON[$zeile]}" # Doppelpunkt.
				;;
			esac
		done
		# Nach jeder Zeile der Ziffern wird ein Zeilenumbruch ausgegeben.
		printf "\n"

	done

	# Datum im Format Wochentag, Tag. Monat. Jahr in Variable speichern 
	DATUM=$(date +"%A, %d. %B. %Y")
	# Textbreite der Uhr speichern
	UHRBREITE=64
	# Datum zentriert ausgeben.
	printf "\n%$((($UHRBREITE+${#DATUM})/2))s\n" "${DATUM}"
	sleep 1 # 1 Sekunde warten und dann die Schleife neu starten.
done
