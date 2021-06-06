/*

Memory

Version 1.0.0 
Play Mines

*/

import QtQuick 2.1
import qb.components 1.0
import BasicUIControls 1.0

Screen {
    id                          : toonGamesMines
    screenTitle                 : qsTr(me)

// ---------------------------------------------------------------------

    property string me          : "Toon Mines (flag 10th mine to win, hit bomb to lose)"

    property string colortxt    : "black"
    property string color0      : "green"
    property string color1      : "red"
    property string color2      : "yellow"
    property string color3      : "lightgrey"
    property string color4      : "cyan"
    property string color5      : "lime"

    property string player1Name : 'Player 1'
    property string player2Name : 'Player 2'

    property int playerHeight   : isNxt ? 40 : 32
    property int playerWidth    : isNxt ? 225 : 180

    property int winnerHeight   : isNxt ? 75 : 60
    property int playModeHeight : isNxt ? 75 : 60
    property int playModeWidth  : isNxt ? 100 : 80

    property int margin         : isNxt ? 30 : 24

    property string activeColor : color3
    property string hoverColor  : color3
    property string selectedColor : color5

    property int player1Score   : 0
    property int player2Score   : 0

    property bool player1Active : true
    property bool player2Active : false
    property bool player1Won    : false
    property bool player2Won    : false

    property bool initialised   : false

    property int keyHeight      : isNxt ? 40 : 32
    property int keyWidth       : isNxt ? 40 : 32

    property int playFieldSize  : isNxt ? 55 : 44

    property variant bombs
    property variant flags
    property variant neighbours

    property string playMode // 'Guess' 'Flag' 'Clear' 'Maybe'

// ---------------------------------------------------------------------

    onVisibleChanged: {
        if (visible) {
            if (! initialised ) {
                player1.buttonText = player1Name
                player2.buttonText = player2Name
                resetscores()
                initialised = true
// testing
//                player1Counter = 11
//                player2Counter = 11
//                player1Active = true
//                player2Active = true
//                player1Won = true
//                player2Won = true
            }
        }
    }

// ---------------------------------------------------------------------

    function log(tolog) {
        console.log(me + ' games : ' + tolog.toString())
    }

// ---------------------------------------------------------------------

    function resetscores() {
        resetgame()
        player1Score = 0
        player2Score = 0
    }

// ---------------------------------------------------------------------

    function resetgame() {

        resetGame.buttonText = 'New Game'

//        keyboardActive = false
//        secretsSet = false

        f00.buttonText = "" ; f01.buttonText = "" ; f02.buttonText = "" ; f03.buttonText = "" ; f04.buttonText = "" ; f05.buttonText = "" ; f06.buttonText = "" ; f07.buttonText = "" ;
        f10.buttonText = "" ; f11.buttonText = "" ; f12.buttonText = "" ; f13.buttonText = "" ; f14.buttonText = "" ; f15.buttonText = "" ; f16.buttonText = "" ; f17.buttonText = "" ;
        f20.buttonText = "" ; f21.buttonText = "" ; f22.buttonText = "" ; f23.buttonText = "" ; f24.buttonText = "" ; f25.buttonText = "" ; f26.buttonText = "" ; f27.buttonText = "" ;
        f30.buttonText = "" ; f31.buttonText = "" ; f32.buttonText = "" ; f33.buttonText = "" ; f34.buttonText = "" ; f35.buttonText = "" ; f36.buttonText = "" ; f37.buttonText = "" ;
        f40.buttonText = "" ; f41.buttonText = "" ; f42.buttonText = "" ; f43.buttonText = "" ; f44.buttonText = "" ; f45.buttonText = "" ; f46.buttonText = "" ; f47.buttonText = "" ;
        f50.buttonText = "" ; f51.buttonText = "" ; f52.buttonText = "" ; f53.buttonText = "" ; f54.buttonText = "" ; f55.buttonText = "" ; f56.buttonText = "" ; f57.buttonText = "" ;
        f60.buttonText = "" ; f61.buttonText = "" ; f62.buttonText = "" ; f63.buttonText = "" ; f64.buttonText = "" ; f65.buttonText = "" ; f66.buttonText = "" ; f67.buttonText = "" ;
        f70.buttonText = "" ; f71.buttonText = "" ; f72.buttonText = "" ; f73.buttonText = "" ; f74.buttonText = "" ; f75.buttonText = "" ; f76.buttonText = "" ; f77.buttonText = "" ;

        bombs = [ [ " ", " ", " ", " ", " ", " ", " ", " " ] ,
                  [ " ", " ", " ", " ", " ", " ", " ", " " ] ,
                  [ " ", " ", " ", " ", " ", " ", " ", " " ] ,
                  [ " ", " ", " ", " ", " ", " ", " ", " " ] ,
                  [ " ", " ", " ", " ", " ", " ", " ", " " ] ,
                  [ " ", " ", " ", " ", " ", " ", " ", " " ] ,
                  [ " ", " ", " ", " ", " ", " ", " ", " " ] ,
                  [ " ", " ", " ", " ", " ", " ", " ", " " ] ]
        flags = [ [ " ", " ", " ", " ", " ", " ", " ", " " ] ,
                  [ " ", " ", " ", " ", " ", " ", " ", " " ] ,
                  [ " ", " ", " ", " ", " ", " ", " ", " " ] ,
                  [ " ", " ", " ", " ", " ", " ", " ", " " ] ,
                  [ " ", " ", " ", " ", " ", " ", " ", " " ] ,
                  [ " ", " ", " ", " ", " ", " ", " ", " " ] ,
                  [ " ", " ", " ", " ", " ", " ", " ", " " ] ,
                  [ " ", " ", " ", " ", " ", " ", " ", " " ] ]
        neighbours = [ [ -1, -1, -1, -1, -1, -1, -1, -1 ] ,
                  [ -1, -1, -1, -1, -1, -1, -1, -1 ] ,
                  [ -1, -1, -1, -1, -1, -1, -1, -1 ] ,
                  [ -1, -1, -1, -1, -1, -1, -1, -1 ] ,
                  [ -1, -1, -1, -1, -1, -1, -1, -1 ] ,
                  [ -1, -1, -1, -1, -1, -1, -1, -1 ] ,
                  [ -1, -1, -1, -1, -1, -1, -1, -1 ] ,
                  [ -1, -1, -1, -1, -1, -1, -1, -1 ] ]
        var bombCounter = 0
        while (bombCounter < 10) {
            var x = Math.floor(Math.random() * 8);
            var y = Math.floor(Math.random() * 8);
//            log('Try bomb x: '+x+' y: '+y)
            if (bombs[x][y] != "B") {
//                log('Set bomb x: '+x+' y: '+y)
                bombs[x][y] = "B"
                bombCounter = bombCounter + 1
            }
        }
//        log('Bombs : ' + bombs)
        player1Won = false
        player2Won = false

        playMode = 'Guess'

//        player1Go.buttonText = 'Guess'
//        player2Go.buttonText = 'Guess'

//        winner = false

//        player1Counter = 0
//        player2Counter = 0

//        if (player1Active)  { player1Go.buttonText = "Click\n  me" }
//        else                { player2Go.buttonText = "Click\n  me" }
    }

// ---------------------------------------------------------------------

    function fieldClicked ( x , y ) {
        if (!player1Won && !player2Won) {
//            log('fieldClicked mode: '+playMode+' x: ' + x + '  y: '+ y)
            resetGame.buttonText = 'Reset Game'
            switch(playMode) {
            case 'Clear' :
                flags[x][y] = " "
                setMarker(x , y, " ")
                break;
            case 'Flag' :
                flags[x][y] = "B"
                setMarker(x , y, "F")
                if (bombs.toString() ==  flags.toString()) {
                    player1Won  = player1Active
                    player2Won  = player2Active
                    if (player1Won) { player1Score = player1Score + 1 }
                               else { player2Score = player2Score + 1 }
                    resetGame.buttonText = 'New Game'
                }
                break;
            case 'Maybe' :
                flags[x][y] = "?"
                setMarker(x , y, "?")
                break
            case 'Guess' :
                if (bombs[x][y] == "B") {
//                    log('whoops! ')
                    player1Won  = player2Active
                    player2Won  = player1Active
                    if (player1Won) { player1Score = player1Score + 1 }
                               else { player2Score = player2Score + 1 }
                    resetGame.buttonText = 'New Game'
                    for (var bx=0 ; bx <=7 ; bx++ ) {
                        for (var by = 0 ; by <=7 ; by++) {
                            if (bombs[bx][by] == "B" && flags[bx][by] != "B" ) {
                                setMarker(bx, by, "B")
                            }
                            if (bombs[bx][by] != "B" && flags[bx][by] == "B" ) {
                                setMarker(bx, by, "X")
                            }
                        }
                    }
                } else {
//                    log('lucky ! ')
// if -1 field was not played yet
                    if ( neighbours[x][y] == -1 ) {
                        player2Active =player1Active
                        player1Active =!player1Active
                        checkNeighbours( x , y )
//                        log('bombs : '+bombs)
//                        log('neighbours : '+neighbours)
                    }
                }
                break;
            }
        }
    }

// ---------------------------------------------------------------------

    function checkNeighbours( x , y ) {
//        log('checkNeighbours 1 x: '+ x + '  y: '+y+'  x,y '+neighbours[x][y])
        neighbours[x][y] = 0
//        log('checkNeighbours 2 x: '+ x + '  y: '+y+'  x,y '+neighbours[x][y])
        var xMin = Math.max( 0, x - 1 )
        var xMax = Math.min( 7, x + 1 )
        var yMin = Math.max( 0, y - 1 )
        var yMax = Math.min( 7, y + 1 )
//        log(' xMin: ' +xMin + ' xMax: ' + xMax + ' yMin: ' + yMin + ' yMax: ' + yMax)
        for ( var xi = xMin ; xi <= xMax; xi++ ) {
            for ( var yi = yMin ; yi <= yMax; yi++ ) {
                if (bombs[xi][yi] == "B") { neighbours[x][y] = neighbours[x][y] + 1 }
//                log('checkNeighbours xi: ' + xi + ' yi: ' +yi + ' x: '+ x + '  y: '+y+'  x,y '+neighbours[x][y])
            }
        }
//        log('checkNeighbours 3 x: '+ x + '  y: '+y+'  x,y '+neighbours[x][y])
        setMarker( x, y , neighbours[x][y] )
    }

// ---------------------------------------------------------------------

    function setMarker( x , y , marker ) {

        switch(x) {
            case 0: switch(y ) {
                    case 0 : f00.buttonText = marker ; break ;
                    case 1 : f01.buttonText = marker ; break ;
                    case 2 : f02.buttonText = marker ; break ;
                    case 3 : f03.buttonText = marker ; break ;
                    case 4 : f04.buttonText = marker ; break ;
                    case 5 : f05.buttonText = marker ; break ;
                    case 6 : f06.buttonText = marker ; break ;
                    case 7 : f07.buttonText = marker ; break ;
                    } ;
                    break;
            case 1: switch(y ) {
                    case 0 : f10.buttonText = marker ; break ;
                    case 1 : f11.buttonText = marker ; break ;
                    case 2 : f12.buttonText = marker ; break ;
                    case 3 : f13.buttonText = marker ; break ;
                    case 4 : f14.buttonText = marker ; break ;
                    case 5 : f15.buttonText = marker ; break ;
                    case 6 : f16.buttonText = marker ; break ;
                    case 7 : f17.buttonText = marker ; break ;
                    } ;
                    break;
            case 2: switch(y ) {
                    case 0 : f20.buttonText = marker ; break ;
                    case 1 : f21.buttonText = marker ; break ;
                    case 2 : f22.buttonText = marker ; break ;
                    case 3 : f23.buttonText = marker ; break ;
                    case 4 : f24.buttonText = marker ; break ;
                    case 5 : f25.buttonText = marker ; break ;
                    case 6 : f26.buttonText = marker ; break ;
                    case 7 : f27.buttonText = marker ; break ;
                    } ;
                    break;
            case 3: switch(y ) {
                    case 0 : f30.buttonText = marker ; break ;
                    case 1 : f31.buttonText = marker ; break ;
                    case 2 : f32.buttonText = marker ; break ;
                    case 3 : f33.buttonText = marker ; break ;
                    case 4 : f34.buttonText = marker ; break ;
                    case 5 : f35.buttonText = marker ; break ;
                    case 6 : f36.buttonText = marker ; break ;
                    case 7 : f37.buttonText = marker ; break ;
                    } ;
                    break;
            case 4: switch(y ) {
                    case 0 : f40.buttonText = marker ; break ;
                    case 1 : f41.buttonText = marker ; break ;
                    case 2 : f42.buttonText = marker ; break ;
                    case 3 : f43.buttonText = marker ; break ;
                    case 4 : f44.buttonText = marker ; break ;
                    case 5 : f45.buttonText = marker ; break ;
                    case 6 : f46.buttonText = marker ; break ;
                    case 7 : f47.buttonText = marker ; break ;
                    } ;
                    break;
            case 5: switch(y ) {
                    case 0 : f50.buttonText = marker ; break ;
                    case 1 : f51.buttonText = marker ; break ;
                    case 2 : f52.buttonText = marker ; break ;
                    case 3 : f53.buttonText = marker ; break ;
                    case 4 : f54.buttonText = marker ; break ;
                    case 5 : f55.buttonText = marker ; break ;
                    case 6 : f56.buttonText = marker ; break ;
                    case 7 : f57.buttonText = marker ; break ;
                    } ;
                    break;
            case 6: switch(y ) {
                    case 0 : f60.buttonText = marker ; break ;
                    case 1 : f61.buttonText = marker ; break ;
                    case 2 : f62.buttonText = marker ; break ;
                    case 3 : f63.buttonText = marker ; break ;
                    case 4 : f64.buttonText = marker ; break ;
                    case 5 : f65.buttonText = marker ; break ;
                    case 6 : f66.buttonText = marker ; break ;
                    case 7 : f67.buttonText = marker ; break ;
                    } ;
                    break;
            case 7: switch(y ) {
                    case 0 : f70.buttonText = marker ; break ;
                    case 1 : f71.buttonText = marker ; break ;
                    case 2 : f72.buttonText = marker ; break ;
                    case 3 : f73.buttonText = marker ; break ;
                    case 4 : f74.buttonText = marker ; break ;
                    case 5 : f75.buttonText = marker ; break ;
                    case 6 : f76.buttonText = marker ; break ;
                    case 7 : f77.buttonText = marker ; break ;
                    } ;
                    break;
        }
    }

// ----------------------------------------------- player name functions

    function savePlayer1Name(text) {
        if (text) {
            player1Name = text.trim();
            player1.buttonText = player1Name
        }
    }

    function savePlayer2Name(text) {
        if (text) {
            player2Name = text.trim();
            player2.buttonText = player2Name
        }
    }


// ------------------------------------------------------ main rectangle

    Rectangle {

        height                  : parent.height - 20
        width                   : parent.width - 40
        anchors {
            horizontalCenter    : parent.horizontalCenter
            verticalCenter      : parent.verticalCenter
        }
        color                   : color0

// -------------------------------------------------- surrounding fields

        YaLabel {
            id                  : player1
            buttonText          : ""
            height              : playerHeight
            width               : playerWidth
            buttonActiveColor   : color3
            buttonHoverColor    : color3
            buttonSelectedColor : color3
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : parent.top
                left            : parent.left
                topMargin       : margin
                leftMargin      : margin
            }
            onClicked: {
                qkeyboard.open("The name for Player 1", player1.buttonText, savePlayer1Name)
            }
        }

        YaLabel {
            id                  : player1Guess
            buttonText          : "Guess"
            height              : playModeHeight
            width               : playModeWidth
            buttonActiveColor   : (playMode == 'Guess' ) ? color1 : color5
            buttonHoverColor    : (playMode == 'Guess' ) ? color1 : color5
            buttonSelectedColor : (playMode == 'Guess' ) ? color1 : color5
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : player1.bottom
                horizontalCenter: player1.horizontalCenter
                topMargin       : margin
            }
            onClicked: {
                playMode = 'Guess'
            }
            visible             : player1Active
        }

        YaLabel {
            id                  : player1Flag
            buttonText          : "Mark\nFlag"
            height              : playModeHeight
            width               : playModeWidth
            buttonActiveColor   : (playMode == 'Flag' ) ? color1 : color5
            buttonHoverColor    : (playMode == 'Flag' ) ? color1 : color5
            buttonSelectedColor : (playMode == 'Flag' ) ? color1 : color5
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : player1Guess.bottom
                right           : player1.horizontalCenter
                topMargin       : margin / 2
                rightMargin     : margin / 2
            }
            onClicked: {
                playMode = 'Flag'
            }
            visible             : player1Active
        }

        YaLabel {
            id                  : player1Maybe
            buttonText          : "Mark\nMaybe"
            height              : playModeHeight
            width               : playModeWidth
            buttonActiveColor   : (playMode == 'Maybe' ) ? color1 : color5
            buttonHoverColor    : (playMode == 'Maybe' ) ? color1 : color5
            buttonSelectedColor : (playMode == 'Maybe' ) ? color1 : color5
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : player1Guess.bottom
                left            : player1.horizontalCenter
                topMargin       : margin / 2
                leftMargin      : margin / 2
            }
            onClicked: {
                playMode = 'Maybe'
            }
            visible             : player1Active
        }

        YaLabel {
            id                  : player1Clear
            buttonText          : "Clear\nMark"
            height              : playModeHeight
            width               : playModeWidth
            buttonActiveColor   : (playMode == 'Clear' ) ? color1 : color5
            buttonHoverColor    : (playMode == 'Clear' ) ? color1 : color5
            buttonSelectedColor : (playMode == 'Clear' ) ? color1 : color5
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : player1Flag.bottom
                horizontalCenter: player1.horizontalCenter
                topMargin       : margin / 2
            }
            onClicked: {
                playMode = 'Clear'
            }
            visible             : player1Active
        }

        YaLabel {
            id                  : player1won
            buttonText          : "Winner ! "
            height              : winnerHeight
            width               : playerWidth
            buttonActiveColor   : color1
            buttonHoverColor    : color1
            buttonSelectedColor : color1
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : resetScores.top
                horizontalCenter: resetScores.horizontalCenter
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 50 : 40
            visible             : player1Won
        }

        Text {
            id                  : score1
            text                : player1Score
            anchors {
                bottom          : resetScores.top
                horizontalCenter: resetScores.horizontalCenter
            }
            font.pixelSize      : isNxt ? 50 : 40
            visible             : !player1Won
        }

        YaLabel {
            id                  : player2
            buttonText          : ""
            height              : playerHeight
            width               : playerWidth
            buttonActiveColor   : color3
            buttonHoverColor    : color3
            buttonSelectedColor : color3
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : parent.top
                right           : parent.right
                topMargin       : margin
                rightMargin     : margin
            }
            onClicked: {
                qkeyboard.open("The name for Player 2", player2.buttonText, savePlayer2Name)
            }
        }

        YaLabel {
            id                  : player2Guess
            buttonText          : "Guess"
            height              : playModeHeight
            width               : playModeWidth
            buttonActiveColor   : (playMode == 'Guess' ) ? color2 : color5
            buttonHoverColor    : (playMode == 'Guess' ) ? color2 : color5
            buttonSelectedColor : (playMode == 'Guess' ) ? color2 : color5
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : player2.bottom
                horizontalCenter: player2.horizontalCenter
                topMargin       : margin
            }
            onClicked: {
                playMode = 'Guess'
            }
            visible             : player2Active
        }

        YaLabel {
            id                  : player2Flag
            buttonText          : "Mark\nFlag"
            height              : playModeHeight
            width               : playModeWidth
            buttonActiveColor   : (playMode == 'Flag' ) ? color2 : color5
            buttonHoverColor    : (playMode == 'Flag' ) ? color2 : color5
            buttonSelectedColor : (playMode == 'Flag' ) ? color2 : color5
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : player2Guess.bottom
                right           : player2.horizontalCenter
                topMargin       : margin / 2
                rightMargin     : margin / 2
            }
            onClicked: {
                playMode = 'Flag'
            }
            visible             : player2Active
        }

        YaLabel {
            id                  : player2Maybe
            buttonText          : "Mark\nMaybe"
            height              : playModeHeight
            width               : playModeWidth
            buttonActiveColor   : (playMode == 'Maybe' ) ? color2 : color5
            buttonHoverColor    : (playMode == 'Maybe' ) ? color2 : color5
            buttonSelectedColor : (playMode == 'Maybe' ) ? color2 : color5
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : player2Guess.bottom
                left            : player2.horizontalCenter
                topMargin       : margin / 2
                leftMargin      : margin / 2
            }
            onClicked: {
                playMode = 'Maybe'
            }
            visible             : player2Active
        }

        YaLabel {
            id                  : player2Clear
            buttonText          : "Clear\nMark"
            height              : playModeHeight
            width               : playModeWidth
            buttonActiveColor   : (playMode == 'Clear' ) ? color2 : color5
            buttonHoverColor    : (playMode == 'Clear' ) ? color2 : color5
            buttonSelectedColor : (playMode == 'Clear' ) ? color2 : color5
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : player2Flag.bottom
                horizontalCenter: player2.horizontalCenter
                topMargin       : margin / 2
            }
            onClicked: {
                playMode = 'Clear'
            }
            visible             : player2Active
        }

        YaLabel {
            id                  : player2won
            buttonText          : "Winner ! "
            height              : winnerHeight
            width               : playerWidth
            buttonActiveColor   : color2
            buttonHoverColor    : color2
            buttonSelectedColor : color2
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : resetGame.top
                horizontalCenter: resetGame.horizontalCenter
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 50 : 40
            visible             : player2Won
        }

        Text {
            id : score2
            text : player2Score
            anchors {
                bottom          : resetGame.top
                horizontalCenter: resetGame.horizontalCenter
            }
            font.pixelSize      : isNxt ? 50 : 40
            visible             : !player2Won
        }

        YaLabel {
            id                  : resetScores
            buttonText          : "Reset Scores"
            height              : playerHeight
            width               : playerWidth
            buttonActiveColor   : color3
            buttonHoverColor    : color3
            buttonSelectedColor : color3
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : parent.bottom
                left            : parent.left
                bottomMargin    : margin
                leftMargin      : margin
            }
            onClicked: {
                resetscores()
            }
        }

        YaLabel {
            id                  : resetGame
            buttonText          : "Reset Game"
            height              : playerHeight
            width               : playerWidth
            buttonActiveColor   : color3
            buttonHoverColor    : color3
            buttonSelectedColor : color3
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : parent.bottom
                right           : parent.right
                bottomMargin    : margin
                rightMargin     : margin
            }
            onClicked: {
                resetgame()
            }
        }

