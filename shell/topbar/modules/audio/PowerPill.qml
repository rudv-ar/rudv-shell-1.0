import QtQuick
import qs.settings
import qs.components

Item {
    id: root

    implicitWidth:  _pill.implicitWidth
    implicitHeight: _pill.implicitHeight

    BasePill {
        id: _pill

        glyph:      Properties.rightbarPowerGlyph
        fontFamily: Properties.nerdFontFamily
        label:      "power"

        onClicked:  function(mouse) {}
        onScrolled: function(delta) {}
    }
}

