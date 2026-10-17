pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: config
    component Palette: QtObject {
        // Surfaces (darkest to lightest layer)
        property color background       // main bar / window background
        property color surface          // cards, popups, module pills
        property color surfaceHigh      // hovered or raised elements

        // Text
        property color foreground       // primary text
        property color foregroundMuted  // secondary text, inactive icons

        // Accent
        property color accent           // focus, active workspace, sliders

        // Semantic
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

    component Bar: QtObject {
        property int extraHeight
        property int spacing
        property int margins
    }

    readonly property Palette palette: Palette {
        background: "#16161E"       // base00
        surface: "#2F3549"          // base02
        surfaceHigh: "#444B6A"      // base03

        foreground: "#CBCCD1"       // base06
        foregroundMuted: "#787C99"  // base04

        accent: "#7AA2F7"           // base0D

        error: "#F7768E"            // base08
        warning: "#E0AF68"          // base0A
        success: "#41A6B5"          // base0B
        info: "#7DCFFF"             // base0C
    }

    readonly property Fonts fonts: Fonts {
        mono: "JetBrainsMono Nerd Font Mono"

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
}
