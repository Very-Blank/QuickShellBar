import Quickshell
import QtQuick.Layouts
import QtQuick

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: panel

            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: Math.max(layoutLeft.implicitHeight, layoutMiddle.implicitHeight, layoutRight.implicitHeight) + Config.styling.height

            color: Config.palette.background

            RowLayout {
                id: layoutLeft

                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                    margins: 4
                }

                spacing: 8
            }

            RowLayout {
                id: layoutMiddle

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    bottom: parent.bottom
                    margins: 4
                }

                spacing: 8

                Clock {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillHeight: true
                }
            }

            RowLayout {
                id: layoutRight

                anchors {
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                    margins: 4
                }

                spacing: 8

                Capslock {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillHeight: true
                }

                Battery {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillHeight: true
                }

                Resources {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillHeight: true
                }

                SystemTray {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillHeight: true
                }
            }
        }
    }
}
