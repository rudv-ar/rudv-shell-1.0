import Quickshell 
import Quickshell.Io 
import QtQuick 
import QtQuick.Controls 

Item {

    property int radius: 15
    property string color: "#565f89"
    // The rectangle
    Rectangle {
        color: parent.color
        anchors.fill: parent
        radius: parent.radius
        opacity: 0.8

    }
}

