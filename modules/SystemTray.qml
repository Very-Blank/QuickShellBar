import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

import qs

Rectangle {
    id: root
    implicitHeight: layout.implicitHeight
    implicitWidth: layout.implicitWidth + Config.styling.width
    radius: Config.styling.radius

    color: Config.palette.surface

    RowLayout {
        id: layout
        anchors.centerIn: parent
        spacing: 6

        Repeater {
            model: SystemTray.items

            Item {
                id: item
                required property SystemTrayItem modelData

                Layout.alignment: Qt.AlignVCenter

                implicitHeight: 20
                implicitWidth: 20

                Image {
                    anchors.fill: parent
                    source: item.modelData.icon
                    sourceSize: Qt.size(width, height)
                    antialiasing: true
                }

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton

                    onClicked: mouse => {
                        const data = item.modelData;
                        if (mouse.button === Qt.LeftButton && data.hasMenu) {
                            data.activate();
                        }
                    }
                }
            }
        }
    }
}
