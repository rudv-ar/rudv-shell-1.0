import Quickshell
import Quickshell.Io 
import QtQuick 
import QtQuick.Controls 


Item {
    id: openwindowsItem

    signal toggleOpenWindowsPopup()
    signal openOpenWindowsItemPopup()
    signal hideArchItemPopup()
    signal hideClockItemPopup()
    signal hideOpenWindowsItemPopup()



    width: (( parent.width - 5 ) * 1.2 ) / 8
    height: parent.height 

    Rectangle {
        id: openwindowsItemRect
        anchors.fill: parent 
        anchors.margins: 2 
        anchors.leftMargin: 0
        border.width: 1.2
        border.color: "#1c1c2a"
        color: "#0c0e16"
        radius: 15 


                    // The Open Windows text box goes here
        Text {

            id: openwindowsItemText
            color: "white"
            anchors.fill: parent 
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            font.pixelSize: 17
            font.family: "JetBrains Mono"
            font.bold: true
            text: "\uf2d2"
        }

        // Mouse Area 
        MouseArea {
            id: openwindowsMouseArea
            anchors.fill: parent 
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                toggleOpenWindowsPopup()
                hideArchItemPopup()
                hideClockItemPopup()
            }
        }
      
    }
}
