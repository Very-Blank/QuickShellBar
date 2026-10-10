import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

Rectangle {
    id: root
    Layout.alignment: Qt.AlignVCenter
    implicitHeight: layout.implicitHeight + 10
    implicitWidth: layout.implicitWidth + 10
    radius: 3.5

    color: "dimgray"

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

                implicitWidth: 20
                implicitHeight: 20

                Image {
                    anchors.fill: parent
                    source: item.modelData.icon
                    sourceSize: Qt.size(width, height)
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
