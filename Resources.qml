import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    Layout.alignment: Qt.AlignVCenter
    implicitHeight: text.implicitHeight + 10
    implicitWidth: text.implicitWidth + 10
    radius: 3.5

    color: "dimgray"

    property int memoryUsage
    property int cpuUsage

    Text {
        id: text
        text: "CPU: " + root.cpuUsage + "% " + "MEM: " + root.memoryUsage + "%"
        anchors.centerIn: parent

        color: "gainsboro"
    }

    Process {
        id: memoryProcess
        command: ["sh", "-c", "free | grep Mem"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;

                var parts = data.trim().split(/\s+/);
                var total = parseInt(parts[1]) || 1;
                var used = parseInt(parts[2]) || 0;

                root.memoryUsage = Math.round(100 * used / total);
            }
        }
    }

    Process {
        id: cpuProcess
        command: ["sh", "-c", "head -1 /proc/stat"]
        running: true

        stdout: SplitParser {
            property int lastCpuTotal
            property int lastCpuIdle
            onRead: data => {
                if (!data)
                    return;
                var p = data.trim().split(/\s+/);
                var idle = parseInt(p[4]) + parseInt(p[5]);
                var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0);

                if (lastCpuTotal > 0) {
                    root.cpuUsage = Math.round(100 * (1 - (idle - lastCpuIdle) / (total - lastCpuTotal)));
                }

                lastCpuTotal = total;
                lastCpuIdle = idle;
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            cpuProcess.running = true;
            memoryProcess.running = true;
        }
    }
}
