import QtQuick 2.1
import qb.components 1.0

Tile {
    id                          : toonGamesTile
    
    property bool activeMe      : false
    property bool inToDimState  : false

    property string colortxt    : "black"
    property string color0      : "green"
    property string color1      : "red"
    property string color2      : "yellow"
    property string color3      : "lightgrey"
    property string color4      : "cyan"

    property int gameHeight     : toonGamesTile.height / 4
    property int gameWidth      : toonGamesTile.width / 2.5

    property int rotateAngel    : 0
    
    property int removeCounter
    property int removeLimit    : 60

// ---------------------------------------------------------------------
    
    onVisibleChanged: {
        if (visible) {
            removeCounter = 0
            activeMe = true
        } else { 
            activeMe = false
        }
    }

// --------------------------------------------------------------- Timer

    Timer {
        id                      : controlTimer
        interval                : dimState ? 2000 : 100;
        running                 : dimState || activeMe
        repeat                  : true
        onTriggered             : rotateImage()
    }  

// ---------------------------------------------------------------------

    function rotateImage() {
    
        if (dimState) {
            if ( !inToDimState ) {
                rotateAngel = 30
                inToDimState = true
            }
            activeMe = true
            removeCounter = 0
         } else { 
            inToDimState = false
            if ( removeCounter <= removeLimit )  {
                removeCounter = removeCounter + 1
            } else {
                activeMe = false
            }
         }
        rotateAngel = ( rotateAngel - ( (dimState) ? 120 : 1 ) ) % 360
    }


// --------------------------------------------------- Game buttons

    YaLabel {
        id                      : game1
        buttonText              : "Tic Tac Toe"
        height                  : gameHeight
        width                   : gameWidth
        buttonActiveColor       : buttonSelectedColor
        buttonHoverColor        : buttonSelectedColor
        buttonSelectedColor     : color3
        selected                : true
        enabled                 : true
        textColor               : colortxt
        anchors {
            top                 : parent.top
            right               : parent.horizontalCenter
        }
        onClicked: {
            activeMe = false
            stage.openFullscreen(app.toonGamesTicTacToeUrl);
        }
        visible                 : !dimState
    }

    YaLabel {
        id                      : game2
        buttonText              : "Slide"
        height                  : gameHeight
        width                   : gameWidth
        buttonActiveColor       : buttonSelectedColor
        buttonHoverColor        : buttonSelectedColor
        buttonSelectedColor     : color3
        selected                : true
        enabled                 : true
        textColor               : colortxt
        anchors {
            top                 : parent.top
            left                : parent.horizontalCenter
        }
        onClicked: {
            activeMe = false
            stage.openFullscreen(app.toonGamesSlideUrl);
        }
        visible                 : !dimState
    }

    YaLabel {
        id                      : game3
        buttonText              : "Memory"
        height                  : gameHeight
        width                   : gameWidth
        buttonActiveColor       : buttonSelectedColor
        buttonHoverColor        : buttonSelectedColor
        buttonSelectedColor     : color3
        selected                : true
        enabled                 : true
        textColor               : colortxt
        anchors {
            top                 : game1.bottom
            left                : game1.left
        }
        onClicked: {
            activeMe = false
            stage.openFullscreen(app.toonGamesMemoryUrl);
        }
        visible                 : !dimState
    }

    YaLabel {
        id                      : game4
        buttonText              : "4 In A Row"
        height                  : gameHeight
        width                   : gameWidth
        buttonActiveColor       : buttonSelectedColor
        buttonHoverColor        : buttonSelectedColor
        buttonSelectedColor     : color3
        selected                : true
        enabled                 : true
        textColor               : colortxt
        anchors {
            top                 : game2.bottom
            left                : game2.left
        }
        onClicked: {
            activeMe = false
            stage.openFullscreen(app.toonGames4InARowUrl);
        }
        visible                 : !dimState
    }

    YaLabel {
        id                      : game5
        buttonText              : "Hangman"
        height                  : gameHeight
        width                   : gameWidth
        buttonActiveColor       : buttonSelectedColor
        buttonHoverColor        : buttonSelectedColor
        buttonSelectedColor     : color3
        selected                : true
        enabled                 : true
        textColor               : colortxt
        anchors {
            top                 : game3.bottom
            left                : game3.left
        }
        onClicked: {
            activeMe = false
            stage.openFullscreen(app.toonGamesHangmanUrl);
        }
        visible                 : !dimState
    }

    YaLabel {
        id                      : game6
        buttonText              : "Mines"
        height                  : gameHeight
        width                   : gameWidth
        buttonActiveColor       : buttonSelectedColor
        buttonHoverColor        : buttonSelectedColor
        buttonSelectedColor     : color3
        selected                : true
        enabled                 : true
        textColor               : colortxt
        anchors {
            top                 : game4.bottom
            left                : game4.left
        }
        onClicked: {
            activeMe = false
            stage.openFullscreen(app.toonGamesMinesUrl);
        }
        visible                 : !dimState
    }

    YaLabel {
        id                      : game7
        buttonText              : "Numbers"
        height                  : gameHeight
        width                   : isNxt ? gameWidth : gameWidth * 2
        buttonActiveColor       : buttonSelectedColor
        buttonHoverColor        : buttonSelectedColor
        buttonSelectedColor     : color3
        selected                : true
        enabled                 : true
        textColor               : colortxt
        anchors {
            top                 : game5.bottom
            left                : game5.left
        }
        onClicked: {
            activeMe = false
            stage.openFullscreen(app.toonGamesNumbersUrl);
        }
        visible                 : !dimState
    }

    YaLabel {
        id                      : game8
        buttonText              : "Balloon"
        height                  : gameHeight
        width                   : gameWidth
        buttonActiveColor       : buttonSelectedColor
        buttonHoverColor        : buttonSelectedColor
        buttonSelectedColor     : color3
        selected                : true
        enabled                 : true
        textColor               : colortxt
        anchors {
            top                 : game6.bottom
            left                : game6.left
        }
        onClicked: {
            activeMe = false
            stage.openFullscreen(app.toonGamesBalloonUrl);
        }
        visible                 : isNxt ? !dimState : false
    }

/*

// when an odd number of games is on the tile I will use this to make it even ;-)

    YaLabel {
        id                      : gameinfo
        buttonText              : "Info"
        height                  : gameHeight
        width                   : gameWidth
        buttonActiveColor       : buttonSelectedColor
        buttonHoverColor        : buttonSelectedColor
        buttonSelectedColor     : color3
        selected                : true
        enabled                 : true
        textColor               : colortxt
        anchors {
            top                 : game8.bottom
            left                : game8.left
        }
        onClicked: {
            activeMe = false
            stage.openFullscreen(app.toonGamesInfoUrl);
        }
        visible                 : !dimState
    }
*/

// ---------------------------------------------- rotating image on tile

// has to be at the end of the qml file to be on top of the buttons

    Image {
        id                      : imgGames
        anchors {
            horizontalCenter    : toonGamesTile.horizontalCenter
            verticalCenter      : toonGamesTile.verticalCenter
          }        
        source                  : "file:///qmf/qml/apps/toonGames/drawables/toonGames.png"
        height                  : toonGamesTile.height / 1.1
        width                   : toonGamesTile.height / 1.1
        transform               : Rotation { origin.x: toonGamesTile.height / 2 / 1.1 ; origin.y: toonGamesTile.height / 2 / 1.1 ; axis { x: 0; y: 0; z: 1 } angle: rotateAngel }
        visible                 : ( removeCounter < removeLimit )
    }

}
