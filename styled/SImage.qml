import QtQuick.Effects
import QtQuick

Image {
    sourceSize: Qt.size(16, 16)

    layer {
        enabled: true
        effect: MultiEffect {
            brightness: 1.0
        }
    }
}
