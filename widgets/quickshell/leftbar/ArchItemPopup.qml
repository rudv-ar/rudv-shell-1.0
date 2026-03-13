import Quickshell
import Quickshell.Io 
import QtQuick
import QtQuick.Controls 

// Define a popup window for the arch item 
        PopupWindow {
            id: archItemPopup
            anchor.window: mainLeftBar
            anchor.rect.x: 10
            anchor.rect.y: mainLeftBar.implicitHeight
            implicitHeight: archPopupRoot.height 
            implicitWidth: archPopupRoot.width 

            // Default invisible
            visible: false
            property bool opened: false 
                        
            // Add timer for popup 

            Timer {
                id: archPopupTimer
                interval: 130   // slightly more than animation duration (120)
                repeat: false
                onTriggered: archItemPopup.visible = false
            }

            HoverHandler {
                acceptedDevices: PointerDevice.Mouse
                onHoveredChanged: {
                    if (!hovered) {
                        //archItemPopup.toggle() // Enable if wanted a only one popup workflow
                    }
                }
            }                        


            color: "transparent"

            // Define the arch popup root 
            Rectangle {
                id: archPopupRoot
                width: archItemPopup.opened ? 300 : 0
                height: archItemPopup.opened? 410 : 0
                anchors.margins: 5 
                color: "#0c0e16"
                radius: 15

                            // Stack two items full height as rows 
                Row {
                    id: archPopupRootRow
                    anchors.fill: parent 
                    anchors.margins: 4 
                    spacing: 5

                    // The first item of the arch popup 
                    ArchItemSidebar { }

                    // The second item of the arch popup 
                    ArchItemMainBar {
                        onSignalForHideArchItemFromMain: archItemPopup.hide()
                    }

                }


                // Define the animation Behavior of the popup
                Behavior on width {
                    NumberAnimation {
                        duration: 120
                        easing.type: Easing.OutCubic
                    }
                }

                Behavior on height {
                    NumberAnimation {
                        duration : 120 
                        easing.type: Easing.OutCubic
                    }
                }
                            
            } 

            // Define the function for pop out 
            function toggle() {
                if (!visible) {
                    archPopupTimer.stop()
                    visible = true
                    opened = true
                } else {
                    opened = false
                    archPopupTimer.restart()
                }
            }
            function show() {
                archPopupTimer.stop()
                visible = true 
                opened = true 
            }
            function hide() { 
                opened = false 
                archPopupTimer.restart()
            }
            
        }

