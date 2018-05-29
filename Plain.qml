import QtQuick 2.9

Item 
{
    id: plain

    // Configuration is a must:
    property int rowsNum: 0 // y, height
    property int columnsNum: 0 // x, width
    property int tileWidth: 0

    // Dependent values:
    property int tileHeight: tileWidth / 2
    width: (rowsNum + columnsNum) * (tileWidth / 2)
    height: (rowsNum + columnsNum - 2) * (tileHeight / 2) + tileHeight
    Rectangle
    {
        id: debuggingRect
        color: "moccasin"
        border.color: "black"
        anchors.fill: parent
    }

    // Emitted when a plain has to be re-drawn, thus a set of old tiles
    // is no longer valid:
    signal tileNoLongerNeeded()

    Component.onCompleted:
    {
        console.log("Plain completed");
    }

    onRowsNumChanged:
    {
        console.log("Plain | onRowsNumChanged | rowsNum: " + rowsNum + " columnsNum: " + columnsNum);
        createPlain();
    }
    onColumnsNumChanged:
    {
        console.log("Plain | onColumnsNumChanged | columnsNum: " + columnsNum + " rowsNum: " + rowsNum);
        createPlain();
    }
    onTileWidthChanged:
    {
        console.log("Plain | onTileWidthChanged | tileWidth: " + tileWidth + " tileHeight: " + tileHeight);
        // Re-calculate tileHeight (just in case): // QML TO DO: test if this needed
        tileHeight = tileWidth / 2;
        createPlain();
    }

    function createPlain()
    {
        console.log("Plain | createPlain | rowsNum: " + rowsNum + " columnsNum: " + columnsNum + " tileWidth: " + tileWidth);
        if(rowsNum === 0 || columnsNum === 0 || tileWidth === 0)
        {
            console.log("Plain | createPlain | Invalid input. Returning");
        }

        tileNoLongerNeeded();

        // NOTE: this implementation derives from a fact that a rhombus tile is
        // actually contained within a rectangle image (see the assets).

        var i, j;

        // Initial tile's (0 row 0 column) position:
        var initX = (rowsNum - 1) * tileWidth / 2;
        var initY = 0;

        var shiftX = tileWidth / 2;
        var shiftY = tileHeight / 2;

        for(i = 0; i < columnsNum; i++)
        {
            for(j = 0; j < rowsNum; j++)
            {
                var newX = initX - shiftX * j;
                var newY = initY + shiftY * j;
                createTile(newX, newY);
            }
            initX = initX + shiftX;
            initY = initY + shiftY;
        }
    }

    function createTile(x, y)
    {
        console.log("createTile | x: " + x + " y: " + y + " tileWidth: " + tileWidth + " | tileHeight: " + tileHeight);

        var component;
        component = Qt.createComponent("Tile.qml");
        if (component.status === Component.Ready)
        {
            var newObject = component.createObject(plain, {"x": x, "y": y});
            newObject.width = tileWidth;
            newObject.height = tileHeight;
        }
        // QML TO DO: make an error handling
    }


}
