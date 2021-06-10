import QtQuick 2.1
import "ToonGamesBalloonToolBar.js" as ToolBar

Item {
    id: toolBarItem
    width: game.width
    height: 60

    Rectangle {
        color: Qt.rgba(0, 0, 0, 0.2)
        anchors.fill: parent
    }

    Component {
        id: dartComponent
        Image {
            source: 'file:///qmf/qml/apps/toonGames/drawables/toonGamesBalloonDart.png'
            width: 46
            x: 0

            transform: Rotation {
                id: rotator

                origin {
                    x: 23
                    y: parent.height/2
                 }
                 angle: 90
            }
        }
    }

    Component.onCompleted: {
        paintDart()
    }
	
	function paintDart() {
		console.log("balloonGame dart created")
		for (var i = 0; i < 12; i++) {
            var item = dartComponent.createObject(toolBarItem);
            item.y=-0;
            item.x=(item.x + 28) *i;
            ToolBar.items.push(item);
        }
	}

    function dropDart() {
        var item = ToolBar.items.pop();
        if (!item) return;
        item.destroy();
    }
}
