# NixOS Config

## Ressources

* [NixOS manual](https://nixos.org/nixos/manual/)
* [NixOS search options](https://search.nixos.org/options)
* [NixOS search packages](https://search.nixos.org/packages)
* [Home Manager manual](https://nix-community.github.io/home-manager/)
* [Home Manager options](https://rycee.gitlab.io/home-manager/options.xhtml)
* [Blog post about different Nix commands](https://mayniklas.de/posts/linux/nixos/2023-07-22-nix-commands/)

## Commands

```sh
# show nix tree without building it first (sizes won't be accurate)
nix-tree --derivation  .\#nixosConfigurations.cassiopeia.config.system.build.toplevel

# show nix tree with building it first (sizes will be accurate)
nix-tree $(nix build --print-out-paths .\#nixosConfigurations.cassiopeia.config.system.build.toplevel)
```
