import Quickshell
import Quickshell.Io 
import QtQuick
import QtQuick.Controls

// The popup window for clock click
PopupWindow {
    // Define the properties of the bar 
    property date currentDate: new Date() 
    property string quoteText: "..."


    // Define the functions of the bar 
    function pad(num) {
        return num < 10 ? "0" + num : num
    }


    function getMonthName(monthIndex) {
        const months = ["JANUARY","FEBRUARY","MARCH","APRIL","MAY","JUNE","JULY","AUGUST","SEPTEMBER","OCTOBER","NOVEMBER","DECEMBER"]
        return months[monthIndex]
    }

    function getWeekdayName(dayIndex) {
        const days = ["\uf185  SUNDAY","\uf186  MONDAY","\uf06d  TUESDAY","\uf6c4  WEDNESDAY","\uf0e7  THURSDAY","\uf005  FRIDAY","\uf236  SATURDAY"]
        return days[dayIndex]
    }


    // Define the timers for the bar

    // A timer for collapsed clock 
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            currentDate = new Date()
        }
    }


    id: clockPopup 
    anchor.window: mainLeftBar 
    anchor.rect.x: 15
    anchor.rect.y: mainLeftBar.implicitHeight

    visible: false
    color: "transparent"

    // animation state 
    property bool opened: false 

    // take the height and width of the child
    implicitHeight: clockPopupRoot.height
    implicitWidth: clockPopupRoot.width


    // Add timer for popup 

    Timer {
        id: clockPopupTimer
        interval: 130   // slightly more than animation duration (120)
        repeat: false
        onTriggered: clockPopup.visible = false
    }

    HoverHandler {
        acceptedDevices: PointerDevice.Mouse
        onHoveredChanged: {
            if (!hovered) {
                clockPopup.toggle()
            }
        }
    }                        

    // The Popup Rectangle for Clock 
    Rectangle {

        id: clockPopupRoot
        width: clockPopup.opened ? 220 : 0 
        height: clockPopup.opened ? 200 : 0
        border.width: 1.2
        border.color: "#1c1c2a"
        color: "#0c0e16"
        radius: 15 

        // Define the Root Column of the popup 
        Column {
            id: clockPopupRootColumn
            anchors.fill: parent 
            anchors.margins: 5 
            anchors.topMargin: 15
            spacing: 5 

            // The First Item of Popup : Date | Month 
            ClockMonthDate {
                id: clockPopupDay
                width: parent.width 
                height: (parent.height - 5) / 7
            }

            // The Second Item of popup : Year | Time
            ClockYearTime {
                id: clockPopupYearTime
                width: parent.width 
                height: (parent.height - 5) / 10
            }
            // The third item of popup : WeekDay
            ClockWeekDay {
                id: clockPopupWeekDay
                width: parent.width 
                height: (parent.height - 5) / 7
            }
            // Horizontal Ruler 
            HorizontalRuler {
                id: hr1
                width: parent.width
                height: (parent.height - 5) / 100
            }
            // The Quote Item 
            ClockQuoteItem {
                id: quoteItem
                width: parent.width 
                height: parent.height / 2 
            }
        }

        Behavior on width {
            NumberAnimation {
                duration: 120
                easing.type: Easing.OutCubic
            }
        }

        Behavior on height {
            NumberAnimation {
                duration : 120 
                easing.type: Easing.OutCubic
            }
        }
    }


    // Define some functions
    function toggle() {
        if (!visible) {
            clockPopupTimer.stop()
            visible = true
            opened = true
            quoteItem.toggle()
        } else {
            opened = false
            quoteItem.toggle()
            clockPopupTimer.restart()
        }
    }
    function show() {
        clockPopupTimer.stop()
        quoteItem.toggle()
        visible = true 
        opened = true 
    }
    function hide() { 
        opened = false 
        quoteItem.toggle()
        clockPopupTimer.restart()
    }
    
}


