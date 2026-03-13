import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io

Item {
    id: archGithubApp
    width: parent.width / 5
    height: parent.height

    /* ===== API ===== */
    property string tooltip
    property string icon
    property var command   // array
    signal gitapplaunched()

    Process {
        id: proc
        command: archGithubApp.command
    }

    Rectangle {
        id: bg
        anchors.fill: parent
        anchors.margins: 2
        radius: 20
        color: mouse.containsMouse ? "#0c0e16" : "transparent"

        ToolTip {
            visible: mouse.containsMouse
            text: archGithubApp.tooltip

            background: Rectangle {
                color: "#1e1e2e"
                radius: 8
                border.width: 1
                border.color: "white"
            }

            contentItem: Text {
                text: archGithubApp.tooltip
                color: "white"
                font.pixelSize: 12
            }
        }

        Text {
            anchors.centerIn: parent
            text: archGithubApp.icon
            color: mouse.containsMouse ? "#c35d60" : "#3e8cb3"
            font.pixelSize: 15
        }

        MouseArea {
            id: mouse
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                proc.running = true
                archGithubApp.gitapplaunched()
            }
        }
    }
}
