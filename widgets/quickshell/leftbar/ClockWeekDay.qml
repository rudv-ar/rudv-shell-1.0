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
            id: clockWeekDay
            anchors.fill: parent
            color: "#565f89"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

            font.pixelSize: 15
            font.bold: true
            font.family: "JetBrains Mono"
            text: getWeekdayName(currentDate.getDay())
        }
    }
}

