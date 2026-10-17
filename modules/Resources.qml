pragma ComponentBehavior: Bound

import Quickshell.Io
import QtQuick.Layouts
import QtQuick

import qs.styled
import qs

Rectangle {
    id: root
    implicitHeight: layout.implicitHeight
    implicitWidth: layout.implicitWidth + Config.modules.extraWidth
    radius: Config.modules.radius

    color: Config.palette.surface

    property int memoryUsage
    property int cpuUsage

    RowLayout {
        id: layout
        anchors.centerIn: parent
        spacing: 8

        RowLayout {
            Layout.alignment: Qt.AlignVCenter

            SImage {
                id: cpuIcon
                Layout.alignment: Qt.AlignVCenter
                source: Qt.resolvedUrl("../icons/cpu.svg")
            }

            SText {
                id: cpuText
                Layout.alignment: Qt.AlignVCenter
                text: root.cpuUsage + "%"

                color: root.cpuUsage <= 40 ? Config.palette.foreground : root.cpuUsage <= 80 ? Config.palette.warning : Config.palette.error
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignVCenter

            SImage {
                id: memIcon
                Layout.alignment: Qt.AlignVCenter
                source: Qt.resolvedUrl("../icons/ram.svg")
            }

            SText {
                id: memText
                Layout.alignment: Qt.AlignVCenter
                text: root.memoryUsage + "%"

                color: root.memoryUsage <= 40 ? Config.palette.foreground : root.memoryUsage <= 80 ? Config.palette.warning : Config.palette.error
            }
        }
    }

    FileView {
        id: memInfo
        path: "/proc/meminfo"

        onLoaded: {
            const m = text().match(/^MemTotal:\s+(\d+)[\s\S]*?^MemAvailable:\s+(\d+)/m);
            if (!m)
                return;

            const total = parseInt(m[1]);
            const avail = parseInt(m[2]);
            if (total > 0)
                root.memoryUsage = Math.round(100 * (total - avail) / total);
        }
    }

    FileView {
        id: cpuStatus
        path: "/proc/stat"

        property real lastTotal: 0
        property real lastIdle: 0

        onLoaded: {
            const line = text().split("\n")[0];
            const p = line.trim().split(/\s+/);
            const idle = parseInt(p[4]) + parseInt(p[5]);
            const total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0);

            if (lastTotal > 0)
                root.cpuUsage = Math.round(100 * (1 - (idle - lastIdle) / (total - lastTotal)));

            lastTotal = total;
            lastIdle = idle;
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            cpuStatus.reload();
            memInfo.reload();
        }
    }
}
