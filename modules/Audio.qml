import Quickshell.Services.Pipewire
import QtQuick.Layouts
import QtQuick.Effects
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
                source: Pipewire.defaultAudioSink.audio.muted ? Qt.resolvedUrl("../icons/volumeOff.svg") : Qt.resolvedUrl("../icons/volumeUp.svg")

                layer {
                    enabled: Pipewire.defaultAudioSink.audio.muted
                    effect: MultiEffect {
                        colorization: 1.0
                        colorizationColor: Config.palette.error
                    }
                }
            }

            SText {
                Layout.alignment: Qt.AlignVCenter
                text: Math.round(100 * Pipewire.defaultAudioSink.audio.volume) + "%"
            }
        }

        RowLayout {
            SImage {
                Layout.alignment: Qt.AlignVCenter
                source: Pipewire.defaultAudioSource.audio.muted ? Qt.resolvedUrl("../icons/micOff.svg") : Qt.resolvedUrl("../icons/micOn.svg")

                layer {
                    enabled: Pipewire.defaultAudioSource.audio.muted
                    effect: MultiEffect {
                        colorization: 1.0
                        colorizationColor: Config.palette.error
                    }
                }
            }

            SText {
                Layout.alignment: Qt.AlignVCenter
                text: Math.round(100 * Pipewire.defaultAudioSource.audio.volume) + "%"
            }
        }
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }
}
