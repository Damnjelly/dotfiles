{ pkgs, config, lib, ... }:
let
  # Startup script
  startupScript = pkgs.writeShellScriptBin "start" ''
    ${pkgs.swww}/bin/swww init &
    ${pkgs.foot}/bin/foot ${pkgs.zellij}/bin/zellij -l ~/.config/zellij/quickstart.kdl
  '';
in {
  stylix.targets.hyprland.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = "${startupScript}/bin/start";
      monitor = [
        "HDMI-A-1,																		highres,	0x0,		1, transform,1"
        "desc:Lenovo Group Limited G27q-20 U6330RM1,	highrr,		1080x0,	1"
        "desc:Lenovo Group Limited P27h-30 V30A4WKZ,	highres,	3640x0,	1"
      ];

      # Set programs that you use
      "$terminal" = "foot zellij -l ~/.config/zellij/quickstart.kdl";
      "$fileManager" = "yazi";
      "$menu" = "rofi -show drun -show-icons";

      # Some default env vars.
      env = [
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt5ct" # change to qt6ct if you have that
      ];

      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        follow_mouse = 1;
        touchpad = { natural_scroll = "no"; };
        sensitivity = 0; # -1.0 to 1.0, 0 means no modification.
      };

      general = with config.lib.stylix.colors; {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = 6;
        gaps_out = 12;

        border_size = 4;
        "col.active_border" = lib.mkForce "rgb(${base0C}) rgb(${base0D}) 60deg";
        "col.inactive_border" = lib.mkForce "rgb(${base01})";

        layout = "dwindle";

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        inactive_opacity = 0.85;
        rounding = 2;
        blur = { enabled = false; };
        drop_shadow = false;
      };

      animations = {
        enabled = "yes";

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.4, 0.45, 0.35, 1.125";

        animation = [
          "windows, 1, 7, myBezier, slide"
          "windowsOut, 1, 7, myBezier, slide"
          "windowsMove, 1, 7, default"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = "yes"; # you probably want this
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true;
      };

      gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = "off";
      };

      misc = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        force_default_wallpaper = -1; # Set to 0 or 1 to disable the anime mascot wallpapers
      };

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      windowrulev2 = [
        "suppressevent maximize, class:.*" # Youll probably like this.

        # These should never have opacity
        "opacity 1.0 override,class:^(net-runelite-client-RuneLite)$"
        "opacity 1.0 override,class:^(firefox)$"
        "opacity 1.0 override,class:^(vesktop)$"
        "workspace 1 silent,class:^(vesktop)$"
        "workspace 2 silent,class:^(foot)$"
      ];

      workspace = [ "2,border:false,rounding:false,gapsout:0" "1,border:false,rounding:false,gapsout:0" ];

      "$mainMod" = "SUPER";

      bind = [
        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, V, togglefloating,"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod, R, togglesplit, # dwindle"

        # Move focus with mainMod + arrow keys
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"
       
       # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # App launcher
        "$mainMod, S, exec, $menu"
        "$mainMod, A, exec, ~/Documents/popup-opener.sh sunbeam"

        # Rectangle screenshot
        ''ALT SHIFT, S, exec, IMG=~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%m-%s).png && grim -g "$(slurp -w 0)" $IMG && wl-copy < $IMG''
        # Screenshot active window
        "CTRL ALT, S, exec, IMG=~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%m-%s).png && MONITOR=$(hyprctl activeworkspace -j | jq .monitor -r) && grim -o $MONITOR $IMG && wl-copy < $IMG"
      ];

      bindm = [ "$mainMod, mouse:272, movewindow" "ALT, mouse:272, resizewindow" ];
    };
  };
}
