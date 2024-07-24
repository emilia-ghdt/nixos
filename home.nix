{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];  

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "emilia";
  home.homeDirectory = "/home/emilia";

  home.packages = with pkgs; [
    firefox
    thunderbird
    vscodium
    neovim
    git
    cmake
    discord
    blender
    kicad
    spotify
    obsidian
    freecad
    gimp
    btop
    tree
    du-dust
    ripgrep
    libreoffice
    zap
    xournalpp
    teamviewer
    parsec-bin
    audacity
    friture
    mozwire
    wireguard-tools
    netbird-ui
    python3
    cargo
    rustc
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Secrets
  sops.defaultSopsFile = ./secrets.yaml;
  sops.defaultSopsFormat = "yaml";
 
  sops.age.keyFile = "/home/emilia/.config/sops/age/keys.txt";
}
