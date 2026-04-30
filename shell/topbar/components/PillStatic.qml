import QtQuick
import qs.settings

Item {
    id: root

    property string text:        ""
    property int    fontSize:    13
    property string fontFamily:  Properties.clockPillFontFamily
    property color  textColor:   Theme.pillStaticText
    property color  pillBackground: Theme.pillStaticBackground
    property real   pillRadius:     Properties.pillStaticRadius
    property real   paddingX:       Properties.pillStaticPaddingX
    property real   paddingY:       Properties.pillStaticPaddingY

    implicitWidth:  label.implicitWidth + paddingX * 2
    implicitHeight: Properties.barHeight

    Rectangle {
        anchors.verticalCenter:   parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width:  root.implicitWidth
        // Same vertical inset logic as PillHover
        height: root.implicitHeight - root.paddingY * 2
        radius: root.pillRadius
        color:  root.pillBackground
    }

    Text {
        id: label
        anchors.centerIn:  parent
        text:              root.text
        color:             root.textColor
        font.pixelSize:    root.fontSize
        font.family:       root.fontFamily
        verticalAlignment: Text.AlignVCenter
    }
}

