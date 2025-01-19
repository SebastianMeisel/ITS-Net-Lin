#!/bin/bash
# Das Skript zeigt eine digitale Uhr im Terminal mit großen ASCII-Ziffern an.

# In Zeile 88 verstecken wir den Cursor. Der folgende macht ihn wieder sicher, wenn das Programm
# durch ein SIGNAL wie KILL, TERM oder INT (Str-C) empfängt.
trap 'tput cnorm ; exit 0' SIGKILL SIGTERM SIGINT SIGSTOP

# Definition der ASCII-Zeichendarstellung für die Ziffern 0 bis 9 und den Doppelpunkt (:).
# Jede Ziffer und der Doppelpunkt bestehen aus 5 Zeilen.
ONE[1]="    11  "
ONE[2]="  11 1  "
ONE[3]="     1  "
ONE[4]="     1  "
ONE[5]="     1  "

# Analog für die Ziffer 2
TWO[1]="   22   "
TWO[2]="  2  2  "
TWO[3]="    2   "
TWO[4]="   2    "
TWO[5]="  2222  "

# Analog für die Ziffer 3
THREE[1]="  333   "
THREE[2]="     3  "
THREE[3]="   33   "
THREE[4]="     3  "
THREE[5]="  333   "

# Analog für die Ziffer 4
FOUR[1]="     4  "
FOUR[2]="   4    "
FOUR[3]="  4444  "
FOUR[4]="     4  "
FOUR[5]="     4  "

# Analog für die Ziffer 5
FIVE[1]="  5555  "
FIVE[2]="  5     "
FIVE[3]="  555   "
FIVE[4]="     5  "
FIVE[5]="  5555  "

# Analog für die Ziffer 6
SIX[1]="   666  "
SIX[2]="  6     "
SIX[3]="  666   "
SIX[4]="  6  6  "
SIX[5]="   66   "

# Analog für die Ziffer 7
SEVEN[1]="  7777  "
SEVEN[2]="    7   "
SEVEN[3]="   7    "
SEVEN[4]="  7     "
SEVEN[5]="  7     "

# Analog für die Ziffer 8
EIGHT[1]="   88   "
EIGHT[2]="  8  8  "
EIGHT[3]="   88   "
EIGHT[4]="  8  8  "
EIGHT[5]="   88   "

# Analog für die Ziffer 9
NINE[1]="   99   "
NINE[2]="  9  9  "
NINE[3]="   999  "
NINE[4]="     9  "
NINE[5]="  999   "

# Analog für die Ziffer 0
ZERO[1]="  000   "
ZERO[2]=" 0   0  "
ZERO[3]=" 0   0  "
ZERO[4]=" 0   0  "
ZERO[5]="  000   "

# Analog für den Doppelpunkt
COLON[1]="        "
COLON[2]="  :::   "
COLON[3]="        "
COLON[4]="  :::   "
COLON[5]="        "

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

	sleep 1 # 1 Sekunde warten und dann die Schleife neu starten.
done
