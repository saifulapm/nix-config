{
  pkgs,
  inputs,
  default,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    # apple-silicon hardware support
    inputs.apple-silicon.nixosModules.apple-silicon-support

    ../common/global
    ../common/users/saiful

    ../common/optional/greetd.nix
    ../common/optional/pipewire.nix
    ../common/optional/quietboot.nix
    # ../common/optional/wireless.nix
  ];

  environment.systemPackages = with pkgs; [
    hello
  ];

  networking = {
    hostName = "asahi";
    useDHCP = true;
    wireless.iwd = {
      enable = true;
      settings.General.EnableNetworkConfiguration = true;
    };
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
  };

  # programs = {
  #   adb.enable = true;
  #   dconf.enable = true;
  # };

    # enable GPU support and audio
  hardware.asahi.useExperimentalGPUDriver = true;
  hardware.asahi.experimentalGPUInstallMode = "replace";
  hardware.asahi.setupAsahiSound = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  system.stateVersion = default.stateVersion;
}
