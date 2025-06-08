# Bash Statusbar Scripts für dwmblocks

Dieses Repository enthält eine Sammlung von Bash-Skripten, die Systeminformationen für Statusleisten ausgeben. Die Skripte sind speziell für dwmblocks optimiert und in zwei Versionen verfügbar.

## 🌟 Branches

### `feature-color` Branch
- **Zweck**: Skripte mit Farbunterstützung für dwmblocks
- **Farbcodes**: Verwendet `\x01` bis `\x06` für verschiedene Farben
- **Kompatibilität**: Nur für dwmblocks mit Farbpatch

### `no-color` Branch  
- **Zweck**: Skripte ohne Farbcodes für Standard-Statusleisten
- **Ausgabe**: Reine Textausgabe ohne Formatierung
- **Kompatibilität**: Universell einsetzbar (i3blocks, polybar, etc.)

## 🎨 Farbcode-Mapping (nur feature-color branch)

Basierend auf `~/repo/cleanDWM/dwm/config.def.h`:
- `\x01`: Normaler Text (SchemeNorm)
- `\x02`: Selektiert (SchemeSel)
- `\x03`: Warnung (SchemeWarn)  
- `\x04`: Dringend (SchemeUrgent)
- `\x05`: Icon1 (gelb auf grau)
- `\x06`: Icon2 (weiß auf orange)

## 📋 Skripte

### `ip.sh` 󰩟
- Zeigt die lokale IP-Adresse an
- Mehrere Fallback-Methoden für robuste IP-Erkennung
- Unterstützt verschiedene Netzwerk-Tools (ip, nmcli, hostname)

### `battery.sh` 🔋
- Batteriestatus mit Prozentanzeige und Ladestatus
- Unterstützt BAT0 und BAT1
- Kritische Batterie-Benachrichtigungen
- Icons: 󰂎 bis 󰁹 (je nach Batteriestand)

### `volume.sh` 🔊
- Lautstärke-Anzeige mit Mute-Status
- Unterstützt amixer und pactl
- Verschiedene Icons je nach Lautstärke
- Icons: 🔊/🔉/🔈/🔇

### `dateTime.sh` 🕐
- Datum und Uhrzeit mit stundenbasiertem Icon
- Robuste Datumsformatierung
- Icons: 🕛 bis 🕚 (12-Stunden-Format)

### `mic.sh` 🎤
- Mikrofon Ein/Aus Status
- Mehrere Erkennungsmethoden (amixer, pactl)
- Fallback für verschiedene Audio-Systeme

### `display.sh` 💡
- Bildschirmhelligkeit in Prozent
- Unterstützt brillo, brightnessctl, sysfs, xrandr
- Automatische Helligkeitserkennung
- Icons: 󰛩 bis 󰛨

### `name.sh` 👤
- Zeigt aktuellen Benutzernamen an
- Icon: 󰚭

### `testScripts.sh` 🧪
- Umfassendes Test-Skript für alle Statusbar-Skripte
- Überprüft Syntax und Ausführung aller Skripte
- Validiert Ausgabeformate
- Unterstützt verbose Modus (`--verbose`)
- Farbcodierte Statusmeldungen

## 🚀 Installation

### 1. Repository klonen
```bash
git clone https://github.com/Nico1109/nico-statusbar.git
cd nico-statusbar
```

### 2. Branch auswählen

**Für dwmblocks mit Farbunterstützung:**
```bash
git checkout feature-color
```

**Für Standard-Statusleisten ohne Farben:**
```bash
git checkout no-color
```

### 3. Skripte ausführbar machen
```bash
chmod +x *.sh
```

### 4. In dwmblocks integrieren

Bearbeiten Sie Ihre `~/.config/dwmblocks/config.h` oder `blocks.h`:

```c
static const Block blocks[] = {
    {"", "/pfad/zu/den/skripten/volume.sh",     1},
    {"", "/pfad/zu/den/skripten/battery.sh",   60},
    {"", "/pfad/zu/den/skripten/display.sh",   1},
    {"", "/pfad/zu/den/skripten/ip.sh",        60},
    {"", "/pfad/zu/den/skripten/dateTime.sh",  60},
    {"", "/pfad/zu/den/skripten/name.sh",      0},
};
```

### 5. dwmblocks neu kompilieren
```bash
cd ~/.config/dwmblocks
sudo make clean install
```

## 📦 Abhängigkeiten

### Erforderlich:
- `bash` - Für die Skripte
- `coreutils` - Grundlegende Unix-Tools

### Optional (automatische Fallbacks):
- `brillo` oder `brightnessctl` - Für Helligkeitskontrolle
- `amixer` oder `pactl` - Für Audio-Kontrolle  
- `nmcli` - Für Netzwerk-Informationen
- `notify-send` - Für Benachrichtigungen

## 🔧 Konfiguration

Die Skripte funktionieren ohne weitere Konfiguration. Bei Bedarf können Sie:

1. **Icons anpassen**: Ändern Sie die `icon=` Variablen in den Skripten
2. **Benachrichtigungen**: Passen Sie die `notify-send` Befehle an
3. **Aktualisierungsintervalle**: Ändern Sie die Intervalle in der dwmblocks-Konfiguration

## ✨ Verbesserungen in dieser Version

- 🛡️ Robuste Fehlerbehandlung in allen Skripten
- 🔄 Multiple Fallback-Methoden für bessere Kompatibilität  
- ✅ Validierung aller Eingaben und Ausgaben
- 📢 Verbesserte Benutzerbenachrichtigungen
- 🎯 Konsistente Ausgabeformate
- ⚡ Bessere Performance durch optimierte Befehle
- 🎨 Vollständige Farbunterstützung für dwmblocks

## 🤝 Contributing

Verbesserungen und zusätzliche Skripte sind willkommen! Bitte öffnen Sie einen Pull Request.

## 📄 License

Dieses Repository steht unter der MIT-Lizenz. Siehe [LICENSE](LICENSE) für Details.