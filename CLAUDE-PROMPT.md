# Text zum Einfügen in Claude Code

Du hast [Claude Code](https://claude.com/claude-code) installiert und möchtest,
dass die KI dir Word 5.5 komplett einrichtet? Dann kopiere **den ganzen Block
unten** und füge ihn in Claude Code ein. Mehr musst du nicht tun — die KI fragt
dich nach dem, was sie braucht.

*(Copy the block below and paste it into Claude Code — it will do the rest.)*

---

```text
Ich möchte Microsoft Word 5.5 für DOS auf meinem Linux-Rechner einrichten und
benutze dafür das Projekt „word55-on-linux". Ich bin kein Programmierer – bitte
führe mich freundlich und in einfachen Worten durch alles und erledige die
technischen Schritte für mich.

Bitte gehe so vor:

1. Klone das Repository, falls noch nicht vorhanden:
   git clone https://github.com/drdewes/word55-on-linux.git
   und wechsle hinein. Lies die README.md und install.sh, damit du den Aufbau
   verstehst.

2. Prüfe, ob die benötigten Programme installiert sind: dosbox-x und mtools
   (sowie libreoffice für den optionalen PDF-Export). Falls etwas fehlt, gib
   mir den passenden Installationsbefehl für meine Distribution zum Kopieren
   (ich habe kein passwortloses sudo, führe root-Befehle also NICHT selbst aus).

3. Word 5.5 selbst ist aus Copyright-Gründen NICHT im Repo. Erkläre mir kurz,
   dass Microsoft Word 5.5 für DOS früher als kostenlosen Download freigegeben
   hat (z. B. bei WinWorld: https://winworldpc.com/product/word/55 oder im
   Internet Archive). Frage mich, ob ich die Dateien schon habe. Wenn ja, frage
   nach dem Pfad zum Ordner, in dem WORD.EXE liegt. Wenn nein, hilf mir beim
   Herunterladen und Entpacken.

4. Führe dann ./install.sh aus (oder rufe es mit dem WORD-Ordner als Argument
   auf). Das Skript baut ein kleines FAT16-Festplatten-Image aus meinen
   Word-Dateien (nötig, damit Word korrekt speichern kann) und installiert die
   Konfiguration und die Helfer-Skripte (word, word-docs, word2pdf).

5. Prüfe, ob ~/.local/bin in meinem PATH ist. Falls nicht, hilf mir, das zu
   ergänzen.

6. Erkläre mir am Ende in einfachen Worten:
   - starten mit „word“
   - in Word Texte in den Ordner C:\DOKUMENT speichern
   - Texte mit „word-docs“ nach Linux holen
   - zum Weitergeben in Word als „RTF“ speichern und mit „word2pdf DATEI.RTF“
     ein PDF erzeugen

Wenn beim Starten oder Speichern etwas nicht klappt (z. B. eine Fehlermeldung
in DOSBox-X), lies sie mit mir zusammen und behebe das Problem. Teste nach
Möglichkeit selbst, statt es nur mir zu überlassen.
```

---

Wenn dabei etwas hakt, kannst du deiner KI natürlich einfach in eigenen Worten
sagen, was nicht klappt — sie kennt jetzt den Zusammenhang.
