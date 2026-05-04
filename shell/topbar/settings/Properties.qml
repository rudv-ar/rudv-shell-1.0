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
    readonly property real   pillHoverRadius:       10
    readonly property real   pillHoverPaddingX:     10
    readonly property real   pillHoverPaddingY:     4
    readonly property real   pillHoverSpacing:      6
    readonly property int    pillHoverAnimDuration: 180

    // ── PillStatic ───────────────────────────────────────────────────────────
    readonly property real   pillStaticRadius:   10
    readonly property real   pillStaticPaddingX: 10
    readonly property real   pillStaticPaddingY: 4

    // ── Clock ────────────────────────────────────────────────────────────────
    readonly property bool   clockUse24h:              true
    readonly property bool   clockShowSeconds:          false
    readonly property bool   clockPillShowTimeFirst:    true   // time visible by default; hover → date
    property bool clockPillIsExpanded: true
    readonly property int    clockPillTimeFontSize:     13
    readonly property int    clockPillDateFontSize:     12
    readonly property string clockPillFontFamily:       "Sans"

    // ── Workspace ─────────────────────────────────────────────────────────────
    readonly property var    workspaceNames:                   ["1","2","3","4","5","6","7","8"]
    readonly property real   workspaceDotSize:                 12
    readonly property real   workspaceDotFocusedWidth:         25
    readonly property real   workspaceDotRadius:               10
    readonly property real   workspaceDotSpacing:              5
    readonly property int    workspaceDotAnimDuration:         150
    readonly property real   workspaceIndicatorPaddingX:       10
    readonly property real   workspaceIndicatorPaddingY:       4
    readonly property real   workspaceIndicatorRadius:         10
    readonly property bool   workspaceIndicatorAlwaysExpanded: false


    // "none" | "collapsed" | "expanded" | "always"
    readonly property string workspaceDotLabelMode:     "always"
    readonly property int    workspaceDotLabelFontSize: 8
    readonly property string nerdFontFamily:      "JetBrainsMono Nerd Font"
    readonly property int    workspaceIconFontSize: 14
    readonly property real   workspaceIconGap:      6     // gap between icon pill and dots pill

    readonly property var workspaceIconGlyphs: ({
        "1": "\uf303",   // arch linux
        "2": "\uf489",   // terminal
        "3": "\uf269",   // firefox
        "4": "\ue70c",   // vim/editor
        "5": "\uf001",   // music
        "6": "\uf07c",   // files
        "7": "\uf086",   // chat
        "8": "\uf013"    // settings
    })
    
}

