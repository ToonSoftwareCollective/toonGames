//Balloon by Oepi-Loepi for Toon

import QtQuick 2.1

Item {
    id: bottle

// ---------------------------------------------------------------------
//  the next disables collision detect while exploding
    property bool exploding : false
// ---------------------------------------------------------------------

    property bool destroyed: false
    property int bottlesize: randomNumber(3,7)
    width: bottlesize * 24
    height: bottlesize * 24

    
    Item {
        id: sprite
        property int frame: randomNumber(0,7)

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
// only shake on Toon 2
            running: isNxt
            repeat: true
            interval: 800

            onTriggered: {
                shake.restart();
            }
        }

        Image {
            id: spriteImage
            source: "file:///qmf/qml/apps/toonGames/drawables/toonGamesBalloonWineSpritesheet.png"
            y: 0
            x:-120 * bottlesize/5*sprite.frame
            width: 960 *  bottlesize/5
            height:120 * bottlesize/5        }
    }

    Timer {
        id: animation;
        repeat: true;
        interval: 80;
        onTriggered: {
            if (sprite.frame == 7) {
                gameScreen.score += 20;
                animation.stop()
                game.removeBottle(bottle);
                bottle.destroy();
            }

            sprite.frame++;
        }
    }

    function explode() {
        gameScreen.score -= 5;
        gameScreen.screenbroken = true
        bottlesize = bottlesize / 2
        speed = speed * 5
    }

    function randomNumber(from, to) {
       return Math.floor(Math.random() * (to - from + 1) + from);
    }

// move a little bit faster on Toon 1 because Toon 1 is slower
    property int speed: isNxt ? randomNumber(1, 4) : randomNumber(1, 4) * 2

    Timer {
        interval: 50
        running: true
        repeat: true

        onTriggered: {
            bottle.y -= bottle.speed;

            if (bottle.y + bottle.height < 0) {
                game.removeBottle(bottle);
                bottle.destroy();
            }

            if (!exploding) {

                var dart = game.getDartPosition();

//              if       dart tip passed left side bottle                 AND  dart tail before right side bottle
//                  AND  dart middle below bottle top                     AND  dart middle above bolloon bottom

                var bottleHeartX = bottle.x + bottle.width  / 2
                var bottleHeartY = bottle.y + bottle.height / 2

                var hitRadius = bottle.width / 2

                if     ( ( ( dart.x + dart.width )          > ( bottleHeartX - hitRadius ) )  && (   dart.x                         < ( bottleHeartX + hitRadius ) ) ) {
                    if ( ( ( dart.y + ( dart.height / 2 ) ) > ( bottleHeartY - hitRadius ) )  && ( ( dart.y + ( dart.height / 2 ) ) < ( bottleHeartY + hitRadius ) ) ) {
                        exploding = true
                        explode()
                    }
                }
            }
        }
    }
}