// ------------------------------------------------------------ column 0

        YaLabel {
            id                  : f07
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f06.top
                right           : f06.right
            }
            onClicked: {
                fieldClicked(0, 7)
            }
        }

        YaLabel {
            id                  : f06
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f05.top
                right           : f05.right
            }
            onClicked: {
                fieldClicked(0, 6)
            }
        }

        YaLabel {
            id                  : f05
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f04.top
                right           : f04.right
            }
            onClicked: {
                fieldClicked(0, 5)
            }
        }

        YaLabel {
            id                  : f04
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f03.top
                right           : f03.right
            }
            onClicked: {
                fieldClicked(0, 4)
            }
        }

        YaLabel {
            id                  : f03
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f02.top
                right           : f02.right
            }
            onClicked: {
                fieldClicked(0, 3)
            }
        }

        YaLabel {
            id                  : f02
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f01.top
                right           : f01.right
            }
            onClicked: {
                fieldClicked(0, 2)
            }
        }

        YaLabel {
            id                  : f01
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f00.top
                right           : f00.right
            }
            onClicked: {
                fieldClicked(0, 1)
            }
        }

        YaLabel {
            id                  : f00
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : f10.top
                right           : f10.left
            }
            onClicked: {
                fieldClicked(0, 0)
            }
        }

