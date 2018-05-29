import QtQuick 2.7
import "."

Flickable
{
    id: dollhouse

    width: parent.width
    height: contentHeight
    property int tileWidth: Math.floor(width / (Const.rows + Const.columns) * 2)

    contentWidth: width
    contentHeight: floorOne.height + floorTwo.height

    Component.onCompleted:
    {
        console.log("Dollhouse completed");
    }

    onTileWidthChanged:
    {
        console.log("onTileWidthChanged | superTileWidth: " + tileWidth);

    }

    Plain
    {
        id: floorOne

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        rowsNum: Const.rows
        columnsNum: Const.columns
        tileWidth: dollhouse.tileWidth
    }

    Plain
    {
        id: floorTwo

        anchors.top: floorOne.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        rowsNum: Const.rows
        columnsNum: Const.columns
        tileWidth: dollhouse.tileWidth
    }
}
