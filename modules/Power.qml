import Quickshell
import QtQuick.Layouts
import QtQuick

import qs.styled

RowLayout {
    spacing: 4

    SButton {
        Layout.alignment: Qt.AlignVCenter
        Layout.fillHeight: true

        icon: "system-shutdown-symbolic"
        onActivated: Quickshell.execDetached(["poweroff"])
    }

    SButton {
        Layout.alignment: Qt.AlignVCenter
        Layout.fillHeight: true

        icon: "system-restart-symbolic"
        onActivated: Quickshell.execDetached(["reboot"])
    }

    SButton {
        Layout.alignment: Qt.AlignVCenter
        Layout.fillHeight: true

        icon: "system-hibernate-symbolic"
        onActivated: Quickshell.execDetached(["systemctl", "hibernate"])
    }
}
