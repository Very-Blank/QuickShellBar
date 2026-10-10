import Quickshell
import QtQuick
import QtQuick.Layouts

Rectangle {
    Layout.alignment: Qt.AlignVCenter
    implicitHeight: text.implicitHeight + 10
    implicitWidth: text.implicitWidth + 10
    radius: 3.5

    color: "dimgray"

    Text {
        id: text
        anchors.centerIn: parent
        text: Qt.formatDateTime(clock.date, "ddd MMM d hh:mm:ss AP")

        color: "gainsboro"
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
