pragma Singleton
import QtQuick

QtObject {
    readonly property int  borderThickness: 10
    readonly property int  topOffset:       32 + 2    // bar height — no border drawn here
    readonly property real cornerRadius:    18.0
}

