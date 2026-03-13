import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: wifiPanel
    width: content.implicitWidth + 20
    height: parent.height

    property bool wifiEnabled: false
    property string ssid: ""

    property bool expanded: mouse.containsMouse

    // ---------- Update ----------
    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: {
            if (!wifiProcess.running)
                wifiProcess.running = true
        }
    }

    Component.onCompleted: wifiProcess.running = true

    // ---------- UI ----------
    Rectangle {
        id: bg
        anchors.fill: parent
        radius: 15
        color: "#0b0d15"
        border.width: 1.2 
        border.color: "#1c1c2a"
        anchors.margins: 3


        Row {
            id: content
            spacing: 6
            // anchors.fill: parent
            anchors.centerIn: parent

            // WiFi icon
            Text {

                text: wifiPanel.wifiEnabled ? "\uf1eb" : "\uf1eb"
                font.family: "JetBrainsMono Nerd Font"
                font.weight: Font.Bold
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 15
                color: wifiPanel.wifiEnabled ? "#ffffff" : "#666666"
            }

            // Status text
            Text {
                text: wifiPanel.expanded
                      ? (wifiPanel.wifiEnabled
                         ? wifiPanel.ssid
                         : "Disabled")
                      : (wifiPanel.wifiEnabled ? "On" : "Off")

                font.pixelSize: 15 
                font.family: "JetBrainsMono Nerd Font"
                font.bold: true
                color: wifiPanel.wifiEnabled ? "#8ec07c" : "#888888"
                elide: Text.ElideRight
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        MouseArea {
            id: mouse
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true

            onClicked: {
                if (wifiPanel.wifiEnabled && wifiPanel.ssid !== "") {
                    openVicinaeWifi.running = true
                }
            }
        }
    }

    // ---------- WiFi Status ----------
    Process {
        id: wifiProcess
        command: [
            "bash", "-c",
            "printf '%s|%s' \"$(nmcli radio wifi)\" \"$(nmcli -t -f ACTIVE,SSID dev wifi | grep ^yes: | cut -d: -f2)\""
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                let parts = text.trim().split("|")

                wifiPanel.wifiEnabled = parts[0] === "enabled"
                wifiPanel.ssid = parts.length > 1 ? parts[1] : ""
            }
        }
    }
    Process {
        id: openVicinaeWifi
        command: ["vicinae", "deeplink", "vicinae://extensions/dagimg-dot/wifi-commander/scan-wifi"]
        running: false 

    }
    Behavior on width {
        NumberAnimation { duration: 160; easing.type: Easing.InOutQuad }
    }
    
}
