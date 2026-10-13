pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int workspace

    Socket {
        id: socket
        path: Quickshell.env("NIRI_SOCKET")
        connected: true

        onConnectedChanged: {
            if (connected) {
                write('"EventStream"\n');
                flush();
            }
        }

        parser: SplitParser {
            onRead: line => {
                try {
                    print(line);
                    const event = JSON.parse(line);
                    socket.handleNiriEvent(event);
                } catch (e) {
                    print("Failed to parse event:", line, e);
                }
            }
        }

        function handleNiriEvent(event) {
            const eventType = Object.keys(event)[0];

            switch (eventType) {
            case "WorkspaceActivated":
                root.workspace = event["WorkspaceActivated"]["id"];
                break;
            }
        }
    }
}
