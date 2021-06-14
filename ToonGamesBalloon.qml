//balloonGame by oepi-loepi

import QtQuick 2.1
import BasicUIControls 1.0
import qb.components 1.0

import "ToonGamesBalloonGameLogic.js" as GameLogic

Screen {
    id: gameScreen
    screenTitle: "Toon Balloon"
    property int dartcounter : 12
	property bool activeMe : false
    property bool screenbroken
	property int score: 0
	property string scoreText : ""
	
	onVisibleChanged: {
		if (visible) {
            activeMe = true
            createBottle.start()
        } else { 
            activeMe = false
        }
    }

    ToonGamesBalloonMenu {
        id: menuBox
        anchors { horizontalCenter: gameScreen.horizontalCenter; verticalCenter: gameScreen.verticalCenter;}
    }

    function randomNumber(from, to) {
        return Math.floor(Math.random() * (to - from + 1) + from);
    }
    
    Rectangle {
        id: game
        width: parent.width
        height: parent.height
        opacity: 0
        focus: true
        
        color: "#00B2FF"

        Image {
            id: background
            anchors.fill: parent
            source: "file:///qmf/qml/apps/toonGames/drawables/toonGamesBalloonsky.jpg"
            fillMode: Image.PreserveAspectCrop
        }

        ToonGamesBalloonToolBar {
            id: toolBar
        }

        Rectangle {
            id: upButton
            x: isNxt? 10: 8
            y: isNxt? 120 : 96
            width: isNxt? 120 :96
            height:  isNxt? 30 :24
            color: "red"
            radius: isNxt? 16 : 12
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    dart.y -= 10
                }
            }

            Text {
                id:upText
                color: "#fff"
                anchors {
                    horizontalCenter:parent.horizontalCenter;
                    verticalCenter: parent.verticalCenter;}
                anchors.margins: isNxt? 10:8
                text: "Up"
                font.family: qfont.regular.name
                font.pixelSize: isNxt? 20 : 16 
            }
        }

        Rectangle {
            id: downButton
            x: isNxt? 10: 8
            y: isNxt? 400 : 320
            width: isNxt? 120 :96
            height:  isNxt? 30 :24
            color: "red"
            radius: isNxt? 16 : 12
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    dart.y += 10
                }
            }

            Text {
                id:downText
                color: "#fff"
                anchors {
                    horizontalCenter:parent.horizontalCenter;
                    verticalCenter: parent.verticalCenter;}
                anchors.margins: isNxt? 10 : 8
                text: "Down"
                font.family: qfont.regular.name
                font.pixelSize: isNxt? 20 : 16 
            }
        }

        Rectangle {
            id: releaseButton
            x: isNxt? 10: 8
            y: isNxt? 300 : 240
            width: isNxt? 120 :96
            height:  isNxt? 60 : 48
            color: "red"
            radius: isNxt? 16 : 12
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (dartcounter > 0){
                        fire.start();
                        dartcounter--;
                        toolBar.dropDart();
                    }
                }
            }


            Text {
                id:releaseText
                color: "#fff"
                anchors {
                    horizontalCenter:parent.horizontalCenter;
                    verticalCenter: parent.verticalCenter;}
                anchors.margins: isNxt? 10 : 8
                text: "Fire"
				font.family: qfont.regular.name
                font.pixelSize: isNxt? 20 : 16 
            }
        }

        function removeBalloon(balloon) {
            GameLogic.balloons.splice(GameLogic.balloons.indexOf(balloon), 1);
        }

        function removeMelon(melon) {
            GameLogic.melons.splice(GameLogic.melons.indexOf(melon), 1);
        }

        function removeBottle(bottle) {
            GameLogic.bottles.splice(GameLogic.bottles.indexOf(bottle), 1);
            createBottle.start()
        }
		
        function newArrow() {
            coolDown.start();
        }

        function getDartPosition() {
            return { x: dart.x, y: dart.y, width: dart.width, height: dart.height }
        }

// generate balloons

        Timer {
            interval:  2000
            repeat: true
            running: activeMe
            onTriggered: {
// limit number of balloons to 5
                if (GameLogic.balloons.length < 5) {
                    var component = Qt.createComponent("ToonGamesBalloonBalloon.qml");
                    var balloon = component.createObject(game);
                    balloon.x = randomNumber(200, game.width - balloon.width);
                    balloon.y = game.height;
                    GameLogic.balloons.push(balloon);
                }
            }
        }

// generate melons

        Timer {
            interval: 8000
            repeat: true
            running: activeMe
            onTriggered: {
// limit number of melons to 1
                if ( GameLogic.melons.length < 1 ) {
                    var component = Qt.createComponent("ToonGamesBalloonMelon.qml");
                    var melon = component.createObject(game);
                    melon.x = randomNumber(200, game.width - melon.width);
                    melon.y = game.height;
                    GameLogic.melons.push(melon);
                }
            }
        }

// bottle, actually bottles and glasses, timer starts after app start and after bottle disappears from screen

        Timer {
            id: createBottle
            interval: 10000
            onTriggered: {
// limit number of bottles to 1 and when screen broken wait some more before repair and new bottle
                if ( GameLogic.bottles.length < 1 ) {
                    screenbroken = false
                    var component = Qt.createComponent("ToonGamesBalloonBottle.qml");
                    var bottle = component.createObject(game);
                    bottle.x = randomNumber(600, game.width - bottle.width);
                    bottle.y = game.height;
                    GameLogic.bottles.push(bottle);
                }
            }
        }

        Image {
            id: dart;
            source: "file:///qmf/qml/apps/toonGames/drawables/toonGamesBalloonDart.png"
            y:  isNxt? 180 :144
        }

        // Dart animations
        Timer { id: coolDown; interval: 10; onTriggered: { dart.x = 0;isNxt? dart.y = 200 + randomNumber(0, 200):dart.y = 160 + randomNumber(0, 160) ; } }

        ParallelAnimation {
            id: fire
            PropertyAnimation { target: dart; property: "x"; duration: 1300; to: game.width }
            PropertyAnimation { target: dart; property: "y"; duration: 1300; to: dart.y + 150; easing.type: Easing.InQuad }
	
		    onStopped:  {if (dartcounter > 0) {
					coolDown.start();
				}else{
					menuBox.opacity = 1;
                    game.opacity = 0;
					gameScreen.scoreText = "Your score: " + gameScreen.score
					dartcounter = 12;
					toolBar.paintDart();
					gameScreen.score = 0;
                    screenbroken = false
				}
			}
        }

        Rectangle {
            id: scoreBar
            width: parent.width; height:  isNxt? 40 :32
            anchors.top: game.top
            z: 5
            color: "transparent"
            Text {
                id: scoreText
                color: "#fff"
                anchors { right: parent.right; verticalCenter: parent.verticalCenter;}
                anchors.rightMargin:  isNxt? 10:8
                text: "Score:" + gameScreen.score
				font.family: qfont.regular.name
                font.pixelSize: isNxt?  25: 20
            }
        }
    }

// when you shoot a bottle your Toon screen breaks and is repaired when next bottle appears

    Rectangle {
        x: isNxt ? 0 : 200
        y: isNxt ? -75 : -50
        Image {
            source: isNxt ? "file:///qmf/qml/apps/toonGames/drawables/toonGamesBalloonbroken_T2.png" 
                          : "file:///qmf/qml/apps/toonGames/drawables/toonGamesBalloonbroken_T1.png"
            visible: screenbroken
        }
    }
}

