import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io

Item {
    id: root
    width: parent.width
    height: parent.height / 7

    /* ===== API ===== */
    property string tooltip
    property string icon
    property var command   // array
    signal launched()

    Process {
        id: proc
        command: root.command
    }

    Rectangle {
        id: bg
        anchors.fill: parent
        anchors.margins: 2
        radius: 10
        color: mouse.containsMouse ? "#0c0e16" : "black"

        ToolTip {
            visible: mouse.containsMouse
            text: root.tooltip

            background: Rectangle {
                color: "#1e1e2e"
                radius: 8
                border.width: 1
                border.color: "white"
            }

            contentItem: Text {
                text: root.tooltip
                color: "white"
                font.pixelSize: 12
            }
        }

        Text {
            anchors.centerIn: parent
            text: root.icon
            color: "white"
            font.pixelSize: 15
        }

        MouseArea {
            id: mouse
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                proc.running = true
                root.launched()
            }
        }
    }
}
