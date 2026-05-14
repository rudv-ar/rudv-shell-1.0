import QtQuick
import qs.settings
import qs.components
import Quickshell
import Quickshell.Io

Item {
    id: root

    implicitWidth:  _pill.implicitWidth
    implicitHeight: _pill.implicitHeight

    BasePill {
        id: _pill

        glyph:      Properties.rightbarPowerGlyph
        fontFamily: Properties.nerdFontFamily
        label:      "power"

        onClicked: function(mouse) {
            if (mouse.button === Qt.LeftButton) {
                _proc.command = Commands.powerMenu()
                _proc.running = true
            }
        }

        onScrolled: function(delta) {}
    }

    Process {
        id: _proc
        running: false
    }
}
