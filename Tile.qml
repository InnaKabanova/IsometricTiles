import QtQuick 2.7

Item
{
    id: tile
    width: 16
    height: 8

    Image
    {
        anchors.fill: parent
        source: "qrc:/tile.png"
    }

    Connections
    {
        target: parent
        onTileNoLongerNeeded:
        {
            console.log("Tile is destroying itself");
            tile.destroy();
        }
    }
 }
