{ lib, pkgs, ... }: {
  wayland.windowManager.hyprland.settings.exec = [
    # "${lib.getExe pkgs.hypridle} &"
  ];

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "${lib.getExe pkgs.hyprlock}";
        before_sleep_cmd = "${lib.getExe pkgs.hyprlock}";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "${lib.getExe pkgs.hyprlock}";
        }
        {
          timeout = 305;
          on-timeout = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
          on-resume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
