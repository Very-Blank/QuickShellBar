pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.services
import qs

Rectangle {
    id: root
    implicitHeight: layout.implicitHeight
    implicitWidth: layout.implicitWidth
    radius: Config.modules.radius

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
            model: NiriService.windows[root.window] !== undefined ? NiriService.windows[root.window].workspaces : []

            Rectangle {
                id: workspace

                required property var modelData
                readonly property bool active: NiriService.windows[root.window].active === modelData.index

                Layout.fillHeight: true

                implicitHeight: text.implicitHeight
                implicitWidth: text.implicitWidth + Config.modules.extraWidth
                radius: Config.modules.radius
                color: active ? Config.palette.surfaceHigh : Config.palette.surface

                Text {
                    id: text
                    anchors.centerIn: parent
                    text: workspace.modelData.index

                    color: workspace.active ? Config.palette.foreground : Config.palette.foregroundMuted

                    font {
                        family: Config.fonts.mono
                        pixelSize: Config.fonts.normal
                        bold: true
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton

                    onClicked: () => {
                        NiriService.switchToWorkspace(workspace.modelData.id);
                    }
                }
            }
        }
    }
}
