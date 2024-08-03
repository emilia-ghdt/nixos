{ lib, pkgs, config, ... }:
with lib;
let cfg = config.siren.fonts;
in
{
  options.siren.fonts.enable = mkEnableOption "fonts";

  config = mkIf cfg.enable {
    fonts.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" "BitstreamVeraSansMono" "CascadiaCode" "CodeNewRoman" "ComicShannsMono" "DejaVuSansMono" "FiraCode" "FiraMono" "Hack" "iA-Writer" "JetBrainsMono" "MartianMono" "Monaspace" "Mononoki" "Noto" "ProggyClean" "Recursive" "RobotoMono" "ShareTechMono" "SourceCodePro" "UbuntuMono" "VictorMono" ]; })
    ];
    fonts.fontDir.enable = true;

    # Not working
    # console.font = "${pkgs.scientifica}/share/fonts/truetype/scientifica.ttf";
  };
}
