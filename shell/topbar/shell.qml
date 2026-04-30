import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.settings
import qs.modules.clock

ShellRoot {
    Variants {
        model: Quickshell.screens

        delegate: Component {
	    
            PanelWindow {
                id: win
                required property var modelData

                screen: modelData

                anchors.top:   true
                anchors.left:  true
                anchors.right: true

                // PanelWindow is transparent; the visual bar is the Rectangle below
                color:         "transparent"
                implicitHeight: Properties.barHeight + Properties.barMarginTop

                // ── Visual bar ───────────────────────────────────────────────
                Rectangle {
                    id: bar

                    anchors.top:        parent.top
                    anchors.topMargin:  Properties.barMarginTop
                    anchors.left:       parent.left
                    anchors.leftMargin: Properties.barMarginLeft
                    anchors.right:      parent.right
                    anchors.rightMargin: Properties.barMarginRight

                    height: Properties.barHeight
                    radius: Properties.barRadius
                    color:  Theme.barBackground

                    border.color: Theme.barBorder
                    border.width: Properties.barFloating ? 1 : 0

                    // ── Three-zone layout ────────────────────────────────────
                    RowLayout {
                        anchors.fill:        parent
                        anchors.leftMargin:  Properties.barPaddingX
                        anchors.rightMargin: Properties.barPaddingX
                        spacing: 0

                        // Left zone
                        Item {
                            Layout.fillWidth: true
                            Layout.preferredWidth: 0
                            // modules go here later
                        }

                        // Center zone — clock pill, truly centered
                        ClockPillHover {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                        }

                        // Right zone
                        Item {
                            Layout.fillWidth: true
                            Layout.preferredWidth: 0
                            // modules go here later
                        }
                    }
                }
            }
        }
    }
}

