import Quickshell 
import Quickshell.Io 
import QtQuick 
import QtQuick.Controls 

Item {
    Rectangle {
        anchors.fill: parent 
        anchors.margins: 5
        radius: 15
        color: "#090c12"
        Column { 
            anchors.fill: parent 
            spacing: 1
        Item {
            width: parent.width 
            height: parent.height / 4
            Text {
                color: "white"
                font.pixelSize: 12 
                font.bold: false 
                font.family: "JetBrains Mono"
                text: "Github Panel"
                anchors.fill: parent
                anchors.margins: 5
                anchors.topMargin: 10
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
        Row {
            width: parent.width 
            height: parent.height / 3
            spacing: 0

            // This is a repeater
            Repeater {
            // This is the model of the repeater 
                model: [
                    { icon: "\uf113", tip: "Latest Repos", cmd: ["vicinae", "deeplink", "vicinae://extensions/thomaslombart/github/my-latest-repositories"] },
                    { icon: "\uf09d", tip: "Your PRs", cmd: ["vicinae", "deeplink", "vicinae://extensions/thomaslombart/github/my-pull-requests"] },
                    { icon: "\uf002", tip: "Search Repos", cmd: ["vicinae", "deeplink", "vicinae://extensions/thomaslombart/github/search-repositories"] },
                    { icon: "\uf005", tip: "Stared Repos",
                        cmd: ["vicinae", "deeplink", "vicinae://extensions/thomaslombart/github/my-starred-repositories"] },
                    { icon: "\uf542", tip: "Your Projects", cmd: ["vicinae", "deeplink", "vicinae://extensions/thomaslombart/github/my-project"] }
                ]

                // The linker which links the model to a type

                delegate: ArchItemGithub {
                    icon: modelData.icon
                    tooltip: modelData.tip
                    command: modelData.cmd
                    onGitapplaunched: archItemPopup.toggle()
                }
            }
        }

        Row {
            height: parent.height / 3
            width: parent.width
            spacing: 0

            // This is a repeater
            Repeater {
            // This is the model of the repeater 
                model: [
                    { icon: "\uf010", tip: "Search PRs", cmd: ["vicinae", "deeplink", "vicinae://extensions/thomaslombart/github/search-pull-requests"] },
                    { icon: "\uf067", tip: "Create PRs", cmd: ["vicinae", "deeplink", "vicinae://extensions/thomaslombart/github/create-pull-requests"] },
                    { icon: "\uf06a", tip: "Your Issues", cmd: ["vicinae", "deeplink", "vicinae://extensions/thomaslombart/github/my-issues"] },
                    { icon: "\uf055", tip: "Create Issues",
                        cmd: ["vicinae", "deeplink", "vicinae://extensions/thomaslombart/github/create-issues"] },
                    { icon: "\uf085", tip: "Workflows", cmd: ["vicinae", "deeplink", "vicinae://extensions/thomaslombart/github/workflow-runs"] }
                ]

                // The linker which links the model to a type

                delegate: ArchItemGithub {
                    icon: modelData.icon
                    tooltip: modelData.tip
                    command: modelData.cmd
                    onGitapplaunched: archItemPopup.toggle()
                }
            }
        }
        
        }
    }
}