// ------------------------------------------------------------ column 1

        YaLabel {
            id                  : f17
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f16.top
                right           : f16.right
            }
            onClicked: {
                fieldClicked(1, 7)
            }
        }

        YaLabel {
            id                  : f16
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f15.top
                right           : f15.right
            }
            onClicked: {
                fieldClicked(1, 6)
            }
        }

        YaLabel {
            id                  : f15
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f14.top
                right           : f14.right
            }
            onClicked: {
                fieldClicked(1, 5)
            }
        }

        YaLabel {
            id                  : f14
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f13.top
                right           : f13.right
            }
            onClicked: {
                fieldClicked(1, 4)
            }
        }

        YaLabel {
            id                  : f13
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f12.top
                right           : f12.right
            }
            onClicked: {
                fieldClicked(1, 3)
            }
        }

        YaLabel {
            id                  : f12
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f11.top
                right           : f11.right
            }
            onClicked: {
                fieldClicked(1, 2)
            }
        }

        YaLabel {
            id                  : f11
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f10.top
                right           : f10.right
            }
            onClicked: {
                fieldClicked(1, 1)
            }
        }

        YaLabel {
            id                  : f10
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : f20.top
                right           : f20.left
            }
            onClicked: {
                fieldClicked(1, 0)
            }
        }

