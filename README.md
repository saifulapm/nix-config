# My NixOS configurations

Here's my NixOS/home-manager config files. Requires [Nix flakes](https://nixos.wiki/wiki/Flakes).

Looking for something simpler to start out with flakes? Try [my starter config repo](https://github.com/Misterio77/nix-starter-config).

**Highlights**:

- Multiple **NixOS configurations**, including **desktop**, **laptop**, **server**
- **Opt-in persistence** through impermanence + blank snapshotting
- **Encrypted** single **BTRFS** partition
- Fully **declarative** **self-hosted** stuff
- Deployment **secrets** using **sops-nix**
- **Mesh networked** hosts with **tailscale** and **headscale**
- Flexible **Home Manager** Configs through **feature flags**
- Extensively configured wayland environments (**sway** and **hyprland**) and editor (**neovim**)
- **Declarative** **themes** and **wallpapers** with **nix-colors**
- **Hydra CI/CD server and binary cache** that uses the **desktops as remote builders**
