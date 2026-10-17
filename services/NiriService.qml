pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property var windows: ({})

    function switchToWorkspace(id) {
        if (actionSocket.connected) {
            actionSocket.write(JSON.stringify({
                "Action": {
                    "FocusWorkspace": {
                        "reference": {
                            "Id": id
                        }
                    }
                }
            }) + "\n");

            actionSocket.flush();

            return true;
        }

        return false;
    }

    Socket {
        id: actionSocket
        path: Quickshell.env("NIRI_SOCKET")
        connected: true
    }

    Socket {
        id: eventSocket
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
                    const event = JSON.parse(line);
                    eventSocket.handleNiriEvent(event);
                } catch (e) {
                    print("Failed to parse event:", line, e);
                }
            }
        }

        function handleNiriEvent(event) {
            const eventType = Object.keys(event)[0];

            switch (eventType) {
            case "WorkspaceActivated":
                {
                    const id = event["WorkspaceActivated"]["id"];
                    const windows = root.windows;

                    outer: for (const output in windows) {
                        for (const workspace of windows[output].workspaces) {
                            if (workspace.id === id) {
                                windows[output].active = workspace.index;
                                break outer;
                            }
                        }
                    }

                    root.windows = Object.assign({}, windows);
                    break;
                }
            case "WorkspacesChanged":
                {
                    const windows = {};

                    for (const workspace of event["WorkspacesChanged"]["workspaces"]) {
                        if (windows[workspace.output] === undefined) {
                            windows[workspace.output] = {
                                workspaces: [
                                    {
                                        id: workspace.id,
                                        index: workspace.idx
                                    }
                                ],
                                active: workspace.is_active ? workspace.idx : 0
                            };

                            continue;
                        }

                        windows[workspace.output].workspaces.push({
                            id: workspace.id,
                            index: workspace.idx
                        });

                        if (workspace.is_active) {
                            windows[workspace.output].active = workspace.idx;
                        }
                    }

                    for (const output in windows) {
                        windows[output].workspaces.sort((a, b) => a.index - b.index);
                    }

                    root.windows = windows;
                    break;
                }
            }
        }
    }
}
