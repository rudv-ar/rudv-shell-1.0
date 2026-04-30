pragma Singleton
import QtQuick

QtObject {
    // Bar
    readonly property color barBackground:           Qt.rgba(0.18, 0.20, 0.25, 0.87)
    readonly property color barBorder:               "#3B4252"

    // PillHover
    readonly property color pillHoverBackground:         "#3B4252"
    readonly property color pillHoverBackgroundHovered:  "#434C5E"
    readonly property color pillHoverPrimaryText:        "#ECEFF4"
    readonly property color pillHoverSecondaryText:      "#88C0D0"
    readonly property color pillHoverSeparator:          "#4C566A"

    // PillStatic
    readonly property color pillStaticBackground:    "#3B4252"
    readonly property color pillStaticHoverBackground: "#3E475A"
    readonly property color pillStaticText:          "#ECEFF4"

    // Clock pill overrides (transparent center zone)
    readonly property color clockPillBackground:     "transparent"
    readonly property color clockPillTimeColor:      "#ECEFF4"
    readonly property color clockPillDateColor:      "#88C0D0"
    readonly property color clockPillSeparatorColor: "#4C566A"
}

