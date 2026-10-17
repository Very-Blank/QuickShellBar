pragma ComponentBehavior: Bound

import Quickshell.Services.Pipewire
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick

import qs.styled
import qs

Rectangle {
    implicitHeight: layout.implicitHeight
    implicitWidth: layout.implicitWidth + Config.modules.extraWidth
    radius: Config.modules.radius

    color: Config.palette.surface

    RowLayout {
        id: layout
        anchors.centerIn: parent

        RowLayout {
            id: sink

            readonly property int volume: Pipewire.defaultAudioSink !== null ? Math.round(100 * Pipewire.defaultAudioSink.audio.volume) : 0
            readonly property bool muted: Pipewire.defaultAudioSink !== null ? Pipewire.defaultAudioSink.audio.muted : true

            SImage {
                Layout.alignment: Qt.AlignVCenter
                source: sink.muted ? Qt.resolvedUrl("../icons/volumeOff.svg") : sink.volume <= 10 ? Qt.resolvedUrl("../icons/volumeMute.svg") : sink.volume <= 50 ? Qt.resolvedUrl("../icons/volumeDown.svg") : Qt.resolvedUrl("../icons/volumeUp.svg")

                layer {
                    enabled: sink.muted
                    effect: MultiEffect {
                        colorization: 1.0
                        colorizationColor: Config.palette.error
                    }
                }
            }

            SText {
                Layout.alignment: Qt.AlignVCenter
                text: sink.volume + "%"
            }
        }

        RowLayout {
            id: source

            readonly property int volume: Pipewire.defaultAudioSource !== null ? Math.round(100 * Pipewire.defaultAudioSource.audio.volume) : 0
            readonly property bool muted: Pipewire.defaultAudioSource !== null ? Pipewire.defaultAudioSource.audio.muted : true

            SImage {
                Layout.alignment: Qt.AlignVCenter
                source: source.muted ? Qt.resolvedUrl("../icons/micOff.svg") : Qt.resolvedUrl("../icons/micOn.svg")

                layer {
                    enabled: source.muted
                    effect: MultiEffect {
                        colorization: 1.0
                        colorizationColor: Config.palette.error
                    }
                }
            }

            SText {
                Layout.alignment: Qt.AlignVCenter
                text: source.volume + "%"
            }
        }
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }
}
