pragma ComponentBehavior: Bound

import Quickshell.Io
import QtQuick

import qs.styled
import qs

Rectangle {
    id: root
    implicitHeight: icon.implicitHeight
    implicitWidth: icon.implicitWidth + Config.modules.extraWidth
    radius: Config.modules.radius

    color: Config.palette.surface

    property bool capslock: false

    SImage {
        id: icon
        anchors.centerIn: parent
        source: root.capslock ? Qt.resolvedUrl("../icons/lockOn.svg") : Qt.resolvedUrl("../icons/lockOff.svg")
    }

    Process {
        id: capslockInfo
        command: ["sh", "-c", "cat /sys/class/leds/input*::capslock/brightness"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const lines = this.text.split("\n");
                root.capslock = lines.reduce((a, b) => a || parseInt(b) == 1, false);
            }
        }
    }

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            capslockInfo.running = true;
        }
    }
}