// ------------------------------------------------------------ column 2

        YaLabel {
            id                  : f27
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f26.top
                right           : f26.right
            }
            onClicked: {
                fieldClicked(2, 7)
            }
        }

        YaLabel {
            id                  : f26
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f25.top
                right           : f25.right
            }
            onClicked: {
                fieldClicked(2, 6)
            }
        }

        YaLabel {
            id                  : f25
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f24.top
                right           : f24.right
            }
            onClicked: {
                fieldClicked(2, 5)
            }
        }

        YaLabel {
            id                  : f24
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f23.top
                right           : f23.right
            }
            onClicked: {
                fieldClicked(2, 4)
            }
        }

        YaLabel {
            id                  : f23
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f22.top
                right           : f22.right
            }
            onClicked: {
                fieldClicked(2, 3)
            }
        }

        YaLabel {
            id                  : f22
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f21.top
                right           : f21.right
            }
            onClicked: {
                fieldClicked(2, 2)
            }
        }

        YaLabel {
            id                  : f21
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f20.top
                right           : f20.right
            }
            onClicked: {
                fieldClicked(2, 1)
            }
        }

        YaLabel {
            id                  : f20
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : f30.top
                right           : f30.left
            }
            onClicked: {
                fieldClicked(2, 0)
            }
        }

