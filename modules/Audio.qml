import Quickshell.Services.Pipewire
import QtQuick.Layouts
import Quickshell
import QtQuick

import qs.styled
import qs

Rectangle {
    implicitHeight: layout.implicitHeight
    implicitWidth: layout.implicitWidth + Config.styling.width
    radius: Config.styling.radius

    color: Config.palette.surface

    RowLayout {
        id: layout
        anchors.centerIn: parent

        RowLayout {
            SImage {
                Layout.alignment: Qt.AlignVCenter
                source: Pipewire.defaultAudioSink.audio.muted ? Quickshell.iconPath("audio-volume-muted-blocking-symbolic") : Quickshell.iconPath("audio-symbolic")
                sourceSize: Qt.size(11, 11)
            }

            SText {
                Layout.alignment: Qt.AlignVCenter
                text: Math.round(100 * Pipewire.defaultAudioSink.audio.volume) + "%"
                visible: !Pipewire.defaultAudioSink.audio.muted
            }
        }

        RowLayout {
            SImage {
                Layout.alignment: Qt.AlignVCenter
                source: Pipewire.defaultAudioSource.audio.muted ? Quickshell.iconPath("audio-input-microphone-muted-symbolic") : Quickshell.iconPath("audio-input-microphone-symbolic")
                sourceSize: Qt.size(8, 8)
            }

            SText {
                Layout.alignment: Qt.AlignVCenter
                text: Math.round(100 * Pipewire.defaultAudioSource.audio.volume) + "%"
                visible: !Pipewire.defaultAudioSink.audio.muted
            }
        }
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }
}
