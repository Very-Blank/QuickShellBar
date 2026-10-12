import Quickshell.Services.UPower
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick

Rectangle {
    id: root
    implicitHeight: layout.implicitHeight
    implicitWidth: layout.implicitWidth + Config.styling.width
    radius: Config.styling.radius

    color: Config.palette.surface

    property real level: UPower.displayDevice.percentage

    RowLayout {
        id: layout
        anchors.centerIn: parent
        spacing: 8

        Slider {
            id: slider
            Layout.alignment: Qt.AlignVCenter
            implicitHeight: 10
            implicitWidth: 40
            enabled: false
            value: 0.5

            handle: null

            background: Rectangle {
                x: slider.leftPadding
                y: slider.topPadding + slider.availableHeight / 2 - height / 2
                implicitWidth: 200
                implicitHeight: 8
                width: slider.availableWidth
                height: implicitHeight
                radius: 2
                color: Config.palette.surfaceHigh

                Rectangle {
                    width: slider.visualPosition * parent.width
                    height: parent.height
                    color: Config.palette.success
                    radius: 2
                }
            }
        }

        Text {
            Layout.alignment: Qt.AlignVCenter

            text: (level) * 100 + "%"

            color: Config.palette.foreground

            font {
                family: Config.fonts.mono
                pixelSize: Config.fonts.normal
                bold: true
            }
        }
    }
}