// ------------------------------------------------------------ column 3

        YaLabel {
            id                  : f37
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f36.top
                right           : f36.right
            }
            onClicked: {
                fieldClicked(3, 7)
            }
        }

        YaLabel {
            id                  : f36
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f35.top
                right           : f35.right
            }
            onClicked: {
                fieldClicked(3, 6)
            }
        }

        YaLabel {
            id                  : f35
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f34.top
                right           : f34.right
            }
            onClicked: {
                fieldClicked(3, 5)
            }
        }

        YaLabel {
            id                  : f34
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f33.top
                right           : f33.right
            }
            onClicked: {
                fieldClicked(3, 4)
            }
        }

        YaLabel {
            id                  : f33
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f32.top
                right           : f32.right
            }
            onClicked: {
                fieldClicked(3, 3)
            }
        }

        YaLabel {
            id                  : f32
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f31.top
                right           : f31.right
            }
            onClicked: {
                fieldClicked(3, 2)
            }
        }

        YaLabel {
            id                  : f31
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f30.top
                right           : f30.right
            }
            onClicked: {
                fieldClicked(3, 1)
            }
        }

        YaLabel {
            id                  : f30
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : parent.bottom
                bottomMargin    : margin
                right           : parent.horizontalCenter
            }
            onClicked: {
                fieldClicked(3, 0)
            }
        }

