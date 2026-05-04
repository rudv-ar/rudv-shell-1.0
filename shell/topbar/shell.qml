import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.settings
import qs.modules.clock
import qs.modules.workspace

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

                color:         "transparent"
                implicitHeight: Properties.barHeight + Properties.barMarginTop

                // ── Visual bar ────────────────────────────────────────────────
                Rectangle {
                    id: bar

                    anchors.top:         parent.top
                    anchors.topMargin:   Properties.barMarginTop
                    anchors.left:        parent.left
                    anchors.leftMargin:  Properties.barMarginLeft
                    anchors.right:       parent.right
                    anchors.rightMargin: Properties.barMarginRight

                    height: Properties.barHeight
                    radius: Properties.barRadius
                    color:  Theme.barBackground

                    border.color: Theme.barBorder
                    border.width: Properties.barFloating ? 1 : 0

                    // ── Three-zone layout ─────────────────────────────────────
                    RowLayout {
                        anchors.fill:        parent
                        anchors.leftMargin:  Properties.barPaddingX
                        anchors.rightMargin: Properties.barPaddingX
                        spacing: 0

                        // Left zone — workspace indicator
                        Item {
                            Layout.fillWidth:    true
                            Layout.preferredWidth: 0

                            WorkspaceIndicator {
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left:           parent.left
                            }
                        }

                        // Center zone — clock, truly centered
                        ClockPillHover {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                        }

                        // Right zone — empty for now
                        Item {
                            Layout.fillWidth:    true
                            Layout.preferredWidth: 0
                        }
                    }
                }
            }
        }
    }
}

