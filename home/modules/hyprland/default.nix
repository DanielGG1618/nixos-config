{ pkgs, lib, config, ... }:
let
  colors = config.stylix.base16Scheme;

  musicWindowSelector = "initialTitle:(Yandex Music)";
  tasksWindowSelector = "initialTitle:(Todoist)";
  socialWindowSelector = "initialTitle:(Telegram)";
in {
  imports = [
    ./hyprlock.nix
    ./hypridle.nix
    ./binds.nix
    ./hyprpaper.nix
  ];

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    animation = "specialWorkspace, 1, 6, default, slidefadevert -50%";
    workspace = [
      "special:obsidian, rounding:false, decorate:false, gapsin:0, gapsout:0, border:false"

      "special:tasks, monitor:0"
      "special:music, monitor:0"
      "special:social, monitor:0"
    ];
    windowrulev2 = [
      "workspace special:obsidian, class:(obsidian)"

      "workspace special:tasks, ${tasksWindowSelector}"
      "float, ${tasksWindowSelector}"
      "size 38% 1224, ${tasksWindowSelector}" # 1224 = 1300 (screen h) - gaps and something more
      "move 100%-w-18 58, ${tasksWindowSelector}" # TODO replace 6 with gapsout global const
      "stayfocused, ${tasksWindowSelector}"
      "rounding 6, ${tasksWindowSelector}"
      "bordercolor rgba(e34331c0), ${tasksWindowSelector}"

      "workspace special:music, ${musicWindowSelector}"
      "float, ${musicWindowSelector}"
      "center, ${musicWindowSelector}"
      "size 720 1080, ${musicWindowSelector}"
      "stayfocused, ${musicWindowSelector}"
      "bordercolor rgba(fed42bc0), ${musicWindowSelector}"

      "workspace special:social, ${socialWindowSelector}"
      "float, ${socialWindowSelector}"
      "center, ${socialWindowSelector}"
      "size 38% 1224, ${socialWindowSelector}"
      "move 18 58, ${socialWindowSelector}" # TODO replace 6 with gapsout global const
      "rounding 6, ${socialWindowSelector}"
      "bordercolor rgba(8f99f5c0), ${socialWindowSelector}"
    ];

    exec-once = [
      (lib.getExe pkgs.waybar)
      (lib.getExe pkgs.hyprpaper)
    ];

    cursor = {
      inactive_timeout = 3;
      hide_on_key_press = true;
      hide_on_touch = true;

      no_warps = false;
      persistent_warps = true;
      warp_on_change_workspace = true;

      enable_hyprcursor = false;
    };

    general = {
      gaps_in = 3;
      gaps_out = 6;
      border_size = 3;

      "col.active_border" = "rgba(${colors.base0C}ff) rgba(${colors.base08}ff) 270deg";
      "col.inactive_border" = "rgba(${colors.base04}80)";

      layout = "dwindle";
    };

    decoration = {
      rounding = 12;

      drop_shadow = true;
      shadow_range = 12;
      shadow_render_power = 2;
      "col.shadow" = "rgba(${colors.base01}ff)";
      "col.shadow_inactive" = "rgba(00000000)";

      blur = {
        enabled = true;
        xray = true;
      };
    };

    misc = {
      disable_hyprland_logo = true;
      disable_autoreload = true;
      background_color = lib.mkForce "rgb(000000)";
    };

    animations = {
      enabled = true;
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    input = {
      kb_layout = "us, ru";
      kb_options = "grp:alt_shift_toggle";

      follow_mouse = 1;
      mouse_refocus = true;

      sensitivity = 0.5;

      touchpad = {
        natural_scroll = true;
        scroll_factor = 0.5;
        clickfinger_behavior = true;
      };
    };

    gestures = {
      workspace_swipe = true;
    };

    monitor = import ./monitor.nix;

    windowrule = [
      "opacity 0.7 override, title:^(Mozilla Firefox)$"
    ];
  };
}