// ------------------------------------------------------------ column 4

        YaLabel {
            id                  : f47
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f46.top
                right           : f46.right
            }
            onClicked: {
                fieldClicked(4, 7)
            }
        }

        YaLabel {
            id                  : f46
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f45.top
                right           : f45.right
            }
            onClicked: {
                fieldClicked(4, 6)
            }
        }

        YaLabel {
            id                  : f45
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f44.top
                right           : f44.right
            }
            onClicked: {
                fieldClicked(4, 5)
            }
        }

        YaLabel {
            id                  : f44
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f43.top
                right           : f43.right
            }
            onClicked: {
                fieldClicked(4, 4)
            }
        }

        YaLabel {
            id                  : f43
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f42.top
                right           : f42.right
            }
            onClicked: {
                fieldClicked(4, 3)
            }
        }

        YaLabel {
            id                  : f42
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f41.top
                right           : f41.right
            }
            onClicked: {
                fieldClicked(4, 2)
            }
        }

        YaLabel {
            id                  : f41
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f40.top
                right           : f40.right
            }
            onClicked: {
                fieldClicked(4, 1)
            }
        }

        YaLabel {
            id                  : f40
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : f30.top
                left            : f30.right
            }
            onClicked: {
                fieldClicked(4, 0)
            }
        }

