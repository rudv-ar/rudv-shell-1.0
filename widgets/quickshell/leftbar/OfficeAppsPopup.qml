import Quickshell
import Quickshell.Io 
import QtQuick
import QtQuick.Controls 

// Define a popup window for the office apps
        PopupWindow {
            id: officeAppsPopup
            anchor.window: mainLeftBar
            anchor.rect.x: 300
            anchor.rect.y: mainLeftBar.implicitHeight
            implicitHeight: officeAppsPopupRoot.height 
            implicitWidth: officeAppsPopupRoot.width 

            // Default invisible
            visible: false
            property bool opened: false 
                        
            // Add timer for popup 

            Timer {
                id: officeAppsPopupTimer
                interval: 130   // slightly more than animation duration (120)
                repeat: false
                onTriggered: officeAppsPopup.visible = false
            }

            HoverHandler {
                acceptedDevices: PointerDevice.Mouse
                onHoveredChanged: {
                    if (!hovered) {
                        officeAppsPopup.toggle()
                    }
                }
            }                        


            color: "transparent"

            // Define the arch popup root 
            Rectangle {
                id: officeAppsPopupRoot
                width: officeAppsPopup.opened ? 300 : 0
                height: officeAppsPopup.opened? 410 : 0
                anchors.margins: 5 
                color: "#0c0e16"
                radius: 15
                clip: true


                // Define the animation Behavior of the popup
                Behavior on width {
                    NumberAnimation {
                        duration: 120
                        easing.type: Easing.OutQuart
                    }
                }

                Behavior on height {
                    NumberAnimation {
                        duration : 120 
                        easing.type: Easing.OutQuart
                    }
                }
                            
            } 

            // Define the function for pop out 
            function toggle() {
                if (!visible) {
                    officeAppsPopupTimer.stop()
                    visible = true
                    opened = true
                } else {
                    opened = false
                    officeAppsPopupTimer.restart()
                }
            }
            function show() {
                officeAppsPopupTimer.stop()
                visible = true 
                opened = true 
            }
            function hide() { 
                opened = false 
                officeAppsPopupTimer.restart()
            }
        }

