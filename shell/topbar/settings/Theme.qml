pragma Singleton
import QtQuick

QtObject {
    // ── Nord palette ──────────────────────────────────────────────────────────
    // Polar Night
    readonly property color nord0: "#2E3440"
    readonly property color nord1: "#3B4252"
    readonly property color nord2: "#434C5E"
    readonly property color nord3: "#4C566A"
    // Snow Storm
    readonly property color nord4: "#D8DEE9"
    readonly property color nord5: "#E5E9F0"
    readonly property color nord6: "#ECEFF4"
    // Frost
    readonly property color nord7: "#8FBCBB"
    readonly property color nord8: "#88C0D0"
    readonly property color nord9: "#81A1C1"
    readonly property color nord10: "#5E81AC"

    // ── Bar ───────────────────────────────────────────────────────────────────
    readonly property color barBackground: nord0
    readonly property color barBorder:     nord2

    // ── PillHover ─────────────────────────────────────────────────────────────
    readonly property color pillHoverBackground:        nord1
    readonly property color pillHoverBackgroundHovered: nord2
    readonly property color pillHoverPrimaryText:       nord6
    readonly property color pillHoverSecondaryText:     nord6
    readonly property color pillHoverSeparator:         nord3

    // ── PillStatic ────────────────────────────────────────────────────────────
    readonly property color pillStaticBackground:      nord1
    readonly property color pillStaticHoverBackground: nord2
    readonly property color pillStaticText:            nord6

    // ── Clock ─────────────────────────────────────────────────────────────────
    readonly property color clockPillBackground:     nord1
    readonly property color clockPillTimeColor:      nord6
    readonly property color clockPillDateColor:      nord8
    readonly property color clockPillSeparatorColor: nord3

    // ── Workspace dots ────────────────────────────────────────────────────────
    readonly property color workspaceDotFocusedColor:            nord8
    readonly property color workspaceDotOccupiedColor:           nord6
    readonly property color workspaceDotEmptyColor:              nord1
    readonly property color workspaceIndicatorBackground:        nord1
    readonly property color workspaceIndicatorBackgroundHovered: nord2

    // ── Workspace icon ────────────────────────────────────────────────────────
    readonly property color workspaceIconBackground:        nord1
    readonly property color workspaceIconBackgroundHovered: nord2
    readonly property color workspaceIconColor:             nord8

    // ── Audio / BasePill ──────────────────────────────────────────────────────
    readonly property color audioError: "#BF616A"
    
}
