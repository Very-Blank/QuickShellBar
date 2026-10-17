pragma ComponentBehavior: Bound

import Quickshell
import QtQuick.Layouts
import QtQuick

import qs.styled

RowLayout {
    spacing: 4

    SButton {
        Layout.alignment: Qt.AlignVCenter
        Layout.fillHeight: true

        icon: "../icons/poweroff.svg"
        onActivated: Quickshell.execDetached(["poweroff"])
    }

    SButton {
        Layout.alignment: Qt.AlignVCenter
        Layout.fillHeight: true

        icon: "../icons/restart.svg"
        onActivated: Quickshell.execDetached(["reboot"])
    }

    SButton {
        Layout.alignment: Qt.AlignVCenter
        Layout.fillHeight: true

        icon: "../icons/hibernate.svg"
        onActivated: Quickshell.execDetached(["systemctl", "hibernate"])
    }
}