// ------------------------------------------------------------ column 5

        YaLabel {
            id                  : f57
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f56.top
                right           : f56.right
            }
            onClicked: {
                fieldClicked(5, 7)
            }
        }

        YaLabel {
            id                  : f56
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f55.top
                right           : f55.right
            }
            onClicked: {
                fieldClicked(5, 6)
            }
        }

        YaLabel {
            id                  : f55
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f54.top
                right           : f54.right
            }
            onClicked: {
                fieldClicked(5, 5)
            }
        }

        YaLabel {
            id                  : f54
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f53.top
                right           : f53.right
            }
            onClicked: {
                fieldClicked(5, 4)
            }
        }

        YaLabel {
            id                  : f53
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f52.top
                right           : f52.right
            }
            onClicked: {
                fieldClicked(5, 3)
            }
        }

        YaLabel {
            id                  : f52
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f51.top
                right           : f51.right
            }
            onClicked: {
                fieldClicked(5, 2)
            }
        }

        YaLabel {
            id                  : f51
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f50.top
                right           : f50.right
            }
            onClicked: {
                fieldClicked(5, 1)
            }
        }

        YaLabel {
            id                  : f50
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : f40.top
                left            : f40.right
            }
            onClicked: {
                fieldClicked(5, 0)
            }
        }

