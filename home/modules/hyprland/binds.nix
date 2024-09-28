{ config, lib, pkgs, ... }: 
let
  resizeStep = "16";

  utils = import ./utils.nix; 

  cfg = config.my.hyprland;
  terminal = cfg.terminal;
in with pkgs // lib;
{
  options.my.hyprland = {
    terminal = mkOption {
      type = types.str;
      default = "kitty";
    };
  };

  config.wayland.windowManager.hyprland.extraConfig = ''
    bind = ALT, r, submap, resize
    submap = resize
    binde = , h, resizeactive, -${resizeStep} 0
    binde = , j, resizeactive, 0 ${resizeStep}
    binde = , k, resizeactive, 0 -${resizeStep}
    binde = , l, resizeactive, ${resizeStep} 0
    bind = , catchall, submap, reset 
    submap = reset
  '';

  config.wayland.windowManager.hyprland.settings."$mainMod" = "SUPER";

  config.wayland.windowManager.hyprland.settings.bind = [
    "$mainMod, RETURN, exec, ${terminal}"
    "$mainMod, Q, killactive"
    "$mainMod, M, exit"

    '', print, exec, ${getExe grim} -g "$(${getExe slurp} -w 0)" - | ${wl-clipboard}/bin/wl-copy''
    ''$mainMod, print, exec, ${getExe grim} -o "$(${hyprland}/bin/hyprctl activeworkspace -j | ${getExe jq} -r '.monitor')" - | ${wl-clipboard}/bin/wl-copy''

    "$mainMod, TAB, workspace, r+1"
    "$mainMod SHIFT, TAB, workspace, r-1"
    
    "$mainMod, F, fullscreen, 0"
    "$mainMod SHIFT, F, togglefloating, active"
    "$mainMod, P, pin, active"
    "$mainMod, c, centerwindow,"
  ] 
  ++ utils.directionsBind "$mainMod" "movefocus"
  ++ utils.directionsBind "$mainMod CTRL" "swapwindow" 
  ++ utils.digitsBind "$mainMod" "workspace"
  ++ utils.digitsBind "$mainMod SHIFT" "movetoworkspace"
  ++ utils.modifiedDirectionsBind "mon:" "$mainMod SHIFT" "movewindow" 
  ;
  
  config.wayland.windowManager.hyprland.settings.bindm = [
    "$mainMod, mouse:272, movewindow"
    "$mainMod SHIFT, mouse:272, resizewindow"
  ];

  config.wayland.windowManager.hyprland.settings.bindel = [
    ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"
    ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
  ];
  config.wayland.windowManager.hyprland.settings.bindl = [
    ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
  ];
}