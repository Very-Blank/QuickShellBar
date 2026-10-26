pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.SystemTray
import QtQuick.Layouts
import QtQuick

import qs

Rectangle {
    id: root
    implicitHeight: layout.implicitHeight
    implicitWidth: layout.implicitWidth + Config.modules.extraWidth
    radius: Config.modules.radius

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

				QsMenuAnchor {
					id: menuAnchor
					anchor.item: parent
					menu: modelData.menu
				}

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton

                    onClicked: mouse => {
                        const data = item.modelData;

                        switch (mouse.button) {
                        case Qt.LeftButton:
                            if (data.onlyMenu && data.hasMenu)
                                menuAnchor.open();
                            else
                                data.activate();
                            break;
                        case Qt.MiddleButton:
                            data.secondaryActivate();
                            break;
                        case Qt.RightButton:
                            if (data.hasMenu)
                                menuAnchor.open();
                            break;
                        }
                    }
                }
            }
        }
    }
}
