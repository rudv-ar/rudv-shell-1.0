import QtQuick 
import QtQuick.Controls
import Quickshell
import Quickshell.Io 

// The second item, control panel sort quick access settings 
Item {
    id: archPopupMain 
    width: (parent.width * 3) / 4 
    height: parent.height 
    signal signalForHideArchItemFromMain()
    Rectangle {
        anchors.fill: parent 
        anchors.margins: 10 
        radius: 15 
        color: "#090a10"
        anchors.leftMargin: 0 

        // Define the column 
        Column {
            id: archPopupMainColumn 
            anchors.fill: parent 
            spacing: 1 
            anchors.margins: 1 

            // Define the column Items

            // 1) Define the whoami Item
            ArchItemWhoami {
                id: whoamiUserItem 
                width: parent.width 
                height: (parent.height - 10 ) / 5
            }

            // 2) Define the Github Panel 
            ArchGithubPanel {
                id: archGithubPanel 
                height: 100 
                width: parent.width 
            }

            HorizontalRuler {
                id: hr2 
                width: parent.width
                height: 10
                radius: 0
                color: "#0c0e16"

            }
            ArchAppCategories {
                id: archApps 
                onSignalForHideArchItem: signalForHideArchItemFromMain()
            }
        }
    }
}
