import QtQuick
import QtQuick.Layouts

import qs

Rectangle {
    id: root
    implicitHeight: layout.implicitHeight
    implicitWidth: layout.implicitWidth
    radius: Config.styling.radius

    color: Config.palette.surface

    property string window: ""

    RowLayout {
        id: layout
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            right: parent.right
        }

        spacing: 0

        Repeater {
            model: NiriService.windows[window] !== undefined ? NiriService.windows[window].workspaces : []

            Rectangle {
                required property var modelData
                readonly property bool active: NiriService.windows[window].active === modelData.index

                Layout.fillHeight: true

                implicitHeight: text.implicitHeight
                implicitWidth: text.implicitWidth + Config.styling.width
                radius: Config.styling.radius
                color: active ? Config.palette.surfaceHigh : Config.palette.surface

                Text {
                    id: text
                    anchors.centerIn: parent
                    text: modelData.index

                    color: active ? Config.palette.foreground : Config.palette.foregroundMuted

                    font {
                        family: Config.fonts.mono
                        pixelSize: Config.fonts.normal
                        bold: true
                    }
                }
            }
        }
    }
}
