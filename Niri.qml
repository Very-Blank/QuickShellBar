import QtQuick

Rectangle {
    id: root
    implicitHeight: text.implicitHeight
    implicitWidth: text.implicitWidth + Config.styling.width
    radius: Config.styling.radius

    color: Config.palette.surface

    property bool capslock: false

    Text {
        id: text
        anchors.centerIn: parent

        text: NiriService.workspace

        color: Config.palette.foreground

        font {
            family: Config.fonts.mono
            pixelSize: Config.fonts.normal
            bold: true
        }
    }
}
