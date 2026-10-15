import Quickshell
import QtQuick.Layouts
import QtQuick

import qs.modules
import qs.styled

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
                spacing: 8

                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                    margins: 4
                }

                NiriWorkspaces {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillHeight: true
                    window: panel.modelData.name
                }

                Power {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillHeight: true
                }

                Capslock {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillHeight: true
                }
            }

            RowLayout {
                id: layoutMiddle
                spacing: 8

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    bottom: parent.bottom
                    margins: 4
                }

                Clock {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillHeight: true
                }
            }

            RowLayout {
                id: layoutRight
                spacing: 8

                anchors {
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                    margins: 4
                }

                Resources {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillHeight: true
                }

                Audio {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillHeight: true
                }

                Battery {
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
