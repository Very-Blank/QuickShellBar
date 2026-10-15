import Quickshell
import QtQuick
import qs

Rectangle {
    id: root

    implicitHeight: icon.implicitHeight
    implicitWidth: icon.implicitWidth + Config.styling.width
    radius: Config.styling.radius

    color: Config.palette.surface

    property string icon

    signal activated

    SImage {
        id: icon
        anchors.centerIn: parent

        source: Quickshell.iconPath(root.icon)
        sourceSize: Qt.size(8, 8)
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton

        onDoubleClicked: root.activated()
    }
}
