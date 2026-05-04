import QtQuick
import qs.settings
import qs.components

Item {
    id: root

    implicitWidth:  _pill.implicitWidth
    implicitHeight: _pill.implicitHeight

    BasePill {
        id: _pill

        glyph:      Properties.rightbarNetworkGlyph
        fontFamily: Properties.nerdFontFamily
        label:      "network"

        // no-op until NetworkService is wired
        onClicked:  function(mouse) {}
        onScrolled: function(delta) {}
    }
}

