import Quickshell
import Quickshell.Io
import QtQuick 2.15
import QtQuick.Controls 2.15

PanelWindow {
    id: win

    // --- pill / expanded sizes ---
    property bool expanded: false
    property int collapsedWidth: 150
    property int collapsedHeight: 44
    property int expandedWidth: 500
    property int expandedHeight: 500

    implicitWidth: expanded ? expandedWidth : collapsedWidth
    implicitHeight: expanded ? expandedHeight : collapsedHeight

    color: "transparent"

    anchors.top: false
    anchors.left: true
    anchors.right: false
    anchors.bottom: true

    // ================= SYSTEM DATA =================
    property string hostName: "..."
    property string uptimeText: "..."
    property string cpuUsage: "..."
    property string memUsage: "..."
    property string diskHomeUsage: "..."
    property string diskRootUsage: "..."
    property string diskDiskAUsage: "..."
    property string updatesCount: "0"
    property bool updatesRunning: false

    // Timer will trigger processes periodically (every 1s)
    Timer {
        id: pollTimer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            hostProc.running = true
            uptimeProc.running = true
            cpuProc.running = true
            memProc.running = true
            dfHomeProc.running = true
            dfRootProc.running = true
            dfDiskAProc.running = true
            updatesProc.running = true
            updatesRunning = true
        }
    }

    // HOST & STATS PROCESSES
    Process {
        id: updatesProc
        running: false
        command: ["sh", "-c",
            "updates=0; \
             if command -v checkupdates >/dev/null; then \
                 updates=$(checkupdates 2>/dev/null | wc -l); \
             fi; \
             aur=0; \
             if command -v paru >/dev/null; then \
                 aur=$(paru -Qua 2>/dev/null | wc -l); \
             fi; \
             echo $((updates + aur))"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                updatesCount = this.text.trim()
                updatesRunning = true
            }
        }
    }
    Process {
        id: hostProc
        running: false
        command: ["hostname"]
        stdout: StdioCollector {
            onStreamFinished: { hostName = this.text.trim() }
        }
    }

    Process {
        id: uptimeProc
        running: false
        command: ["uptime", "-p"]
        stdout: StdioCollector {
            onStreamFinished: {
                var t = this.text.trim()
                if (t.indexOf("up ") === 0) t = t.substring(3)

                // keep original uptimeText (human) but also it's fine to keep hours/minutes elsewhere
                uptimeText = t
            }
        }
    }

    Process {
        id: cpuProc
        running: false
        command: ["sh", "-c",
                  "awk '/^cpu /{idle=$5; total=$2+$3+$4+$5+$6+$7+$8; usage=(total-idle)/total*100; printf \"%.1f%%\", usage}' /proc/stat"]
        stdout: StdioCollector {
            onStreamFinished: { cpuUsage = this.text.trim() }
        }
    }

    Process {
        id: memProc
        running: false
        command: ["sh", "-c", "free -h | awk '/^Mem:/ {print $3 \" / \" $2}'"]
        stdout: StdioCollector {
            onStreamFinished: { memUsage = this.text.trim() }
        }
    }

    // Disk usage for three mount points (NR==2 picks the actual mount's line)
    Process {
        id: dfHomeProc
        running: false
        command: ["sh", "-c", "df -h /home/rudv-ar 2>/dev/null | awk 'NR==2 {print $3 \" / \" $2}'"]
        stdout: StdioCollector {
            onStreamFinished: {
                var v = this.text.trim()
                diskHomeUsage = v === "" ? "N/A" : v
            }
        }
    }

    Process {
        id: dfRootProc
        running: false
        command: ["sh", "-c", "df -h / 2>/dev/null | awk 'NR==2 {print $3 \" / \" $2}'"]
        stdout: StdioCollector {
            onStreamFinished: {
                var v = this.text.trim()
                diskRootUsage = v === "" ? "N/A" : v
            }
        }
    }

    Process {
        id: dfDiskAProc
        running: false
        command: ["sh", "-c", "df -h /sdisks/disk-a 2>/dev/null | awk 'NR==2 {print $3 \" / \" $2}'"]
        stdout: StdioCollector {
            onStreamFinished: {
                var v = this.text.trim()
                diskDiskAUsage = v === "" ? "N/A" : v
            }
        }
    }

    Rectangle {
        id: root
        anchors.fill: parent
        radius: expanded ? 15 : 22
        color: "#0c0e16"
        anchors.leftMargin: 10
        anchors.bottomMargin: 10

        Column {
            id: outerColumn
            anchors.fill: parent
            spacing: 6

            // ================= HEADER / PILL =================
            Rectangle {
                id: header
                height: expanded ? 40 : parent.height
                width: parent.width
                radius: expanded ? 8 : 22
                color: "#0c0e16"

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: win.expanded = !win.expanded
                }

                Row {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10

                    Rectangle {
                        width: 16
                        height: 16
                        radius: 8
                        color: "#c0caf5"
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Text {
                        text: "dashboard"
                        anchors.leftMargin: 20
                        font.pixelSize: 14
                        font.bold: true
                        color: "#c0caf5"
                        verticalAlignment: Text.AlignVCenter
                        anchors.verticalCenter: parent.verticalCenter
                        opacity: win.expanded ? 1 : 0.85
                    }

                    Item { width: 1; height: 1 }

                    Rectangle {
                        visible: win.expanded
                        width: 17
                        height: 17
                        radius: 12
                        color: "white"
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter

                        MouseArea {
                            anchors.fill: parent
                            onClicked: Qt.quit()
                            hoverEnabled: true
                            onEntered: parent.color = "#da686f"
                            onExited: parent.color = "white"
                        }

                        Text {
                            text: "×"
                            anchors.centerIn: parent
                            font.pixelSize: 16
                            color: "black"
                            font.bold: true
                        }
                    }
                }
            }

            // ================= CONTENT =================
            Rectangle {
                visible: win.expanded
                height: parent.height - header.height
                width: parent.width
                color: "#0c0e16"
                radius: 8
                anchors.margins: 8

                // black background card (keeps your aesthetic)
                Rectangle {
                    id: card
                    anchors.fill: parent
                    anchors.margins: 10
                    radius: 15
                    color: "black"

                    Column {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 12

                        // TOP ROW: Hostname (left) + Uptime (right)
                        Row {
                            id: topRow
                            anchors.left: parent.left
                            anchors.right: parent.right
                            height: 75
                            spacing: 12

                            // Host card (left)
                            Rectangle {
                                id: hostCard
                                width: parent.width * 0.48
                                height: parent.height
                                radius: 12
                                color: "#0c0e16"
                                anchors.verticalCenter: parent.verticalCenter

                                Column {
                                    anchors.fill: parent
                                    anchors.margins: 10
                                    spacing: 6

                                    Text {
                                        id: hostnameText
                                        font.pixelSize: 23
                                        font.bold: true
                                        color: "#c0caf5"
                                        // arch glyph + hostname
                                        font.family: "JetBrainsMono Nerd Font"
                                        text: "\uf303  " + hostName
                                        elide: Text.ElideRight
                                    }

                                    Row {
                                        spacing: 8
                                        anchors.left: parent.left
                                        Text {
                                            font.pixelSize: 13
                                            color: "#9874bf"
                                            font.bold: true
                                            text: "Updates:"
                                        }
                                        // placeholder for updates count (you can wire a process)
                                        Text {
                                            font.pixelSize: 13
                                            color: "#a0a0a0"
                                            text: "\uf021" + "  " + updatesCount + " updates"
                                        }
                                    }
                                }
                            }

                            // Uptime card (right)
                            Rectangle {
                                id: uptimeCard
                                width: parent.width * 0.48
                                height: parent.height
                                radius: 12
                                color: "#0c0e16"
                                anchors.verticalCenter: parent.verticalCenter

                                Column {
                                    anchors.fill: parent
                                    anchors.margins: 10
                                    spacing: 6

                                    Text {
                                        font.pixelSize: 15
                                        font.bold: true
                                        color: "#c0caf5"
                                        text: "Uptime Status"
                                    }

                                    Text {
                                        padding: 3
                                        font.family: "JetBrainsMono Nerd Font"
                                        font.pixelSize: 13
                                        anchors.margins: 0
                                        color: "white"
                                        // glyph + human uptime text
                                        text: "\uf2f2  " + uptimeText
                                    }
                                }
                            }
                        }

                        // BOTTOM ROW: CPU | RAM | Storage (three cards)
                        Row {
                            id: bottomRow
                            anchors.left: parent.left
                            anchors.right: parent.right
                            height: 90
                            spacing: 12

                            // CPU card
                            Rectangle {
                                id: cpuCard
                                width: (parent.width - 16) / 2
                                height: parent.height
                                radius: 12
                                color: "#0c0e16"

                                Column {
                                    anchors.fill: parent
                                    anchors.margins: 12
                                    spacing: 8

                                    Text {
                                        font.pixelSize: 14
                                        font.bold: true
                                        color: "#c0caf5"
                                        text: "Cpu Usage \uf2db"
                                    }

                                    Text {
                                        font.pixelSize: 18
                                        font.bold: true
                                        color: "#7aa2f7"
                                        text: cpuUsage
                                    }

                                    // small inline spark (basic visual): percentage bar
                                    Rectangle {
                                        width: parent.width
                                        height: 8
                                        radius: 6
                                        color: "#0a0c10"
                                        anchors.horizontalCenter: parent.horizontalCenter

                                        Rectangle {
                                            width: Math.min(100, parseFloat(cpuUsage) || 0) * (parent.width - 4) / 100
                                            height: parent.height
                                            anchors.left: parent.left
                                            anchors.margins: 2
                                            radius: 6
                                            color: "#7aa2f7"
                                        }
                                    }
                                }
                            }

                            // RAM card
                            Rectangle {
                                id: ramCard
                                width: (parent.width - 16) / 2
                                height: parent.height
                                radius: 12
                                color: "#0c0e16"

                                Column {
                                    anchors.fill: parent
                                    anchors.margins: 12
                                    spacing: 8

                                    Text {
                                        font.pixelSize: 14
                                        font.bold: true
                                        color: "#c0caf5"
                                        text: "Ram Usage \uf538"
                                    }

                                    Text {
                                        font.pixelSize: 16
                                        font.bold: true
                                        color: "#7aa2f7"
                                        text: memUsage
                                    }

                                    // basic bar: try to parse numeric part (e.g. "3.4G / 8G" -> compute percent if possible)
                                    Rectangle {
                                        width: parent.width
                                        height: 8
                                        radius: 6
                                        color: "#0a0c10"
                                        anchors.horizontalCenter: parent.horizontalCenter

                                        Rectangle {
                                            width: {
                                                // attempt to compute percent from memUsage string
                                                var s = memUsage
                                                try {
                                                    var parts = s.split("/")
                                                    if (parts.length === 2) {
                                                        // convert sizes to bytes simply (G/M)
                                                        function toBytes(x) {
                                                            x = x.trim()
                                                            var num = parseFloat(x)
                                                            if (x.toUpperCase().indexOf("G") !== -1) return num * 1024 * 1024 * 1024
                                                            if (x.toUpperCase().indexOf("M") !== -1) return num * 1024 * 1024
                                                            if (x.toUpperCase().indexOf("K") !== -1) return num * 1024
                                                            return num
                                                        }
                                                        var used = toBytes(parts[0])
                                                        var total = toBytes(parts[1])
                                                        var perc = total > 0 ? (used / total) * 100 : 0
                                                        return Math.max(0, Math.min(parent.width - 4, (perc * (parent.width - 4) / 100)))
                                                    }
                                                } catch(e) { }
                                                return 0
                                            }
                                            height: parent.height
                                            anchors.left: parent.left
                                            anchors.margins: 2
                                            radius: 6
                                            color: "#7aa2f7"
                                        }
                                    }
                                }
                            }
                        }
                        // Storage card with vertical list
                        Rectangle {
                            id: diskCard
                            width: parent.width
                            height: 120
                            radius: 12
                            color: "transparent"
                            border.color: "white"

                            Column {
                                anchors.fill: parent
                                anchors.margins: 12
                                spacing: 6

                                Text {
                                    font.pixelSize: 14
                                    font.bold: true
                                    color: "#c0caf5"
                                    text: "Storage \uf0a0"
                                }

                                // Mount line: home
                                Row {
                                    spacing: 8
                                    anchors.left: parent.left
                                    Text {
                                        font.pixelSize: 13
                                        color: "#a0a0a0"
                                        text: "\uf015 /home/rudv-ar \u276f"
                                    }
                                    Item { width: 10 }
                                    Text {
                                        font.pixelSize: 13
                                        color: "#7aa2f7"
                                        elide: Text.ElideLeft
                                        text: diskHomeUsage
                                    }
                                }

                                // Mount line: root
                                Row {
                                    spacing: 8
                                    anchors.left: parent.left
                                    Text {
                                        font.pixelSize: 13
                                        color: "#a0a0a0"
                                        text: "\uf07c rootfs \u276f"
                                    }
                                    Item { width: 10 }
                                    Text {
                                        font.pixelSize: 13
                                        color: "#7aa2f7"
                                        elide: Text.ElideLeft
                                        text: diskRootUsage
                                    }
                                }

                                // Mount line: disk-a
                                Row {
                                    spacing: 8
                                    anchors.left: parent.left
                                    Text {
                                        font.pixelSize: 13
                                        color: "#a0a0a0"
                                        text: "\uf120   /sdisks/disk-a \u276f"
                                    }
                                    Item { width: 10 }
                                    Text {
                                        font.pixelSize: 13
                                        color: "#7aa2f7"
                                        elide: Text.ElideLeft
                                        text: diskDiskAUsage
                                    }
                                }
                            }
                        }            
                    }
                }
            }
        }
    }

    // ================= ANIMATIONS =================
    Behavior on width {
        NumberAnimation { duration: 260; easing.type: Easing.InOutQuad }
    }
    Behavior on height {
        NumberAnimation { duration: 260; easing.type: Easing.InOutQuad }
    }
}
