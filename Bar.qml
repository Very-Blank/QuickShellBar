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

            implicitHeight: 30

            color: "transparent"

            RowLayout {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 8
                spacing: 8
            }

            RowLayout {
                anchors.centerIn: parent
                anchors.margins: 8
                spacing: 8
                Clock {}
            }

            RowLayout {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 8
                spacing: 8

                Resources {}
                SystemTray {}
            }
        }
    }
}
