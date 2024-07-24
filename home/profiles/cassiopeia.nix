{ lib, pkgs, ... }:
with lib; {
  imports = [ ../modules ./common/convertible.nix ];

  siren.programs = {
    vscode.enable = true;
    alacritty.enable = true;
    direnv.enable = true;
    neovim.enable = true;
    rust.enable = true;
  };
  
  fonts.fontconfig.enable = true;
  
  services.kdeconnect = {
    enable = true;
    indicator = false;
  };
  
  # fonts.fontconfig.enable = true;
  
  home.packages = with pkgs; [
    
  ];
}