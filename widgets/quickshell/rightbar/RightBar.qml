import Quickshell
import QtQuick
import Quickshell.Io

PanelWindow {
    anchors.bottom: false
    anchors.left: false
    anchors.right: true
    anchors.top: true

    implicitHeight: 45
    implicitWidth: 250
    color: "transparent"
    Rectangle {
        id: root
        color: "transparent"
        anchors.fill: parent
        radius: 15
        anchors.margins: 5
        anchors.rightMargin: 10

        Row {
            id: rootRow
            anchors.fill: parent
            spacing: 5

            WifiStat { }            
            Xtitle { }
    
        }
    }
}
