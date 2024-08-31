{ lib, pkgs, flake-self, config, system-config, ... }:
{
  home.packages = with pkgs; [
    prismlauncher # modded minecraft launcher
  ];
}