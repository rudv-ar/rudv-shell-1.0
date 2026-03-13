import Quickshell
import Quickshell.Io 
import QtQuick
import QtQuick.Controls 

 Item {
    width: parent.width 
    height: parent.height / 5 

    signal openProductivityApps()
    signal hideProductivityApps()
    signal hideComputerApps()
    signal hideOfficeApps()


    Rectangle {
        property bool hovered: false 

        id: productivityApps
        color: hovered ? "#2e3036" : "#090c12"
        anchors.fill: parent 
        anchors.margins: 5 
        radius: 10

        
        Text {
            color: parent.hovered ? "white" : "#926eb7"
            font.pixelSize: 12 
            font.bold: false 
            font.family: "JetBrains Mono"
            text: parent.hovered ? "Productivity \u00bb " : "Productivity"
            anchors.fill: parent 
            verticalAlignment: Text.AlignVCenter 
            horizontalAlignment: Text.AlignHCenter

        }
        MouseArea {
            anchors.fill: parent 
            hoverEnabled: true 
            onEntered: {
                parent.hovered = true
                openProductivityApps()
                hideComputerApps()
                hideOfficeApps()

            }
            onExited: {
                parent.hovered = false 
            }
            cursorShape: Qt.PointingHandCursor
            onClicked: hideProductivityApps()
        }
    }
}

