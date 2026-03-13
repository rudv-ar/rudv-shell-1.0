import Quickshell 
import Quickshell.Io 
import QtQuick
import QtQuick.Controls 

Item {

    Rectangle {
        anchors.fill: parent 
        color: "#0a0d17"
        radius: 15

        Column {
            anchors.fill: parent 
            anchors.margins: 2 
            spacing: 20 

            // the quote header
            Item {
                width: parent.width
                height: 15
                Text {
                    anchors.fill: parent
                    anchors.margins: 5
                    color: "white"
                    font.bold: true 
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHLeft
                    text: "Quote \u00bb"
                    font.family: "JetBrains Mono"
                    font.pixelSize: 12
                }
            }
            // The quote
            Item {
                width: parent.width
                height: 30 
                Text {
                    color: "#c0caf5"
                    anchors.margins: 5
                    anchors.fill: parent
                    font.bold: false 
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: quoteText
                    wrapMode: Text.WordWrap
                    width: parent.width
                    font.family: "JetBrains Mono"
                    font.pixelSize: 12
                }
            } 
            Process {
                id: quoteProcess
                running: false
                command: [
                    "bash", "-c",
                    "shuf -n 1 $HOME/.config/bspwm/widgets/quickshell/src/quotes.txt"
                ]

                stdout: StdioCollector {
                    onStreamFinished: {
                        quoteText = text.trim()
                        quoteProcess.running = false
                    }
                }                           
            }
        }
    }

    // Define a function for toggling quoteProcess 
    function toggle(){
        if (!parent.visible) {
            quoteProcess.running = false
        } else {
            quoteProcess.running = true
        }
    }
}

