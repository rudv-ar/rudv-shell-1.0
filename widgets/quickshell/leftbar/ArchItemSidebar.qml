import QtQuick 
import Quickshell
import Quickshell.Io 
import QtQuick.Controls 


// The first rectangle in item : sidebar
Item {
    id: archPopupSidebar
    width: parent.width / 4
    height: parent.height

    Rectangle {
        anchors.fill: parent 
        anchors.margins: 10 
        radius: 15
        color: "#0a0a0a"

        Column {
            anchors.fill: parent
            spacing: 0

            // This is a repeater
            Repeater {
            // This is the model of the repeater 
                model: [
                    { icon: "\uf07b", tip: "Thunar", cmd: ["thunar", "/home/rudv-ar"] },
                    { icon: "\uf120", tip: "Alacritty", cmd: ["alacritty", "--working-directory", "/home/rudv-ar"] },
                    { icon: "\uf121", tip: "Geany", cmd: ["geany"] },
                    { icon: "\uf1d3", tip: "GitHub Notifications",
                        cmd: ["vicinae", "deeplink", "vicinae://extensions/thomaslombart/github/notifications"] },
                    { icon: "\uf1de", tip: "Picom Settings", cmd: ["/home/rudv-ar/Disk-A/Rust/Toml/toml-config/target/release/toml-gui", "/home/rudv-ar/.config/bspwm/bspwm.d/picom/picom.toml"] },
                    { icon: "\uf013", tip: "B-Settings", cmd: ["/home/rudv-ar/Disk-A/Rust/Toml/toml-config/target/release/toml-gui"] },
                        // cmd: ["alacritty", "--working-directory", "/home/rudv-ar/.config/bspwm/bspwm.d", "-e", "nvim", "settings.sh"] },
                    { icon: "\uf044", tip: "Obsidian", cmd: ["obsidian"] }
                ]

                // The linker which links the model to a type

                delegate: ArchItemApp {
                    icon: modelData.icon
                    tooltip: modelData.tip
                    command: modelData.cmd
                    onLaunched: archItemPopup.toggle()
                }
            }
        }
    }

}
