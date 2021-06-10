//Balloon by Oepi-Loepi for Toon

import QtQuick 2.1


Item {
    id: melon

    property bool destroyed: false

        width: 240
        height: 240


    Item {
        id: sprite
        property int frame:1

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
            source: "file:///qmf/qml/apps/toonGames/drawables/ToonGamesBalloonWatermelonSpritesheet.png"
            y: 0
            x:-120-(240*sprite.frame)
        }
    }

    Timer {
        id: animation;
        repeat: true;
        interval: 80;
        onTriggered: {
            if (sprite.frame == 9) {
                gameScreen.score += 50;
                animation.stop()
                melon.destroy();
            }
            sprite.frame++;
        }
    }

    function explode() {
        if (!destroyed) {
            sprite.frame = 2;
            animation.start();
        }
        destroyed = true;
    }

    function randomNumber(from, to) {
       return Math.floor(Math.random() * (to - from + 1) + from);
    }

    property int speed: randomNumber(3, 8)

    Timer {
        interval: 50
        running: true
        repeat: true

        onTriggered: {
            melon.y -= melon.speed;

            if (melon.y + melon.height < 0) {
                game.removeMelon(melon);
                melon.destroy();
            }
        }
    }
}
