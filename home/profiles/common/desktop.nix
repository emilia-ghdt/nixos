{ lib, pkgs, ... }:
{
  imports = [ ./common.nix ];

  siren.programs = {
    alacritty.enable = true;
    # hyprland.enable = true;
    sway.enable = true;
    # rust.enable = true;
    vscode.enable = true;
  };
  siren.fonts.enable = true;

  home.packages = with pkgs; [
    # Browser
    firefox

    # E-Mail
    thunderbird

    # Messengers
    discord
    element-desktop
    signal-desktop

    # Meetings
    zoom-us

    # Video
    stableRelease.shotcut # video editor
    obs-studio # video streaming
    jellyfin-ffmpeg # transcoding

    # Audio
    stableRelease.friture # spectrogram
    audacity # audio recording

    # Image
    gimp # image editor
    darktable

    # Media player
    vlc
    spotify

    # PCB
    kicad

    # Development
    arduino-ide
    adafruit-nrfutil

    # 3D
    stableRelease.bambu-studio # 3D printing
    stableRelease.orca-slicer # slicer
    blender # 3D animation
    freecad # CAD
    openscad # scriptable CAD

    # Text
    artem # ASCII art
    obsidian # knowledge base

    # Documents
    libreoffice
    pandoc # document conversion
    texliveFull # LaTeX
    pdfpc # pdf presenter

    # Utils
    popsicle # USB flasher
    ddcutil # monitor settings
    ddcui # monitor settings
    vial # keyboard firmware settings
    screen-message

    # Network
    zap # proxy for pentesting
    teamviewer # remote desktop
    parsec-bin # remote desktop
    netbird-ui # wireguard mesh vpn
    openconnect # cisco vpn

    # custom packages
    siren.set-performance
  ];
}
