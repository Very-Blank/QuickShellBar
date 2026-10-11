import Quickshell.Io
import QtQuick.Effects
import QtQuick

Rectangle {
    id: root
    implicitHeight: icon.implicitHeight
    implicitWidth: icon.implicitWidth + Config.padding.width
    radius: 3.5

    color: Config.palette.surface

    property bool capslock: false

    Image {
        id: icon
        anchors.centerIn: parent
        source: root.capslock ? Qt.resolvedUrl("icons/lockOn.svg") : Qt.resolvedUrl("icons/lockOff.svg")
        sourceSize: Qt.size(16, 16)

        layer {
            enabled: true
            effect: MultiEffect {
                brightness: 1.0
            }
        }
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
