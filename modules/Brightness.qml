pragma ComponentBehavior: Bound

import QtQuick.Layouts
import Quickshell.Io
import QtQuick

import qs.styled
import qs

Rectangle {
    id: root
    implicitHeight: layout.implicitHeight
    implicitWidth: layout.implicitWidth + Config.modules.extraWidth
    radius: Config.modules.radius

    color: Config.palette.surface

    property int level: 0

    RowLayout {
        id: layout
        anchors.centerIn: parent

        SImage {
            Layout.alignment: Qt.AlignVCenter
            source: Qt.resolvedUrl("../icons/brightnessFull.svg")
        }

        SText {
            Layout.alignment: Qt.AlignVCenter
            text: root.level + "%"
        }
    }

    Process {
        id: process
        command: [Config.paths.sh, "-c", `${Config.paths.echo} \"$(${Config.paths.brightnessctl} get) $(${Config.paths.brightnessctl} max)\"`]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const lines = this.text.trim().split(" ");
                const max = parseInt(lines[1]);
                const current = parseInt(lines[0]);
                root.level = Math.round(100 * (current / max));
            }
        }
    }

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            process.running = true;
        }
    }
}
