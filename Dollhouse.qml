import QtQuick 2.7
import "."

Flickable
{
    width: Math.floor(parent.width / Const.tilesNum) * Const.tilesNum
    contentWidth: width
    contentHeight: floorOne.height + floorTwo.height

    Component.onCompleted:
    {
        console.log("Dollhouse completed");
    }

    Floor
    {
        id: floorOne

        width: parent.width
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Floor
    {
        id: floorTwo

        width: parent.width
        anchors.top: floorOne.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
