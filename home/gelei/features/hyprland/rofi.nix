{ config, ... }: {
  home = with config.lib.stylix.colors; {
    file.".config/rofi/config.rasi".text = ''
      /**
       *
       * Author : Aditya Shakya (adi1090x)
       * Github : @adi1090x
       * 
       * Rofi Theme File
       * Rofi Version: 1.7.3
       **/

      /*****----- Configuration -----*****/
      configuration {
      	modi:                       "drun";
          show-icons:                 true;
          display-drun:               "";
      	drun-display-format:        "{name}";
        font: "${config.stylix.fonts.monospace.name}";
      }

      /*****----- Global Properties -----*****/
      * {
          background:     #${base05}FF;
          background-alt: #${base0C}FF;
          foreground:     #${base00}FF;
          selected:       #${base01}FF;
          active:         #${base01}FF;
          urgent:         #${base08}FF;
      }

      /*****----- Main Window -----*****/
      window {
          transparency:                "real";
          location:                    center;
          anchor:                      center;
          fullscreen:                  false;
          width:                       400px;
          x-offset:                    0px;
          y-offset:                    0px;

          enabled:                     true;
          margin:                      0px;
          padding:                     0px;
          border:                      3px solid;
          border-radius:               12px;
          border-color:                @selected;
          background-color:            @background;
          cursor:                      "default";
      }

      /*****----- Main Box -----*****/
      mainbox {
          enabled:                     true;
          spacing:                     0px;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px 0px 0px 0px;
          border-color:                @selected;
          background-color:            transparent;
          children:                    [ "inputbar", "listview" ];
      }

      /*****----- Inputbar -----*****/
      inputbar {
          enabled:                     true;
          spacing:                     8px;
          margin:                      0px;
          padding:                     10px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @selected;
          background-color:            @selected;
          text-color:                  @background;
          children:                    [ "prompt", "entry" ];
      }

      prompt {
          enabled:                     true;
          background-color:            inherit;
          text-color:                  inherit;
      }
      textbox-prompt-colon {
          enabled:                     true;
          expand:                      false;
          str:                         "::";
          background-color:            inherit;
          text-color:                  inherit;
      }
      entry {
          enabled:                     true;
          background-color:            inherit;
          text-color:                  inherit;
          cursor:                      text;
          placeholder:                 "Search...";
          placeholder-color:           inherit;
      }

      /*****----- Listview -----*****/
      listview {
          enabled:                     true;
          columns:                     1;
          lines:                       8;
          cycle:                       true;
          dynamic:                     true;
          scrollbar:                   false;
          layout:                      vertical;
          reverse:                     false;
          fixed-height:                true;
          fixed-columns:               true;
          
          spacing:                     5px;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @selected;
          background-color:            transparent;
          text-color:                  @foreground;
          cursor:                      "default";
      }
      scrollbar {
          handle-width:                5px ;
          handle-color:                @selected;
          border-radius:               0px;
          background-color:            @background-alt;
      }

      /*****----- Elements -----*****/
      element {
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     8px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @selected;
          background-color:            transparent;
          text-color:                  @foreground;
          cursor:                      pointer;
      }
      element normal.normal {
          background-color:            @background;
          text-color:                  @foreground;
      }
      element selected.normal {
          background-color:            @background-alt;
          text-color:                  @foreground;
      }
      element-icon {
          background-color:            transparent;
          text-color:                  inherit;
          size:                        32px;
          cursor:                      inherit;
      }
      element-text {
          background-color:            transparent;
          text-color:                  inherit;
          highlight:                   inherit;
          cursor:                      inherit;
          vertical-align:              0.5;
          horizontal-align:            0.0;
      }

      /*****----- Message -----*****/
      error-message {
          padding:                     15px;
          border:                      2px solid;
          border-radius:               12px;
          border-color:                @selected;
          background-color:            @background;
          text-color:                  @foreground;
      }
      textbox {
          background-color:            @background;
          text-color:                  @foreground;
          vertical-align:              0.5;
          horizontal-align:            0.0;
          highlight:                   none;
      }
    '';
  };
}
