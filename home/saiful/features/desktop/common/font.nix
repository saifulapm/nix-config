{pkgs, ...}: {
  fontProfiles = {
    enable = true;
    monospace = {
      name = "FiraCode Nerd Font";
      package = pkgs.fira-code-nerdfont;
    };
    regular = {
      name = "Fira Sans";
      package = pkgs.fira;
    };
  };
}
