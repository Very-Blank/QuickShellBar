import QtQuick.Layouts
import Quickshell
import QtQuick

import qs.styled
import qs

Rectangle {
    implicitHeight: layout.implicitHeight
    implicitWidth: layout.implicitWidth + Config.styling.width
    radius: Config.styling.radius

    color: Config.palette.surface

    RowLayout {
        id: layout
        anchors.centerIn: parent

        RowLayout {
            SImage {
                Layout.alignment: Qt.AlignVCenter
                source: Qt.resolvedUrl("../icons/calendar.svg")
            }

            SText {
                Layout.alignment: Qt.AlignVCenter
                text: Qt.formatDateTime(clock.date, "ddd MMM d")
            }
        }

        RowLayout {
            SImage {
                Layout.alignment: Qt.AlignVCenter
                source: Qt.resolvedUrl("../icons/clock.svg")
            }

            SText {
                Layout.alignment: Qt.AlignVCenter
                text: Qt.formatDateTime(clock.date, "hh:mm")
            }
        }
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
