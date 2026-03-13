import Quickshell
import Quickshell.Io 
import QtQuick 
import QtQuick.Controls 

Item {
    id: xtitleItem
    width: xtitle.implicitWidth + 24
    height: parent.height 
    anchors.right: parent.right
    Rectangle { 
        id: xtitleItemRect
        anchors.fill: parent 
        color: "#0b0d15"
        radius: 15 
        border.width: 1.2 
        border.color: "#1c1c2a"
        anchors.margins: 3 

        Text { 
            id: xtitle
            font.pixelSize: 16
            font.family: "JetBrainsMono Nerd Font"
            anchors.fill: parent
            color: "#c0caf5"
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "..."
            wrapMode: Text.NoWrap

        }
        Process {
            id: activeTitleProc
            command: ["sh", "-c", "xdotool getwindowfocus getwindowname 2>/dev/null || echo [rudv-ar]"]
            running: true
    
            stdout: StdioCollector {
                onStreamFinished: {
                    // update text to whatever `xdotool` printed
                    var app = text.trim().split(/[ :]/)[0]
                    if (app.includes("@Arch247"))
                        app = "alacritty"
                    if (app === "")
                        app = "[rudv-ar]"
                    xtitle.text = xtitleItemRect.appGlyph(app) + " " + app
                }
            }
        }
    
        Timer {
            interval: 500
            running: true
            repeat: true
            onTriggered: {
                // restart process each interval
                activeTitleProc.running = true
            }
        }
    
        function appGlyph(name) {
            switch (name.toLowerCase()) {
                case "firefox":    return ""
                case "alacritty":  return ""
                case "kitty":      return ""
                case "code":       return "󰨞"
                case "chromium":   return ""
                case "nvim":
                case "neovim":       return ""
                case "vim":          return ""
                case "code":
                case "code-oss":
                case "vscode":       return "󰨞"
                case "subl":         return ""

                // Shell / UI
                case "quickshell":   return "󱄅"
                case "bspwm":        return ""
                case "sxhkd":        return "󰕮"

                default:           return "󰣆"
            }
        }       

    }

}
