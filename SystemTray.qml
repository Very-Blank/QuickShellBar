import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

Rectangle {
    id: root
    implicitHeight: layout.implicitHeight
    implicitWidth: layout.implicitWidth + Config.padding.width
    radius: 3.5

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
                    // Makes the icons little blurry, but looks better.
                    sourceSize: Qt.size(width / 2, height / 2)
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
