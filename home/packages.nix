{ pkgs, ... }: {
  home.packages = with pkgs; [
    vial
    discord
  ];
}
