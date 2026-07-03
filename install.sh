#!/bin/sh
# install.sh — richtet Microsoft Word 5.5 (DOS) unter Linux mit DOSBox-X ein.
#
# Was das Skript tut:
#   1. prueft, ob die noetigen Programme da sind (dosbox-x, mtools)
#   2. fragt, wo deine Word-5.5-Dateien liegen (der Ordner mit WORD.EXE)
#   3. baut daraus ein kleines FAT16-Festplatten-Image (damit Word korrekt
#      speichern kann) und legt es in ~/.local/share/word55/ ab
#   4. installiert die Konfiguration und die Helfer-Skripte (word, word-docs,
#      word2pdf) nach ~/.local/bin
#
# Es laedt NICHTS aus dem Internet und braucht kein root/sudo.
# Word selbst ist NICHT dabei (Microsoft-Copyright) — die besorgst du dir
# separat, siehe README.
set -eu

SHARE="$HOME/.local/share/word55"
BIN="$HOME/.local/bin"
HERE="$(cd "$(dirname "$0")" && pwd)"

say()  { printf '\033[1;36m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!!\033[0m %s\n' "$*" >&2; }
die()  { printf '\033[1;31mFehler:\033[0m %s\n' "$*" >&2; exit 1; }

# --- 1) Abhaengigkeiten -----------------------------------------------------
say "Pruefe benoetigte Programme ..."
missing=""
command -v dosbox-x >/dev/null 2>&1 || missing="$missing dosbox-x"
command -v mcopy    >/dev/null 2>&1 || missing="$missing mtools"
command -v mpartition >/dev/null 2>&1 || missing="$missing mtools"
if [ -n "$missing" ]; then
	warn "Es fehlen:$missing"
	cat <<EOF

Bitte zuerst installieren. Beispiele je nach Distribution:
  Arch/Manjaro:   sudo pacman -S dosbox-x mtools
                  (dosbox-x ggf. aus dem AUR, z.B. 'yay -S dosbox-x')
  Debian/Ubuntu:  sudo apt install dosbox-x mtools
  Fedora:         sudo dnf install dosbox-x mtools

Fuer den PDF-Export (optional) zusaetzlich 'libreoffice'.
Danach install.sh erneut starten.
EOF
	exit 1
fi
command -v libreoffice >/dev/null 2>&1 || warn "libreoffice fehlt — 'word2pdf' (PDF-Export) geht dann nicht. Optional."

# --- 2) Word-Dateien finden -------------------------------------------------
SRC="${1:-}"
if [ -z "$SRC" ]; then
	cat <<EOF

Wo liegt dein Word-5.5-Programmordner (der mit WORD.EXE darin)?
Beispiel: /home/du/Downloads/worddos/WORD
EOF
	printf 'Pfad: '
	read -r SRC
fi
SRC="${SRC%/}"
[ -d "$SRC" ] || die "Ordner nicht gefunden: $SRC"
if [ ! -f "$SRC/WORD.EXE" ] && [ ! -f "$SRC/word.exe" ]; then
	die "In '$SRC' liegt keine WORD.EXE. Bitte den richtigen Ordner angeben."
fi
say "Word-Dateien: $SRC"

# --- 3) Zielstruktur + Image bauen -----------------------------------------
mkdir -p "$SHARE"
IMG="$SHARE/word55hd.img"
if [ -f "$IMG" ]; then
	warn "Es gibt schon ein Image: $IMG"
	printf 'Neu bauen und ueberschreiben? [j/N] '
	read -r a; case "$a" in j|J|y|Y) : ;; *) die "Abgebrochen (dein Image bleibt unangetastet)." ;; esac
fi

say "Baue FAT16-Festplatten-Image (100 MB) ..."
# Geometrie 812 Zyl. x 4 Koepfe x 63 Sektoren = ~100 MB. Diese Geometrie ist
# genau die, die DOSBox-X bei IMGMOUNT erwartet -> Image mountet zuverlaessig.
CYL=812; HEADS=4; SEC=63
truncate -s $((CYL*HEADS*SEC*512)) "$IMG"
RC="$(mktemp)"
trap 'rm -f "$RC"' EXIT
printf 'drive z: file="%s" cylinders=%d heads=%d sectors=%d mformat_only partition=1\n' \
	"$IMG" "$CYL" "$HEADS" "$SEC" > "$RC"
export MTOOLSRC="$RC"
mpartition -I z: >/dev/null 2>&1 || true
mpartition -c -t "$CYL" -h "$HEADS" -s "$SEC" z:
mformat z:                                   # FAT16 (Groesse < 2 GB)

say "Kopiere Word ins Image ..."
mmd z:/WORD z:/DOKUMENT
# Alle Programmdateien hinein (Gross-/Kleinschreibung egal)
mcopy -o -s "$SRC"/* z:/WORD/ >/dev/null 2>&1 || mcopy -o "$SRC"/* z:/WORD/ >/dev/null 2>&1
# Rechtschreib-Lexikon, falls vorhanden, auch in den Wurzelordner
for lex in "$SRC"/SPELL-GE.LEX "$SRC"/spell-ge.lex; do
	[ -f "$lex" ] && mcopy -o "$lex" z:/ >/dev/null 2>&1 || true
done
say "Image fertig: $IMG"

# --- 4) Konfiguration + Skripte installieren --------------------------------
say "Installiere Konfiguration ..."
sed "s#__HOME__#$HOME#g" "$HERE/config/dosbox-x-word55.conf" > "$SHARE/dosbox-x-word55.conf"

say "Installiere Skripte nach $BIN ..."
mkdir -p "$BIN"
for s in word word-docs word2pdf; do
	install -m 0755 "$HERE/scripts/$s" "$BIN/$s"
done

case ":$PATH:" in
	*":$BIN:"*) : ;;
	*) warn "$BIN ist nicht in deinem PATH. Fuege in ~/.bashrc oder ~/.zshrc hinzu:"
	   printf '      export PATH="$HOME/.local/bin:$PATH"\n' ;;
esac

printf '\n\033[1;32mFertig!\033[0m Microsoft Word 5.5 ist eingerichtet.\n'
cat <<EOF

  Starten:            word
  Dokumente holen:    word-docs         (aus dem Image nach ~/Dokumente/word55)
  PDF aus RTF machen: word2pdf DATEI.RTF

In Word speicherst du deine Texte am besten in den Ordner  C:\\DOKUMENT
(dann findest du sie mit 'word-docs' schnell wieder).

Viel Spass mit einem Stueck Software-Geschichte!
EOF
