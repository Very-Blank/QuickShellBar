{
  paths ? {
    sh = "sh";
    cat = "cat";
    echo = "echo";
    brightnessctl = "brightnessctl";
    pavucontrol = "pavucontrol";
  },
  features ? {
    niriWorkspaces = false;
    audio = false;
    brightness = false;
    battery = false;
  },
  fontFamily,
  palette,
}: let
  boolToStr = bool:
    if bool
    then "true"
    else "false";
in ''
  pragma Singleton

  import Quickshell
  import QtQuick

  Singleton {
      id: config
      component Palette: QtObject {
          property color background
          property color surface
          property color surfaceHigh
          property color foreground
          property color foregroundMuted
          property color accent
          property color error
          property color warning
          property color success
          property color info
      }
      component Fonts: QtObject {
          property string mono
          property string icons
          property int small
          property int normal
          property int large
          property int icon
      }
      component Modules: QtObject {
          property int extraHeight
          property int extraWidth
          property real radius
      }
      component Features: QtObject {
          property bool niriWorkspaces
      }
      component Bar: QtObject {
          property int extraHeight
          property int spacing
          property int margins
      }
      component Paths: QtObject {
          property string sh
          property string cat
          property string echo
          property string brightnessctl
          property string pavucontrol
      }
      readonly property Palette palette: Palette {
          background: "${palette.base00}"
          surface: "${palette.base02}"
          surfaceHigh: "${palette.base03}"
          foreground: "${palette.base06}"
          foregroundMuted: "${palette.base04}"
          accent: "${palette.base0D}"
          error: "${palette.base08}"
          warning: "${palette.base0A}"
          success: "${palette.base0B}"
          info: "${palette.base0C}"
      }
      readonly property Fonts fonts: Fonts {
          mono: "${fontFamily}"
          small: 11
          normal: 13
          large: 16
          icon: 16
      }
      readonly property Modules modules: Modules {
          extraWidth: 22
          radius: 10
      }
      readonly property Bar bar: Bar {
          extraHeight: 15
          spacing: 8
          margins: 4
      }
      readonly property Paths paths: Paths {
          property string sh: "${paths.sh}"
          property string cat: "${paths.cat}"
          property string echo: "${paths.echo}"
          property string brightnessctl: "${paths.brightnessctl}"
          property string pavucontrol: "${paths.pavucontrol}"
      }
      readonly property Features features: Features {
          property bool niriWorkspaces: ${boolToStr features.niriWorkspaces}
          property bool audio: ${boolToStr features.audio}
          property bool brightness: ${boolToStr features.brightness}
          property bool battery: ${boolToStr features.battery}
      }
  }
''
