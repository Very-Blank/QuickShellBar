import Quickshell.Services.UPower
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick

import qs.styled
import qs

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
            value: root.level

            handle: null

            background: Rectangle {
                anchors.centerIn: parent
                implicitWidth: 200
                implicitHeight: 8
                width: slider.availableWidth
                height: implicitHeight
                radius: 2
                color: Config.palette.surfaceHigh

                Rectangle {
                    width: slider.visualPosition * parent.width
                    height: parent.height
                    color: root.level <= 0.15 ? Config.palette.error : root.level <= 0.30 ? Config.palette.warning : Config.palette.foreground
                    radius: 2
                }
            }
        }

        SText {
            Layout.alignment: Qt.AlignVCenter
            text: Math.round(root.level * 100) + "%"
        }

        SImage {
            Layout.alignment: Qt.AlignVCenter
            source: Qt.resolvedUrl("../icons/charging.svg")

            visible: UPower.displayDevice.state === UPowerDeviceState.Charging
        }
    }
}
