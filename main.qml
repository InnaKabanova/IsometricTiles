import QtQuick 2.9
import QtQuick.Window 2.2

Window
{
    id: myWindow
    visible: true
    width: 320
    height: 480
    title: qsTr("Hello Tiles")

    // If needed, uncomment this:
    // minimumHeight: 320
    // minimumWidth: 480

    Item
    {
        id: dollhouseArea

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height * 0.7

        Rectangle
        {
            id: backgroundDollhouseArea
            anchors.fill: parent
            color: "lightyellow"
            radius: 15
            border.width: 1
            border.color: "black"
        }

        Dollhouse
        {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Item
    {
        id: reservedArea

        anchors.top: dollhouseArea.bottom
        anchors.topMargin: 2
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Rectangle
        {
            id: backgroundReservedArea
            anchors.fill: parent
            color: "lightcyan"
            radius: 15
            border.width: 1
            border.color: "black"
        }

    }
}
