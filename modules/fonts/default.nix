{ lib, pkgs, config, ... }:
let cfg = config.siren.fonts;
in
{
  options.siren.fonts.enable = lib.mkEnableOption "fonts";

  config = lib.mkIf cfg.enable {
    fonts.packages = with pkgs.nerd-fonts; [
      symbols-only
      bitstream-vera-sans-mono
      caskaydia-cove
      code-new-roman
      comic-shanns-mono
      dejavu-sans-mono
      fira-code
      fira-mono
      hack
      im-writing
      jetbrains-mono
      martian-mono
      monaspace
      mononoki
      noto
      proggy-clean-tt
      recursive-mono
      roboto-mono
      shure-tech-mono
      sauce-code-pro
      ubuntu-mono
      victor-mono
    ];

    fonts.fontDir.enable = true;
    fonts.fontconfig.enable = true;
    fonts.enableDefaultPackages = lib.mkForce false;

    console.font = ./monocraft.psf;
  };
}
