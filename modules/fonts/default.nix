{ lib, pkgs, config, ... }:
let cfg = config.siren.fonts;
in
{
  options.siren.fonts.enable = lib.mkEnableOption "fonts";

  config = lib.mkIf cfg.enable {
    fonts.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" "BitstreamVeraSansMono" "CascadiaCode" "CodeNewRoman" "ComicShannsMono" "DejaVuSansMono" "FiraCode" "FiraMono" "Hack" "iA-Writer" "JetBrainsMono" "MartianMono" "Monaspace" "Mononoki" "Noto" "ProggyClean" "Recursive" "RobotoMono" "ShareTechMono" "SourceCodePro" "UbuntuMono" "VictorMono" ]; })
    ];

    fonts.fontDir.enable = true;
    fonts.fontconfig.enable = true;
    fonts.enableDefaultPackages = lib.mkForce false;

    console.font = ./monocraft.psf;
  };
}
