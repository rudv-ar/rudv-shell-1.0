import Quickshell
import Quickshell.Io
import QtQuick

PanelWindow {
  id: wsPanel
  anchors {
    top: true
    right: false
    left: false
    bottom: false
  }
  implicitHeight: 45
  implicitWidth: workspaceRow.width + workspaceRow.padding * 2
  color: "transparent"

  Rectangle {
    id: wsRoot
    anchors.fill: parent 
    anchors.margins: 7
    anchors.leftMargin: 0
    anchors.rightMargin: 0
    color: "#0c0e16"
    border.color: "#1d1d2c"
    border.width: 1.2
    radius: 15
  }

  Row {
    id: workspaceRow
    anchors.centerIn: parent
    spacing: 10
    padding: 7
  }

  // Process to fetch workspaces + window count
  Process {
    id: fetchWorkspaces
    command: ["bash", "-c", `
      bspc query -D --names | while read desk; do
        win_count=$(bspc query -N -d "$desk" | wc -l)
        echo "$desk $win_count"
      done
    `]
    running: false

    stdout: StdioCollector {
      onStreamFinished: {
        let lines = text.trim().split("\n")
        let wsInfo = lines.map(line => {
          let parts = line.trim().split(" ")
          return {name: parts[0], winCount: parseInt(parts[1])}
        })
        updateWorkspaces(wsInfo)
        fetchWorkspaces.running = false
        workspaceTimer.start()
      }
    }
  }

  Timer {
    id: workspaceTimer
    interval: 500  // 500 m seconds
    running: true
    repeat: false
    onTriggered: {
      if (!fetchWorkspaces.running) {
        fetchWorkspaces.running = true
      }
    }
  }

  Process {
    id: fetchActive
    command: ["bash", "-c", "bspc query -D -d focused --names"]
    running: false

    stdout: StdioCollector {
      onStreamFinished: {
        activeWorkspace = text.trim()
        updateHighlight()
        fetchActive.running = false
        activeTimer.start()
      }
    }
  }

  Timer {
    id: activeTimer
    interval: 500 // 1 second
    running: true
    repeat: false
    onTriggered: {
      if (!fetchActive.running) {
        fetchActive.running = true
      }
    }
  }

  // Process to switch workspace on click
  Process {
    id: workspaceSwitchProcess
    running: false

    stdout: StdioCollector {
      onStreamFinished: {
        // Refresh active workspace highlight after switching
        fetchActive.running = true
        workspaceSwitchProcess.running = false
      }
    }
  }

  property var workspaces: []
  property string activeWorkspace: ""

  function updateWorkspaces(wsInfo) {
    workspaces = wsInfo
    workspaceRow.children.forEach(child => child.destroy())

    wsInfo.forEach(function(ws) {
      let wsItem = Qt.createQmlObject(`
        import QtQuick 2.15
        import Quickshell 0.1

        Item {
          width: 20
          height: 20
          property int winCount: 0

          Rectangle {
            id: dot
            anchors.centerIn: parent
            width: 12
            height: 12
            radius: 8
            color: "#414868"
            border.color: "#414868"
            border.width: 1
          }

          Rectangle {
            id: filledDot
            anchors.centerIn: parent
            width: 12
            height: 12
            radius: 8
            color: "#c0caf5"
            visible: false
          }

          Rectangle {
            id: dash
            anchors.centerIn: parent
            width: 25
            height: 12
            radius: 8
            color: "#ffffff"
            visible: false
          }

          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
              workspaceSwitchProcess.command = ["bspc", "desktop", "-f", "${ws.name}"]
              workspaceSwitchProcess.running = true
            }
          }
        }
      `, workspaceRow)

      wsItem.objectName = ws.name
      wsItem.winCount = ws.winCount
    })

    updateHighlight()
  }

  function updateHighlight() {
    workspaceRow.children.forEach(child => {
      if (child.objectName === activeWorkspace) {
        // active workspace: dash
        child.children[0].color = "transparent"
        child.children[0].border.width = 0
        child.children[1].visible = false
        child.children[2].color = "#ffffff"
        child.children[2].visible = true
      } else if (child.winCount > 0) {
        // inactive workspace with windows: filled dot
        child.children[0].color = "transparent"
        child.children[0].border.width = 0
        child.children[1].color = "#c0caf5"
        child.children[1].visible = true
        child.children[2].visible = false
      } else {
        // inactive workspace no windows: hollow dot
        child.children[0].color = "#414868"
        child.children[0].border.width = 1
        child.children[1].visible = false
        child.children[2].visible = false
      }
    })
  }
}
