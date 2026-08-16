# Studio-Setup (temporär)

Eigenständige NixOS-Flake-Konfiguration für einen 3-Tage-Workshop.
User `studio`, GNOME, Firefox, Zoom Workplace.

## 1. Vorbereitung (einmalig)

Die Hardware-Datei gehört mit ins Repo, sonst kann die Flake sie nicht sehen
(Flakes lesen nur Dateien, die in Git eingecheckt sind):

```bash
cp /pfad/zu/deiner/hardware_thinkpad.nix ./hardware-configuration.nix
git init
git add .
git commit -m "Studio-Setup"
git remote add origin git@github.com:DEINUSER/nix-workshop.git
git push -u origin main
```

Hinweis: Die Datei enthält nur Platten-UUIDs und Kernel-Module — keine
Geheimnisse. Für ein öffentliches Repo unbedenklich.

## 2. Auf dem Laptop aktivieren

```bash
git clone https://github.com/DEINUSER/nix-workshop.git
cd nix-workshop
sudo nixos-rebuild switch --flake .#studio
```

Danach neu starten (sauberer Wechsel GDM/Session) und als `studio` einloggen.
Passwort: `workshop2026` → nach dem ersten Login mit `passwd` ändern.

## 3. Zurück zum normalen Setup

Option A (empfohlen): aus deiner alten Config neu bauen

```bash
cd /pfad/zu/deiner/haupt-config
sudo nixos-rebuild switch --flake .#nixDennis
```

Option B: beim Booten im systemd-boot-Menü eine ältere Generation wählen
(nur als schneller Notfall-Rollback gedacht).

## Wichtige Hinweise

- `/home/dennis` bleibt komplett unangetastet. Der User `dennis` wird
  standardmäßig (mutableUsers = true) auch nicht gelöscht, nur ist in der
  Workshop-Config kein Home-Manager für ihn aktiv.
- Achtung Garbage Collector: dein Hauptsystem löscht Generationen älter
  als 7 Tage. Verlass dich für den Rückweg deshalb NICHT auf das
  Boot-Menü, sondern baue aus deiner alten Flake neu (Option A).
- Den User `studio` und `/home/studio` kannst du nach dem Workshop
  manuell entfernen: `sudo userdel -r studio`.
