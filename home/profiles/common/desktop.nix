{ lib, pkgs, flake-self, config, system-config, ... }:
with lib; {
  imports = [ ./common.nix ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    # Browser
    firefox

    # E-Mail
    thunderbird

    # Messengers
    discord
    element-desktop
    signal-desktop

    # Video
    shotcut # video editor
    obs-studio # video streaming
    jellyfin-ffmpeg # transcoding

    # Audio
    friture # spectrogram
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
    cmake
    arduino-ide
    adafruit-nrfutil

    # 3D
    bambu-studio # 3D printing
    orca-slicer # slicer
    blender # 3D animation
    freecad # CAD
    openscad # scriptable CAD

    # Text
    artem # ASCII art
    logseq # knowledge base
    obsidian # knowledge base

    # Documents
    libreoffice
    pandoc # document conversion
    texliveFull # LaTeX

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
