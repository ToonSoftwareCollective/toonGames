import QtQuick 2.1
import BasicUIControls 1.0
import qb.components 1.0

Screen {
    id: menuBox
    opacity: 1

    Image {
        id: background
        anchors.fill: parent
        source: "file:///qmf/qml/apps/toonGames/drawables/toonGamesBalloonsky.jpg"
        fillMode: Image.PreserveAspectCrop
    }


    Rectangle {
        id: menuScreen
        width:  isNxt? 400 :320
        height: isNxt? 400 :320
        opacity: 1
        color: Qt.rgba(0, 0, 0, 0.4)
        radius: 5
        anchors {
            horizontalCenter: parent.horizontalCenter;
            verticalCenter: parent.verticalCenter;}

        Rectangle {
            id: logo
            width: gameName.width
            height: gameName.heigth
            color: "#c1c1c1"

            anchors {
                horizontalCenter: parent.horizontalCenter;
                verticalCenter: parent.verticalCenter;}


            Text {
                id:gameName
                x: 0
                y: isNxt? -180 : -144
                color: "#fff"
                anchors {
                    horizontalCenter:parent.horizontalCenter;
                    verticalCenter: parent.verticalCenter;}
                anchors.rightMargin: 10
                text: "Balloon!"
                anchors.verticalCenterOffset: isNxt? -140 :-112
                font.family: qfont.regular.name
                font.pointSize: isNxt? 60 : 48
            }
			
			Text {
                id:endScore
                x: 0
                y: isNxt? -140 : -110
                color: "#fff"
                anchors {
                    horizontalCenter:parent.horizontalCenter;
                    verticalCenter: parent.verticalCenter;}
                anchors.rightMargin: 10
                text: gameScreen.scoreText
                anchors.verticalCenterOffset: isNxt? -20 :-16
                font.family: qfont.regular.name
                font.pointSize: isNxt? 20 : 16
            }
			
        }

        Rectangle {
            id: newgameButton
            anchors.horizontalCenter: menuScreen.horizontalCenter;
            anchors.verticalCenter: menuScreen.verticalCenter;
			anchors.verticalCenterOffset: isNxt? 100 : 80
            width: isNxt? 200 :160
            height:  isNxt? 30 :24
            color: "red"
            radius: isNxt? 16 : 12
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    menuBox.opacity = 0;
                    game.opacity = 1;
					game.newArrow();
					gameScreen.score = 0;
                }

            }

            Text {
                id:newGameText
                color: "#fff"
                anchors {
                    horizontalCenter:parent.horizontalCenter;
                    verticalCenter: parent.verticalCenter;}
                anchors.margins: 10
                text: "New Game"
		        font.family: qfont.regular.name
                font.pointSize: isNxt? 10 : 8            
			}
        }
    }
}
