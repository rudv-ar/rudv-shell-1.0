import Quickshell
import Quickshell.Io 
import QtQuick 
import QtQuick.Controls 

// Define the items 
// The Dayitem 
Item {

    // The rectangle
    Rectangle {
        color: "transparent"
        anchors.fill: parent
        radius: 15

        Text {
            id: clockDay 
            anchors.fill: parent
            color: "#7aa2f7"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

            font.pixelSize: 25
            font.bold: true
            font.family: "JetBrains Mono"
            text: currentDate.getDate() + " " + getMonthName(currentDate.getMonth())
        }
    }
}

