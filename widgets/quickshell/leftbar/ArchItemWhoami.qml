import Quickshell
import Quickshell.Io 
import QtQuick 
import QtQuick.Controls

// The whoami item 
Item {

    property string whoami: "..."
                                                

    Process {
        id: whoami 
        command: ["whoami"]
        running: true 
        stdout: StdioCollector {
            onStreamFinished: {
                whoamiUserItem.whoami = text.trim()
            }
        }
    }

    Rectangle {
        color: "#0c0e16"
        radius: 15 
        anchors.fill: parent 
        anchors.margins: 5
        border.width: 1.2 
        border.color: "#373d58"

        // Text for whoamiUser 
        Text {
            anchors.fill: parent

            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

            color: "#f0ffff"
            font.bold: true 
            font.family: "DejaVu Sans Mono"
            font.pixelSize: 30 
            text: "\uf007[" + whoamiUserItem.whoami + "]"
        }
    }
}


