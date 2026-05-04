pragma Singleton
import QtQuick

QtObject {
    // ── Workspace ─────────────────────────────────────────────────────────────
    function workspaceSubscribe() {
        return ["bspc", "subscribe", "-c", "1",
                "desktop_focus", "node_add", "node_remove", "node_transfer"]
    }
    function workspaceFocused() {
        return ["bspc", "query", "-D", "-d", "focused", "--names"]
    }
    function workspaceOccupied() {
        return ["bspc", "query", "-D", "-d", ".occupied", "--names"]
    }
    function workspaceSwitch(name) {
        return ["bspc", "desktop", "-f", name]
    }
    // ── Launcher ──────────────────────────────────────────────────────────────
    function rofiLauncher() {
        return ["rofi_launcher"]
    }
  
}

