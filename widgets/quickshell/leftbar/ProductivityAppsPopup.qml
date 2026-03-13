import Quickshell
import Quickshell.Io 
import QtQuick
import QtQuick.Controls 

// Define a popup window for the office apps
        PopupWindow {
            id: productivityAppsPopup
            anchor.window: mainLeftBar
            anchor.rect.x: 300
            anchor.rect.y: mainLeftBar.implicitHeight
            implicitHeight: productivityAppsPopupRoot.height 
            implicitWidth: productivityAppsPopupRoot.width 

            // Default invisible
            visible: false
            property bool opened: false 
                        
            // Add timer for popup 

            Timer {
                id: productivityAppsPopupTimer
                interval: 130   // slightly more than animation duration (120)
                repeat: false
                onTriggered: productivityAppsPopup.visible = false
            }

            HoverHandler {
                acceptedDevices: PointerDevice.Mouse
                onHoveredChanged: {
                    if (!hovered) {
                        productivityAppsPopup.toggle()
                    }
                }
            }                        


            color: "transparent"

            // Define the arch popup root 
            Rectangle {
                id: productivityAppsPopupRoot
                width: productivityAppsPopup.opened ? 300 : 0
                height: productivityAppsPopup.opened? 410 : 0
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
                    productivityAppsPopupTimer.stop()
                    visible = true
                    opened = true
                } else {
                    opened = false
                    productivityAppsPopupTimer.restart()
                }
            }    
            function show() {
                productivityAppsPopupTimer.stop()
                visible = true 
                opened = true 
            }
            function hide() { 
                opened = false 
                productivityAppsPopupTimer.restart()
            }
            
        }

