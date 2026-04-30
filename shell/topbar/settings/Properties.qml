pragma Singleton
import QtQuick

QtObject {
    // ── Bar ─────────────────────────────────────────────────────────────────
    readonly property bool   barFloating:        false
    readonly property int    barHeight:          32
    readonly property real   barRadius:          barFloating ? 12 : 0
    readonly property real   barMarginTop:       barFloating ? 8  : 0
    readonly property real   barMarginLeft:      barFloating ? 8  : 0
    readonly property real   barMarginRight:     barFloating ? 8  : 0
    readonly property real   barPaddingX:        12

    // ── PillHover ────────────────────────────────────────────────────────────
    readonly property real   pillHoverRadius:       8
    readonly property real   pillHoverPaddingX:     10
    readonly property real   pillHoverPaddingY:     4
    readonly property real   pillHoverSpacing:      6
    readonly property int    pillHoverAnimDuration: 180

    // ── PillStatic ───────────────────────────────────────────────────────────
    readonly property real   pillStaticRadius:   8
    readonly property real   pillStaticPaddingX: 10
    readonly property real   pillStaticPaddingY: 4

    // ── Clock ────────────────────────────────────────────────────────────────
    readonly property bool   clockUse24h:              true
    readonly property bool   clockShowSeconds:          false
    readonly property bool   clockPillShowTimeFirst:    true   // time visible by default; hover → date
    readonly property int    clockPillTimeFontSize:     13
    readonly property int    clockPillDateFontSize:     12
    readonly property string clockPillFontFamily:       "Sans"
}

