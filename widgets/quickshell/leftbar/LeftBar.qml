// Import the necessary stuffs for gui creation

import Quickshell
import Quickshell.Io 
import QtQuick
import QtQuick.Controls 

Scope {

// Define the main panel window
PanelWindow {
    // Define the root window's id
    id: mainLeftBar
    // Dimensions of the box 
    implicitWidth: 400 
    implicitHeight: 45

    // Anchoring the window
    anchors.right: false 
    anchors.bottom: false
    anchors.left: true 
    anchors.top: true

    // Define the color
    color: "transparent"

    // Define the inner root rectangle which gives shape to the bar 
    Rectangle {

        id: root

        // Visible properties
        color: "transparent"
        radius: 15 

        // Anchors: fill the parent 
        anchors.fill: parent 
        anchors.margins: 5
        anchors.leftMargin: 10
        // Remove the top margins cause bspwm already sets it 
        // anchors.topMargin: 0
        
        // Set Dimensions to parent
        width: parent.width 
        height: parent.height 

        // Define the row 
        Row {

            id: rootRow 

            // Fill the parent 
            anchors.fill: parent 
            spacing: 5 

            // The first item of the Row : ArchItem 
            ArchItem {
                id: archItem
                onToggleArchItemPopup: archItemPopup.toggle()
                onHideArchItemPopup: archItemPopup.hide()
                onOpenArchItemPopup: archItemPopup.show()
                onHideClockItemPopup: clockItemPopup.hide()
                onHideOpenWindowsItemPopup: openwindowsPopup.hide()
            }
            // The Second Item of the Row : Reserve for time 
            ClockItem {
                id: clockItem 
                onToggleClockItemPopup: clockItemPopup.toggle()
                onHideArchItemPopup: archItemPopup.hide()
                onOpenClockItemPopup: clockItemPopup.show()
                onHideClockItemPopup: clockItemPopup.hide()
                onHideOpenWindowsItemPopup: openwindowsPopup.hide()

            }
            // Third Item for the bar : open-windows
            OpenWindowsItem {
                id: openwindowItem
                onToggleOpenWindowsPopup: openwindowsPopup.toggle()
                onHideArchItemPopup: archItemPopup.hide()
                onHideClockItemPopup: clockItemPopup.hide()
                
            }
        }
    }
}

ArchItemPopup {
    id: archItemPopup 
}
OpenWindowsPopup{
    id: openwindowsPopup
}
ClockItemPopup{
    id: clockItemPopup
}



}
