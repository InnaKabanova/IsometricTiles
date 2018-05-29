import QtQuick 2.9

Item 
{
    id: floor

    width: 320
    height: width / 2 + width / 4 // (height of floor) + (height of wall)

    property int tileWidth: width / Const.tilesNum
    property int tileHeight: tileWidth / 2

    // Emitted when floor has to be re-drawn, thus a set of old tiles
    // is no longer valid:
    signal tileNoLongerNeeded()

    Component.onCompleted:
    {
        console.log("Floor completed | width: " + width);
    }

    onWidthChanged:
    {
        console.log("onWidthChanged | width: " + width);

        if(width > 0)
        {
            // Before calling the tiles creating algorithm,
            // make sure tileWidth and tileHeight are valid:
            tileWidth = width / Const.tilesNum;
            tileHeight = tileWidth / 2; // TO DO: odd numbers issue: is 1 px lost crucial?

            console.log("onWidthChanged | tileWidth: " + tileWidth + " | tileHeight: " + tileHeight);

            tileNoLongerNeeded();
            createWallsAndFloor();
        }
    }

    function createWallsAndFloor()
    {
        if(floor.width === 0 || tileWidth === 0 || tileHeight === 0)
        {
            console.log("createWallsAndFloor | called with invalid data !");
            return;
        }

        // 1. Create floor plain:
        populateTiles(true, 0);
    }

    // bool rhombus:
    // whether the object has a pyramid shape (false) or
    // a rhompus shape (true)

    function populateTiles(rhombus, initY)
    {
        var initX = floor.width / 2 - tileWidth / 2; // horizontalCenter + offset

        var i;
        var j;

        var tilesPerRow = 1;
        var secondHalf = false;
        var tilesPerRowIncrement = 1;

        var shiftX = tileWidth / 2;
        var shiftY = tileHeight / 2;

        for(i = 0; i < ( (rhombus) ? Const.tilesNum * 2 : Const.tilesNum ); i++)
        {
            var newY = initY + shiftY * i;
            var newX = initX - shiftX * (tilesPerRow - 1);

            for(j = 1; j <= tilesPerRow; j++)
            {
                createTile(newX, newY);
                newX = newX + tileWidth;
            }

            if(j === Const.tilesNum && rhombus)
            {
                secondHalf = true;
                tilesPerRowIncrement = -1;
            }

            tilesPerRow = tilesPerRow + tilesPerRowIncrement;
        }
    }

    function createTile(x, y)
    {
        console.log("createTile | x: " + x + " y: " + y + " tileWidth: " + tileWidth + " | tileHeight: " + tileHeight);

        var component;
        component = Qt.createComponent("Tile.qml");
        if (component.status === Component.Ready)
        {
            var newObject = component.createObject(floor, {"x": x, "y": y});
            newObject.width = tileWidth;
            newObject.height = tileHeight;
        }
        // QML TO DO: make an error handling
    }


}
