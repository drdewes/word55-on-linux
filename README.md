# Microsoft Word 5.5 (DOS) unter Linux — mit DOSBox-X

*Das echte MS Word 5.5 für DOS aus dem Jahr 1991 — gestochen scharf, mit
Umlauten, und so eingerichtet, dass es sauber speichert. Auf modernem Linux.*

![Microsoft Word 5.5 läuft unter Linux in DOSBox-X](docs/screenshot.png)

> **🇬🇧 English speakers:** this project is written **German-first** (I'm German),
> but it works exactly the same in English. A full **English section — including
> how to switch the keyboard to US/English — is at the [bottom](#english). 👇

> 📝 **Lieber WordStar oder WordPerfect?** Dasselbe gibt es als eigene Projekte:
> **[wordstar-on-linux](https://github.com/drdewes/wordstar-on-linux)** (WordStar 7.0)
> und **[wordperfect-on-linux](https://github.com/drdewes/wordperfect-on-linux)** (WordPerfect 5.1).

---

## Ehrliches Vorwort

Ich (Holger) bin **kein Programmierer** und hatte von GitHub vorher keine
Ahnung. Ich wollte einfach mein altes, geliebtes Word 5.5 wieder benutzen. Den
ganzen technischen Teil — die Konfiguration, die Skripte, dieses Repository —
hat mir **[Claude Code](https://claude.com/claude-code)** (die KI von Anthropic)
gebaut. Ich habe nur gesagt, was ich will, und getestet, ob es klappt.

Ich veröffentliche es, weil vielleicht jemand anderes auch Freude daran hat. 🙂

Und weil das mit KI so schön funktioniert hat, ist unten ein **fertiger Text
für „deinen" Claude Code** dabei: einfach reinkopieren, und die KI richtet dir
alles ein — genau wie bei mir.

---

## Warum überhaupt? Und was war das Problem?

DOSBox-X startet Word 5.5 an sich problemlos. Der Haken: DOSBox reicht dem alten
DOS deine **riesige moderne Festplatte** durch. Word ist ein 16-Bit-Programm von
1991 und verrechnet sich bei so großen Zahlen — Ergebnis: beim Speichern kommt
**„kein freier Speicher auf Datenträger"**, obwohl die Platte fast leer ist.

Die Lösung hier: Word bekommt eine **eigene kleine 100-MB-Festplatte** (ein
sogenanntes FAT16-Image). Die ist klein genug, dass Word sich nicht mehr
verrechnet — und schon klappt das Speichern. Der Installer baut diese
Mini-Festplatte automatisch aus deinen Word-Dateien.

---

## Voraussetzungen

- **DOSBox-X** und **mtools** (für den PDF-Export außerdem **LibreOffice**)
- Deine eigene Kopie von **Word 5.5 für DOS** (siehe nächster Abschnitt)

Installieren der Programme (Word selbst ist da noch nicht dabei):

| Distribution   | Befehl |
|----------------|--------|
| Arch / Manjaro | `sudo pacman -S mtools` + `dosbox-x` aus dem AUR (`yay -S dosbox-x`) |
| Debian / Ubuntu| `sudo apt install dosbox-x mtools` |
| Fedora         | `sudo dnf install dosbox-x mtools` |

Für PDF-Export zusätzlich `libreoffice`.

---

## Woher bekomme ich Word 5.5?

Word 5.5 für DOS ist **nicht** in diesem Repo (das gehört Microsoft, das dürfen
wir nicht weitergeben). Die gute Nachricht: Microsoft hat Word 5.5 für DOS um
das Jahr 2000 herum als **kostenlosen Download** freigegeben (damals als
„Y2K-Update"). Man findet es z. B. bei:

- **WinWorld** — <https://winworldpc.com/product/word/55>
- **Internet Archive** — <https://archive.org/> (nach „Microsoft Word 5.5 DOS" suchen)

Lade das Paket herunter und **entpacke** es. Du brauchst am Ende den Ordner, in
dem `WORD.EXE` liegt (oft heißt er `WORD`). Diesen Pfad fragt der Installer ab.

---

## Installation — zwei Wege

### Weg A: Selbst, mit einem Befehl

```sh
git clone https://github.com/drdewes/word55-on-linux.git
cd word55-on-linux
./install.sh
```

Das Skript fragt dich nach dem Ordner mit `WORD.EXE`, baut die Mini-Festplatte
und legt alles an seinen Platz. Danach:

```sh
word
```

### Weg B: Deine KI macht's für dich

Du hast [Claude Code](https://claude.com/claude-code)? Dann öffne die Datei
**[`CLAUDE-PROMPT.md`](CLAUDE-PROMPT.md)**, kopiere den Text daraus und füge ihn
in Claude Code ein. Die KI klont das Repo, prüft alles, fragt dich nach deinen
Word-Dateien und richtet es komplett ein — und hilft bei Problemen.

---

## Benutzung

| Befehl | Was es tut |
|--------|------------|
| `word` | startet Word 5.5 |
| `word-docs` | holt deine Texte aus Words Festplatte nach `~/Dokumente/word55` (Menü mit `fzf`) |
| `word-docs list` | zeigt, was in Words `C:\DOKUMENT` liegt |
| `word-docs import DATEI` | legt eine Linux-Datei in Words Festplatte |
| `word2pdf DATEI.RTF` | macht aus einer Word-Datei ein PDF (über LibreOffice) |

**Wichtig zum Speichern:** Speichere deine Texte in Word in den Ordner
`C:\DOKUMENT`. Diese Texte liegen dann *innerhalb* der Mini-Festplatte — mit
`word-docs` holst du sie bequem nach Linux (bzw. in deine Dropbox) heraus.

**PDF/Weitergeben:** Word 5.5 speichert in einem uralten Format, das sonst
niemand mehr liest. Am besten in Word **beim Speichern das Format „RTF"**
wählen — daraus macht `word2pdf` dann ein sauberes PDF (Umlaute inklusive).

---

## Was ist hier drin?

```
install.sh                     der Einrichter (baut die Mini-Festplatte)
config/dosbox-x-word55.conf    die fertige DOSBox-X-Konfiguration
scripts/word                   Starter für Word
scripts/word-docs              Dokumente rein/raus
scripts/word2pdf               RTF → PDF
CLAUDE-PROMPT.md               Text zum Einfügen in Claude Code (Weg B)
```

Es wird **nichts** aus dem Internet nachgeladen und **kein** root/sudo für die
Einrichtung selbst gebraucht (nur zum vorherigen Installieren der Programme).

---

## Verwandte Projekte

Dieselbe Behandlung — eigene Festplatte gegen „Datenträger voll", deutsche
Tastatur, scharfe Schrift — gibt es auch für zwei weitere DOS-Klassiker:

- **[wordstar-on-linux](https://github.com/drdewes/wordstar-on-linux)** — WordStar 7.0
- **[wordperfect-on-linux](https://github.com/drdewes/wordperfect-on-linux)** — WordPerfect 5.1

---

## Lizenz

Der Inhalt dieses Repos steht unter der **MIT-Lizenz** (siehe `LICENSE`) —
mach damit, was du willst. Die Lizenz betrifft **nur** die Konfiguration, die
Skripte und die Anleitung. **Microsoft Word 5.5 gehört Microsoft** und ist hier
nicht enthalten.

## Dank

Gebaut mit [Claude Code](https://claude.com/claude-code). Word 5.5 © Microsoft.
DOSBox-X vom DOSBox-X-Team. Danke an alle, die alte Software am Leben halten. 🖥️

---

## English

This project is **written in German first** — the author (Holger, a happy
non-programmer) built it for himself, together with
[Claude Code](https://claude.com/claude-code), and published it under MIT in
case someone else enjoys it too. Everything works **exactly the same in
English**; only a few labels and folder names are German. Here's the gist:

**What it does.** Run the real **MS Word 5.5 for DOS** on modern Linux via
DOSBox-X. DOSBox starts Word fine, but hands DOS your huge modern hard drive;
the 16-bit Word miscalculates and refuses to save ("disk full"). Fix: Word gets
its own small **100 MB FAT16 disk image**, small enough that it behaves. The
installer builds it automatically.

**Requirements:** `dosbox-x`, `mtools`, and `libreoffice` (for PDF export), plus
your own copy of Word 5.5 for DOS. Microsoft released it as a **free download**
around Y2K; find it at WinWorld (<https://winworldpc.com/product/word/55>) or the
Internet Archive. You need the folder containing `WORD.EXE`.

**Install:**

```sh
git clone https://github.com/drdewes/word55-on-linux.git
cd word55-on-linux
./install.sh        # asks for your WORD folder, builds the disk, installs everything
word                # start it
```

**Everyday use:**

| Command | What it does |
|---------|--------------|
| `word` | start Word 5.5 |
| `word-docs` | pull your texts out of Word's disk into `~/Dokumente/word55` |
| `word-docs list` | show what's in Word's `C:\DOKUMENT` |
| `word-docs import FILE` | put a Linux file onto Word's disk |
| `word2pdf FILE.RTF` | turn a Word file into a PDF (via LibreOffice) |

Save your texts to the folder **`C:\DOKUMENT`** inside Word; pull them out with
`word-docs`. For a **PDF**, save in Word as **RTF**, then run
`word2pdf FILE.RTF`.

**How to switch to an English / US keyboard.** The setup defaults to a German
keyboard. To change it, edit `~/.local/share/word55/dosbox-x-word55.conf`, find
the line

```
keyboardlayout                                   = gr
```

and change `gr` to your layout — e.g. `us` (US), `uk` (United Kingdom), `fr`,
`sp`, etc. Restart with `word`.

**A note on German labels.** Your documents live in the DOS folder `C:\DOKUMENT`
and are exported to `~/Dokumente/word55`. These names work regardless of your
system language; rename them in the config and in `scripts/word-docs` if you'd
prefer English ones.

**Related projects.** The same treatment for two more DOS classics:
[wordstar-on-linux](https://github.com/drdewes/wordstar-on-linux) (WordStar 7.0)
and [wordperfect-on-linux](https://github.com/drdewes/wordperfect-on-linux)
(WordPerfect 5.1).

**License:** MIT for the config, scripts and docs. **Microsoft Word 5.5 is not
included** and belongs to Microsoft.