// ------------------------------------------------------------ column 6

        YaLabel {
            id                  : f67
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f66.top
                right           : f66.right
            }
            onClicked: {
                fieldClicked(6, 7)
            }
        }

        YaLabel {
            id                  : f66
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f65.top
                right           : f65.right
            }
            onClicked: {
                fieldClicked(6, 6)
            }
        }

        YaLabel {
            id                  : f65
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f64.top
                right           : f64.right
            }
            onClicked: {
                fieldClicked(6, 5)
            }
        }

        YaLabel {
            id                  : f64
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f63.top
                right           : f63.right
            }
            onClicked: {
                fieldClicked(6, 4)
            }
        }

        YaLabel {
            id                  : f63
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f62.top
                right           : f62.right
            }
            onClicked: {
                fieldClicked(6, 3)
            }
        }

        YaLabel {
            id                  : f62
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f61.top
                right           : f61.right
            }
            onClicked: {
                fieldClicked(6, 2)
            }
        }

        YaLabel {
            id                  : f61
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f60.top
                right           : f60.right
            }
            onClicked: {
                fieldClicked(6, 1)
            }
        }

        YaLabel {
            id                  : f60
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : f50.top
                left            : f50.right
            }
            onClicked: {
                fieldClicked(6, 0)
            }
        }

// ------------------------------------------------------------ column 7

        YaLabel {
            id                  : f77
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f76.top
                right           : f76.right
            }
            onClicked: {
                fieldClicked(7, 7)
            }
        }

        YaLabel {
            id                  : f76
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f75.top
                right           : f75.right
            }
            onClicked: {
                fieldClicked(7, 6)
            }
        }

        YaLabel {
            id                  : f75
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f74.top
                right           : f74.right
            }
            onClicked: {
                fieldClicked(7, 5)
            }
        }

        YaLabel {
            id                  : f74
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f73.top
                right           : f73.right
            }
            onClicked: {
                fieldClicked(7, 4)
            }
        }

        YaLabel {
            id                  : f73
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f72.top
                right           : f72.right
            }
            onClicked: {
                fieldClicked(7, 3)
            }
        }

        YaLabel {
            id                  : f72
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f71.top
                right           : f71.right
            }
            onClicked: {
                fieldClicked(7, 2)
            }
        }

        YaLabel {
            id                  : f71
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : f70.top
                right           : f70.right
            }
            onClicked: {
                fieldClicked(7, 1)
            }
        }

        YaLabel {
            id                  : f70
            buttonText          : ""
            height              : playFieldSize
            width               : playFieldSize
            buttonSelectedColor : (buttonText == "X" ) ? color1 : (buttonText == "B" ) ? color1 : (buttonText == "F" ) ? color2 : (buttonText == "0" ) ? color5 : "white"
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : f60.top
                left            : f60.right
            }
            onClicked: {
                fieldClicked(7, 0)
            }
        }

// ---------------------------------------------------------------------

    }

}
