import Quickshell 
import Quickshell.Io 
import QtQuick 
import QtQuick.Controls 


Item {
    height: 200 
    width: parent.width 
    signal signalForHideArchItem()
    Rectangle {
        anchors.fill: parent 
        anchors.margins: 0
        radius: 15
        color: "transparent"
        Column { 
            anchors.fill: parent 
            spacing: 1
            Item {
                width: parent.width 
                height: parent.height / 7
                Text {
                    color: "white"
                    font.pixelSize: 12 
                    font.bold: false 
                    font.family: "JetBrains Mono"
                    text: "App Categories"
                    anchors.fill: parent
                    anchors.margins: 5
                    anchors.topMargin: 10
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            } 

            OfficeAppCategory {
                id: officeAppsCategory 
                onOpenOfficeApps: officeAppsPopup.show()
                onHideOfficeApps: officeAppsPopup.hide()
                onHideProductivityApps: productivityAppsPopup.hide()
                onHideComputerApps: computerAppsPopup.hide()
            }
            ProductivityAppCategory {
                id: productivityAppsCategory
                onOpenProductivityApps: productivityAppsPopup.show()
                onHideOfficeApps: officeAppsPopup.hide()
                onHideProductivityApps: productivityAppsPopup.hide()
                onHideComputerApps: computerAppsPopup.hide()
                
            }
            ComputerAppCategory {
                id: computerAppsCategory
                onOpenComputerApps: computerAppsPopup.show()
                onHideOfficeApps: officeAppsPopup.hide()
                onHideProductivityApps: productivityAppsPopup.hide()
                onHideComputerApps: computerAppsPopup.hide()
                
            }
            Item {
                width: parent.width 
                height: 15
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 0
                    color: "transparent"
                }
            }
            Item {
                width: parent.width 
                height: 15 
                Rectangle {
                    anchors.fill: parent 
                    anchors.margins: 1
                    property bool hovered: false
                    color: "transparent"
                    Text {
                        color: parent.hovered ? "red" : "white"
                        anchors.fill: parent 
                        horizontalAlignment: Text.AlignHCenter 
                        verticalAlignment: Text.AlignVCenter
                        text: "\uf106"
                        font.pixelSize: parent.hovered ? 16 : 15
                        font.bold: true
                    }
                    MouseArea {
                        anchors.fill: parent 
                        hoverEnabled: true 
                        onEntered: {
                            parent.hovered = true
                        }
                        onExited: {
                            parent.hovered = false 
                        }
                        onClicked: {
                            officeAppsPopup.hide()
                            productivityAppsPopup.hide()
                            computerAppsPopup.hide()
                            signalForHideArchItem()
                        }
                    }
                }
            }
            


        }
    }
    


    OfficeAppsPopup {
        id: officeAppsPopup
    }
    ProductivityAppsPopup {
        id: productivityAppsPopup
    }    
    ComputerAppsPopup {
        id: computerAppsPopup
    }    

    
}
