pragma ComponentBehavior: Bound

import Quickshell
import QtQuick.Layouts
import QtQuick

import qs.modules

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

            implicitHeight: Math.max(layoutLeft.implicitHeight, layoutMiddle.implicitHeight, layoutRight.implicitHeight) + Config.bar.extraHeight

            color: Config.palette.background

            RowLayout {
                id: layoutLeft
                spacing: Config.bar.spacing

                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                    margins: Config.bar.margins
                }
                
                Component {
                    id: niriWorkspaces

                    NiriWorkspaces {
                        Layout.alignment: Qt.AlignVCenter
                        Layout.fillHeight: true
                        window: panel.modelData.name
                    }
                }

                Loader {
                    active: Config.features.niriWorkspaces
                    sourceComponent: niriWorkspaces 
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
                spacing: Config.bar.spacing

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    bottom: parent.bottom
                    margins: Config.bar.margins
                }

                Clock {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillHeight: true
                }
            }

            RowLayout {
                id: layoutRight
                spacing: Config.bar.spacing

                anchors {
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                    margins: Config.bar.margins
                }

                Component {
                    id: audio
                    Audio {
                        Layout.alignment: Qt.AlignVCenter
                        Layout.fillHeight: true
                    }
                }

                Loader {
                    active: Config.features.audio
                    sourceComponent: audio 
                }

                Component {
                    id: brightness
                    Brightness {
                        Layout.alignment: Qt.AlignVCenter
                        Layout.fillHeight: true
                    }
                }

                Loader {
                    active: Config.features.brightness
                    sourceComponent: brightness 
                }

                Resources {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillHeight: true
                }

                Component {
                    id: battery
                    Battery {
                        Layout.alignment: Qt.AlignVCenter
                        Layout.fillHeight: true
                    }
                }

                Loader {
                    active: Config.features.battery
                    sourceComponent: battery
                }

                SystemTray {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillHeight: true
                }
            }
        }
    }
}
