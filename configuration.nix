# Studio-Setup
# User: studio | GNOME | Firefox | Zoom Workplace
# Komplett unabhaengig von der normalen nixDennis-Konfiguration.

{ config, lib, pkgs, ... }:

{
  #-- 1. BOOTLOADER & KERNEL
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  #-- 2. NETZWERK & LOKALISIERUNG
  networking.hostName = "studio";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "de";

  #-- 3. DESKTOP: GNOME + GDM
  services.xserver = {
    enable = true;
    xkb.layout = "de";
    xkb.options = "eurosign:e";
  };
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  #-- 4. AUDIO/VIDEO (wichtig fuer Zoom)
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  #-- 5. PROGRAMME
  # Zoom ist unfree -> muss erlaubt werden
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    firefox
    zoom-us   # Zoom Workplace Client
  ];

  #-- 6. USER
  users.users.studio = {
    isNormalUser = true;
    description = "studio";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    # Nach dem ersten Login mit `passwd` aendern!
    initialPassword = "workshop2026";
  };

  #-- 7. NIX-SETTINGS
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Gleicher Wert wie im Hauptsystem, da es dieselbe Maschine ist.
  system.stateVersion = "25.11";
}
