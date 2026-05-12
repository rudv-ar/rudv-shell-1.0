import QtQuick
import qs.settings

Item {
    id: root

    property string glyph:        "\uf128"
    property string fontFamily:   Properties.nerdFontFamily
    property string label:        ""
    property bool   popoutOpen:   false
    property bool   muted:        false
    property bool   alwaysExpanded: false          // ← NEW
    property color  accentColor:  Theme.base0C//Theme.nord8
    property color  accentOnColor: Theme.base00

    signal clicked(var mouse)
    signal scrolled(real delta)

    readonly property real sceneCenterX: mapToItem(null, width / 2, 0).x
    readonly property bool hovered:      _mouse.containsMouse

    // single derived bool — all visual logic reads this
    readonly property bool _active: alwaysExpanded || hovered

    implicitWidth:  _bg.implicitWidth
    implicitHeight: Properties.basePillHeight

    Rectangle {
        id: _bg

        height: Properties.basePillHeight
        radius: Properties.basePillRadius

        color: root.popoutOpen
               ? Theme.base01
               : root.muted
                 ? Qt.rgba(Theme.audioError.r,
                           Theme.audioError.g,
                           Theme.audioError.b, 0.18)
                 : root._active
                   ? Theme.base02
                   : Theme.base01

        implicitWidth: {
            const base = Properties.basePillPadding
                       + Properties.basePillIconBgSize
                       + Properties.basePillPadding
            if (root._active
                    && Properties.basePillHoverEnabled
                    && _label.implicitWidth > 0)
                return base
                     + Properties.basePillSpacing
                     + _label.implicitWidth
            return base
        }

        Behavior on implicitWidth {
            NumberAnimation {
                duration:    Properties.basePillExpandDuration
                easing.type: Easing.OutCubic
            }
        }

        Behavior on color {
            ColorAnimation { duration: Properties.basePillExpandDuration }
        }

        Rectangle {
            id: _iconBg

            anchors.left:           parent.left
            anchors.leftMargin:     Properties.basePillPadding
            anchors.verticalCenter: parent.verticalCenter

            width:  Properties.basePillIconBgSize
            height: Properties.basePillIconBgSize
            radius: Properties.basePillIconBgRadius

            color: root._active && Properties.basePillHoverEnabled
                   ? (root.muted ? Theme.audioError : root.accentColor)
                   : Theme.base01

            Behavior on color {
                ColorAnimation { duration: Properties.basePillExpandDuration }
            }

            Text {
                id: _iconText

                anchors.centerIn: parent
                text:             root.glyph
                font.pixelSize:   Properties.basePillIconSize
                font.family:      root.fontFamily
                font.weight:      Font.Black

                color: root._active && Properties.basePillHoverEnabled
                       ? (root.muted ? Theme.base00 : root.accentOnColor)
                       : (root.muted ? Theme.audioError : Theme.base06)

                rotation: root._active
                          && Properties.basePillIconRotateEnabled ? 360 : 0

                Behavior on rotation {
                    NumberAnimation {
                        duration:    Properties.basePillIconRotateDuration
                        easing.type: Easing.OutCubic
                    }
                }

                Behavior on color {
                    ColorAnimation { duration: Properties.basePillExpandDuration }
                }
            }
        }

        Text {
            id: _label

            anchors.left:           _iconBg.right
            anchors.leftMargin:     Properties.basePillSpacing
            anchors.verticalCenter: parent.verticalCenter

            text:           root.label
            font.pixelSize: Properties.basePillFontSize
            font.weight:    Font.Medium
            color:          Theme.nord6

            opacity: root._active && Properties.basePillHoverEnabled ? 1.0 : 0.0
            visible: opacity > 0

            Behavior on opacity {
                NumberAnimation {
                    duration:    Properties.basePillExpandDuration
                    easing.type: Easing.OutCubic
                }
            }
        }
    }

    MouseArea {
        id:              _mouse
        anchors.fill:    parent
        hoverEnabled:    true
        cursorShape:     Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: (mouse) => root.clicked(mouse)
        onWheel:   (wheel) => root.scrolled(wheel.angleDelta.y > 0 ? 1.0 : -1.0)
    }
}
