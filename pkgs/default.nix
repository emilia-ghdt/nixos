inputs:
self: super: {

  # our packages are accessible via siren.<name>
  siren = {
    set-performance = super.pkgs.callPackage ./set-performance { };
  };

}
