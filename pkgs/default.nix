inputs:
final: prev: {

  # our packages are accessible via siren.<name>
  siren = {
    set-performance = prev.pkgs.callPackage ./set-performance { };
  };

}
