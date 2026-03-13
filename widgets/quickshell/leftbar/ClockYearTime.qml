import Quickshell 
import Quickshell.Io 
import QtQuick 
import QtQuick.Controls 

Item {

    // The rectangle
    Rectangle {
        color: "transparent"
        anchors.fill: parent
        radius: 15

        Text {
            id: clockYearTime
            anchors.fill: parent
            color: "#9aa5ce"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

            font.pixelSize: 15
            font.bold: true
            font.family: "JetBrains Mono"
            text: currentDate.getFullYear() + " | " + pad(currentDate.getHours()) + ":" + pad(currentDate.getMinutes()) + ":" + pad(currentDate.getSeconds())
        }
    }
}

