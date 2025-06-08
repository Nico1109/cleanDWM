# Statusbar Position Anpassen

## Manuelle Positionseinstellung

Ich habe eine Variable `statusbar_offset` hinzugefügt, mit der du die Position der Statusleiste manuell anpassen kannst.

### So funktioniert es:

1. **Öffne die Datei:** `config.h` (oder `config.def.h` für permanente Änderungen)

2. **Finde diese Zeile:**
   ```c
   static const int statusbar_offset   = 0;        /* manual statusbar horizontal offset adjustment */
   ```

3. **Ändere den Wert:**
   - **Positive Werte** (z.B. `+50`): Statusleiste wird nach **rechts** verschoben
   - **Negative Werte** (z.B. `-50`): Statusleiste wird nach **links** verschoben
   - **0**: Standardposition (automatische Berechnung)

### Beispiele:

```c
static const int statusbar_offset   = -100;  // Statusleiste 100px nach links
static const int statusbar_offset   = 50;    // Statusleiste 50px nach rechts  
static const int statusbar_offset   = 0;     // Standardposition
```

### Nach der Änderung:

1. Kompiliere dwm neu: `make clean && make`
2. Starte dwm neu oder verwende die Reload-Funktion

### Problemlösung:

- **Statusleiste zu weit rechts:** Verwende negative Werte (z.B. -50, -100)
- **Statusleiste zu weit links:** Verwende positive Werte (z.B. +50, +100)
- **Text wird abgeschnitten:** Justiere den Wert schrittweise in 25er Schritten

### Aktuelle Funktionalität:

- ✅ Farbcodes (\x01-\x1F) werden bei der Breitenberechnung ignoriert
- ✅ Manuelle Positionsanpassung über `statusbar_offset`
- ✅ Click-Detection funktioniert mit dem Offset
- ✅ Kompiliert ohne Fehler
