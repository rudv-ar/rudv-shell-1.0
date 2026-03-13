// ArchItem.qml : type ArchItem
import QtQuick 
import Quickshell 
import Quickshell.Io
import QtQuick.Controls

// The first item of row : Arch Menu
Item {
    id: archItem
    width: ( parent.width - 5 ) / 8 
    height: parent.height 

    signal toggleArchItemPopup()
    signal openArchItemPopup()
    signal hideArchItemPopup()
    signal hideClockItemPopup()
    signal hideOpenWindowsItemPopup()

    Rectangle {
        id: archItemRect
        color: "#0c0e16"
        radius: 15 
        border.width: 1.2 
        border.color: "#1c1c2a"
        anchors.fill: parent 
        anchors.margins: 2
        anchors.rightMargin: 0

        property bool hovered: false

        // Add the text with some functionality 
        Text {

            id: archItemText
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

            font.pixelSize: 18
            font.bold: true
            color: parent.hovered ? "#936eb7" : "#4aa6d3"
            text: "\uf303" + " "
        } 
                    // Mouse area for popup 
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true 
            onEntered: {
                parent.hovered = true
                //openArchItemPopup()
                //hideclockitempopup()
                //hideopenwindowsitempopup()
            }
            onExited: {
                parent.hovered = false
            }
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                toggleArchItemPopup()
                hideClockItemPopup()
                hideOpenWindowsItemPopup()
                
            }
        }
    }
}
