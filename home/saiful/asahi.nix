{
  pkgs,
  ...
}: {
  imports = [
    ./global
    ./features/desktop/hyprland
    # ./features/desktop/wireless
    # ./features/rgb
    # ./features/productivity
    ./features/pass
    # ./features/games
  ];

  # Purple
  wallpaper = pkgs.wallpapers.aenami-lost-in-between;

  #  ------   -----   ------
  # | DP-3 | | DP-1| | DP-2 |
  #  ------   -----   ------
  monitors = [
    {
      name = "eDP-1";
      width = 2560;
      height = 1600;
      workspace = "1";
      primary = true;
    }
  ];
}
