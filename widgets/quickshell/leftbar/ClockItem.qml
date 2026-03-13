import Quickshell
import Quickshell.Io 
import QtQuick 
import QtQuick.Controls 

Item {

    signal toggleClockItemPopup()
    signal openClockItemPopup()
    signal hideClockItemPopup()
    signal hideArchItemPopup()
    signal hideOpenWindowsItemPopup()
    
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
            // Reference the text clock with id
            clockItemText.text = pad(currentDate.getHours()) + ":" + pad(currentDate.getMinutes())
        }
    }



    id: clockItem
    width: ((parent.width - 5) * 2.2) / 8
    height: parent.height

    Rectangle {
        id: clockItemRect
        anchors.fill: parent 
        anchors.margins: 2
        anchors.leftMargin: 0
        border.width: 1.2 
        border.color: "#1c1c2a"
        color: "#0c0e16"
        radius: 15
        // The Time text box goes here
        Text {    
            id: clockItemText
            color: "white"
            anchors.fill: parent 
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            font.pixelSize: 17
            font.family: "JetBrains Mono"
            font.bold: true
            text: "..\uf017.."
        }

        // Mouse Area 
        MouseArea {
            id: clockItemMouseArea
            anchors.fill: parent 
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onEntered: {
                //openClockItemPopup()
                //hideArchItemPopup()
                //hideOpenWindowsItemPopup()
            }
            onClicked: { 
                toggleClockItemPopup()
                hideArchItemPopup()
                hideOpenWindowsItemPopup()
                
            }
        }
    }
}
