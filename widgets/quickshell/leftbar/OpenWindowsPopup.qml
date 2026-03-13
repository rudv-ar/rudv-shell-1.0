import Quickshell
import Quickshell.Io 
import QtQuick 
import QtQuick.Controls 

                    // Define a popup window for the openwindows
                    PopupWindow {
                        id: openwindowsPopup
                        anchor.window: mainLeftBar
                        anchor.rect.x: 70
                        anchor.rect.y: mainLeftBar.implicitHeight
                        implicitHeight: openwindowsPopupRoot.height 
                        implicitWidth: openwindowsPopupRoot.width 

                        // Default invisible
                        visible: false
                        property bool opened: false 
                        
                        // Add timer for popup 

                        Timer {
                            id: openwindowsPopupTimer
                            interval: 130   // slightly more than animation duration (120)
                            repeat: false
                            onTriggered: openwindowsPopup.visible = false
                        }

                        HoverHandler {
                            acceptedDevices: PointerDevice.Mouse
                            onHoveredChanged: {
                                if (!hovered) {
                                    openwindowsPopup.toggle()
                                }
                            }
                        }                        


                        color: "transparent"

                        // Define the openwindows popup root 
                        Rectangle {
                            id: openwindowsPopupRoot
                            width: openwindowsPopup.opened ? 300 : 0
                            height: openwindowsPopup.opened? 400 : 0
                            anchors.margins: 5 
                            color: "#0c0e16"
                            radius: 15


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
                                openwindowsPopupTimer.stop()
                                visible = true
                                opened = true
                            } else {
                                opened = false
                                openwindowsPopupTimer.restart()
                            }
                        }
                        function show() {
                            openwindowsPopupTimer.stop()
                            visible = true 
                            opened = true 
                        }
                        function hide() { 
                            opened = false 
                            openwindowsPopupTimer.restart()
                        }
                        
                    }

