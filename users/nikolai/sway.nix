{ config, pkgs, ... }:
let
  menu = "rofi -show run";
  modifier = "Mod1";
  down  = "j";
  left  = "h";
  right = "l";
  up    = "k";
  resizeAmount = "30px";
  filebrowser = "nemo";
  webbrowser = "chrome";
  webbrowserPersistent = "firefox";
  musicplayer = "spotify";
in
{
  wayland.windowManager = {
    sway = {
      enable = true;
      package = pkgs.unstable.sway;
      wrapperFeatures.gtk = true ;
      
      config = {
        gaps = {
          smartBorders = "on";
          smartGaps = true;
        };
  
        floating.border = 1;
        window.border = 1;
  
        fonts = {
          names = [ "Fira Code" ];
          style = "Regular Bold";
          size = 8.0;
        };
  
        menu = menu;
        modifier = modifier;
        left = left;
        down = down;
        up = up;
        right = right;
 
        input = {
          "*" = {
            xkb_layout = "us";
            xkb_options = "ctrl:nocaps";
          };
        };
        keybindings = {
          # Exit sway
          "${modifier}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
          # Reload the configuration file
          "${modifier}+Shift+r" = "reload";
          # Kill focused window
          "${modifier}+Shift+q" = "kill";
          "${modifier}+d" = "exec ${menu}";
          "${modifier}+x" = "exec tilix";
          # Move your focus around
          "${modifier}+${left}" = "focus left";
          "${modifier}+${down}" = "focus down";
          "${modifier}+${up}" = "focus up";
          "${modifier}+${right}" = "focus right";
          # With arrow keys
          "${modifier}+Left" = "focus left";
          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+Right" = "focus right";
          # Move the focused window with the same, but add Shift
          "${modifier}+Shift+${left}" = "move left";
          "${modifier}+Shift+${down}" = "move down";
          "${modifier}+Shift+${up}" = "move up";
          "${modifier}+Shift+${right}" = "move right";
          # With arrow keys
          "${modifier}+Shift+Left" = "focus left";
          "${modifier}+Shift+Down" = "focus down";
          "${modifier}+Shift+Up" = "focus up";
          "${modifier}+Shift+Right" = "focus right";
          # Workspaces
          # Switch to workspace
          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";
          "${modifier}+0" = "workspace number 10";
          # Move focused container to workspace
          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";
          "${modifier}+Shift+0" = "move container to workspace number 10";
          "${modifier}+b" = "splith";
          "${modifier}+v" = "splitv";
          # Switch the current container between different layout styles
          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+e" = "layout toggle split";
          # Make the current focus fullscreen
          "${modifier}+f" = "fullscreen";
          # Toggle the current focus between tiling and floating mode
          "${modifier}+Shift+space" = "floating toggle";
          # Swap focus between the tiling area and the floating area
          "${modifier}+space" = "focus mode_toggle";
          # Move focus to the parent container
          "${modifier}+a" = "focus parent";
          # Resizing containers
          "${modifier}+r" = "mode 'resize'";
  
        };
  
        modes = {
          resize = {
            "${modifier}+${left}" = "resize shrink width ${resizeAmount}";
            "${modifier}+${down}" = "resize grow height ${resizeAmount}";
            "${modifier}+${up}" = "resize shrink height ${resizeAmount}";
            "${modifier}+${right}" = "resize grow width ${resizeAmount}";
            "${modifier}+Left" = "resize shrink width ${resizeAmount}";
            "${modifier}+Down" = "resize grow height ${resizeAmount}";
            "${modifier}+Up" = "resize shrink height ${resizeAmount}";
            "${modifier}+Right" = "resize grow width ${resizeAmount}";
            "Return" = "mode 'default'";
            "Escape" = "mode 'default'";
          };
  
        };
  
        startup = [
          { command = "mako"; }
        ];
  
        terminal = "tilix";

        window.titlebar = false;
  
      };
    };
  };
}

