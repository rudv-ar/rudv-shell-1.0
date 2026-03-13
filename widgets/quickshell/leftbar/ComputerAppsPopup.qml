import Quickshell
import Quickshell.Io 
import QtQuick
import QtQuick.Controls 

// Define a popup window for the office apps
        PopupWindow {
            id: computerAppsPopup
            anchor.window: mainLeftBar
            anchor.rect.x: 300
            anchor.rect.y: mainLeftBar.implicitHeight
            implicitHeight: computerAppsPopupRoot.height 
            implicitWidth: computerAppsPopupRoot.width 

            // Default invisible
            visible: false
            property bool opened: false 
                        
            // Add timer for popup 

            Timer {
                id: computerAppsPopupTimer
                interval: 130   // slightly more than animation duration (120)
                repeat: false
                onTriggered: computerAppsPopup.visible = false
            }

            HoverHandler {
                acceptedDevices: PointerDevice.Mouse
                onHoveredChanged: {
                    if (!hovered) {
                        computerAppsPopup.toggle()
                    }
                }
            }                        


            color: "transparent"

            // Define the arch popup root 
            Rectangle {
                id: computerAppsPopupRoot
                width: computerAppsPopup.opened ? 300 : 0
                height: computerAppsPopup.opened? 410 : 0
                anchors.margins: 5 
                color: "#0c0e16"
                radius: 15
                clip: true


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
                    computerAppsPopupTimer.stop()
                    visible = true
                    opened = true
                } else {
                    opened = false
                    computerAppsPopupTimer.restart()
                }
            }
            function show() {
                computerAppsPopupTimer.stop()
                visible = true 
                opened = true 
            }
            function hide() { 
                opened = false 
                computerAppsPopupTimer.restart()
            }
            
        }

