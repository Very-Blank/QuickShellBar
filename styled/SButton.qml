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

        source: Qt.resolvedUrl(root.icon)
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton

        onDoubleClicked: root.activated()
    }
}
