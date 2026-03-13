// Root file

import Quickshell
import Quickshell.Io 
import QtQuick 
import QtQuick.Controls 

import "./leftbar"
import "./rightbar"
import "./centerbar"
Scope {
    // run left bar
    LeftBar {}
    // run right bar 
    RightBar {}
    // run center bar
    WorkSpace {}
}
