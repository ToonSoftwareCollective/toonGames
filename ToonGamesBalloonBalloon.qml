//Balloon by Oepi-Loepi for Toon

import QtQuick 2.1

Item {
    id: balloon

    property bool destroyed: false
    property int balloonsize: randomNumber(3,7)
    width: balloonsize * 24
    height: balloonsize * 24

    Item {
        id: sprite
        property int frame: 4

        anchors.centerIn: parent

        height: parent.height
        width: parent.height
        clip: true

        transform: Rotation {
            id: rotator

            origin {
                x: 60
                y: 110
             }
             angle: 0
        }

        SequentialAnimation {
            id: shake
            PropertyAnimation { easing.type: Easing.InQuad; duration: 400; target: rotator; property: "angle"; to: 10 }
            PropertyAnimation { easing.type: Easing.InQuad; duration: 400; target: rotator; property: "angle"; to: -10 }
        }

        Timer {
            running: true
            repeat: true
            interval: 800

            onTriggered: {
                shake.restart();
            }
        }

        Image {
            id: spriteImage
            source: "file:///qmf/qml/apps/toonGames/drawables/toonGamesBalloonSpriteSheet.png"
            y: 0
            x:-120 * balloonsize/5*sprite.frame
            width: 960 *  balloonsize/5
            height:120 * balloonsize/5        }
    }

    Timer {
        id: animation;
        repeat: true;
        interval: 80;
        onTriggered: {
            if (sprite.frame == 7) {
                gameScreen.score += 20;
                animation.stop()
                balloon.destroy();
            }

            sprite.frame++;
        }
    }

    function explode() {
        if (!destroyed) {
            sprite.frame = 5;
            animation.start();
        }
        destroyed = true;
    }

    function randomNumber(from, to) {
       return Math.floor(Math.random() * (to - from + 1) + from);
    }

    property int speed: randomNumber(1, 4)

    Timer {
        interval: 50
        running: true
        repeat: true

        onTriggered: {
            balloon.y -= balloon.speed;

            if (balloon.y + balloon.height < 0) {
                game.removeBalloon(balloon);
                balloon.destroy();
            }
        }
    }
}
