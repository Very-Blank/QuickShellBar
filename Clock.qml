import Quickshell
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick

Rectangle {
    implicitHeight: layout.implicitHeight
    implicitWidth: layout.implicitWidth + Config.styling.width
    radius: Config.styling.radius

    color: Config.palette.surface

    RowLayout {
        id: layout
        anchors.centerIn: parent

        RowLayout {
            Image {
                Layout.alignment: Qt.AlignVCenter
                source: Qt.resolvedUrl("icons/calendar.svg")
                sourceSize: Qt.size(16, 16)

                layer {
                    enabled: true
                    effect: MultiEffect {
                        brightness: 1.0
                    }
                }
            }

            Text {
                Layout.alignment: Qt.AlignVCenter

                text: Qt.formatDateTime(clock.date, "ddd MMM d")

                color: Config.palette.foreground

                font {
                    family: Config.fonts.mono
                    pixelSize: Config.fonts.normal
                    bold: true
                }
            }
        }

        RowLayout {
            Image {
                Layout.alignment: Qt.AlignVCenter
                source: Qt.resolvedUrl("icons/clock.svg")
                sourceSize: Qt.size(16, 16)

                layer {
                    enabled: true
                    effect: MultiEffect {
                        brightness: 1.0
                    }
                }
            }

            Text {
                Layout.alignment: Qt.AlignVCenter

                text: Qt.formatDateTime(clock.date, "hh:mm")

                color: Config.palette.foreground

                font {
                    family: Config.fonts.mono
                    pixelSize: Config.fonts.normal
                    bold: true
                }
            }
        }
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
