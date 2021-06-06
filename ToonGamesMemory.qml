/*

Memory

Version 1.0.0 
Play Memory

*/

import QtQuick 2.1
import qb.components 1.0
import BasicUIControls 1.0

Screen {

    id                          : toonGamesMemory
    screenTitle                 : qsTr(me)

// ---------------------------------------------------------------------

    property string me          : "TOon-Mem0ry!"

    property string colortxt    : "black"
    property string color0      : "green"
    property string color1      : "red"
    property string color2      : "yellow"
    property string color3      : "lightgrey"
    property string color4      : "cyan"
    property string colorHide   : color3
//    property string colorHide  : "red"
            
    property string player1Name : 'Player 1'
    property string player2Name : 'Player 2'

    property int buttonHeight   : isNxt ? 40 : 32
    property int buttonWidth    : isNxt ? 225 : 180

    property int player1Pairs   : 0
    property int player2Pairs   : 0

    property int player1Score   : 0
    property int player2Score   : 0

    property bool player1Active : true
    property bool player2Active : false
    property bool player1Won
    property bool player2Won
    property bool winner

    property int fieldHeight    : isNxt ? 80 : 64
    property int fieldWidth     : isNxt ? 80 : 64

    property int margin         : isNxt ? 30 : 24

    property string letters     : "TOon-Mem0ry!"
    property string lettersShuffled

    property string textColor0  ; property string textColor1  ; property string textColor2
    property string textColor3  ; property string textColor4  ; property string textColor5
    property string textColor6  ; property string textColor7  ; property string textColor8
    property string textColor9  ; property string textColor10 ; property string textColor11
    property string textColor12 ; property string textColor13 ; property string textColor14
    property string textColor15 ; property string textColor16 ; property string textColor17
    property string textColor18 ; property string textColor19 ; property string textColor20
    property string textColor21 ; property string textColor22 ; property string textColor23

    property bool enabled0      ; property bool enabled1      ; property bool enabled2
    property bool enabled3      ; property bool enabled4      ; property bool enabled5
    property bool enabled6      ; property bool enabled7      ; property bool enabled8
    property bool enabled9      ; property bool enabled10     ; property bool enabled11
    property bool enabled12     ; property bool enabled13     ; property bool enabled14
    property bool enabled15     ; property bool enabled16     ; property bool enabled17
    property bool enabled18     ; property bool enabled19     ; property bool enabled20
    property bool enabled21     ; property bool enabled22     ; property bool enabled23
    
    property string playMode
    
    property int selectedTile1
    property int selectedTile2

    property bool initialised : false

// ---------------------------------------------------------------------
    
    onVisibleChanged: {
        if (visible) {
            if (! initialised) {
                resetgame('Initialise')
                initialised = true
            }
        }
    }

// ---------------------------------------------------------------------

    function log(tolog) {
        console.log(me + ' games : ' + tolog.toString())
    }
    
// ---------------------------------------------------------------------

    function resetgame(how) {

        if (how == 'Initialise') {
            player1.buttonText = player1Name
            player2.buttonText = player2Name

            selectedTile1 = -1
            selectedTile2 = -1
            player1Won = false
            player2Won = false
            player1Pairs = 0
            player2Pairs = 0
        
            player1Score = 0
            player2Score = 0

            winner = false
        }         
        if (how == 'Initialise' || how == 'winner') {

            playMode = 'new Game'

            selectedTile1 = -1
            selectedTile2 = -1

            var lettersLocal = letters+letters
            
            field0.buttonText = lettersLocal[0] ; field1.buttonText = lettersLocal[1] ; field2.buttonText = lettersLocal[2] ; 
            field3.buttonText = lettersLocal[3] ; field4.buttonText = lettersLocal[4] ; field5.buttonText = lettersLocal[5] ;
            field6.buttonText = lettersLocal[6] ; field7.buttonText = lettersLocal[7] ; field8.buttonText = lettersLocal[8] ; 
            field9.buttonText = lettersLocal[9] ; field10.buttonText = lettersLocal[10] ; field11.buttonText = lettersLocal[11] ;
            field12.buttonText = lettersLocal[12] ; field13.buttonText = lettersLocal[13] ; field14.buttonText = lettersLocal[14] ; 
            field15.buttonText = lettersLocal[15] ; field16.buttonText = lettersLocal[16] ; field17.buttonText = lettersLocal[17] ;
            field18.buttonText = lettersLocal[18] ; field19.buttonText = lettersLocal[19] ; field20.buttonText = lettersLocal[20] ; 
            field21.buttonText = lettersLocal[21] ; field22.buttonText = lettersLocal[22] ; field23.buttonText = lettersLocal[23] ;
            
            enabled0  = false ;  enabled1  = false ;  enabled2 = false
            enabled3  = false ;  enabled4  = false ;  enabled5 = false
            enabled6  = false ;  enabled7  = false ;  enabled8 = false
            enabled9  = false ;  enabled10 = false ;  enabled11= false
            enabled12 = false ;  enabled13 = false ;  enabled14= false
            enabled15 = false ;  enabled16 = false ;  enabled17= false
            enabled18 = false ;  enabled19 = false ;  enabled20= false
            enabled21 = false ;  enabled22 = false ;  enabled23= false

            textColor0  = colortxt ; textColor1  = colortxt ; textColor2 = colortxt
            textColor3  = colortxt ; textColor4  = colortxt ; textColor5 = colortxt
            textColor6  = colortxt ; textColor7  = colortxt ; textColor8 = colortxt
            textColor9  = colortxt ; textColor10 = colortxt ; textColor11= colortxt
            textColor12 = colortxt ; textColor13 = colortxt ; textColor14= colortxt
            textColor15 = colortxt ; textColor16 = colortxt ; textColor17= colortxt
            textColor18 = colortxt ; textColor19 = colortxt ; textColor20= colortxt
            textColor21 = colortxt ; textColor22 = colortxt ; textColor23= colortxt
        
        } else { // new game started so we are in play mode

            playMode = 'play'

            selectedTile1 = -1
            selectedTile2 = -1
            player1Won = false
            player2Won = false
            player1Pairs = 0
            player2Pairs = 0

            winner = false
            var lettersLocal = letters+letters
            var lettersShuffledArray = []
            var index = 0
            for (var i = 0; i < 24; i++) {
// pick random character from lettersLocal
                index = Math.floor(Math.random() * lettersLocal.length)
                lettersShuffledArray[i] = lettersLocal[index]
// remove the character from lettersLocal
                lettersLocal = lettersLocal.slice(0, index) + lettersLocal.slice(index+1);
            }
// convert array to string
            lettersShuffled = lettersShuffledArray.toString()
// remove each comma
            while(lettersShuffled.includes(",")){ lettersShuffled = lettersShuffled.replace(",", ""); }
//            log('startup shuffle >'+lettersShuffled+'<')

            field0.buttonText = lettersShuffled[0] ; field1.buttonText = lettersShuffled[1] ; field2.buttonText = lettersShuffled[2] ; 
            field3.buttonText = lettersShuffled[3] ; field4.buttonText = lettersShuffled[4] ; field5.buttonText = lettersShuffled[5] ;
            field6.buttonText = lettersShuffled[6] ; field7.buttonText = lettersShuffled[7] ; field8.buttonText = lettersShuffled[8] ; 
            field9.buttonText = lettersShuffled[9] ; field10.buttonText = lettersShuffled[10] ; field11.buttonText = lettersShuffled[11] ;
            field12.buttonText = lettersShuffled[12] ; field13.buttonText = lettersShuffled[13] ; field14.buttonText = lettersShuffled[14] ; 
            field15.buttonText = lettersShuffled[15] ; field16.buttonText = lettersShuffled[16] ; field17.buttonText = lettersShuffled[17] ;
            field18.buttonText = lettersShuffled[18] ; field19.buttonText = lettersShuffled[19] ; field20.buttonText = lettersShuffled[20] ; 
            field21.buttonText = lettersShuffled[21] ; field22.buttonText = lettersShuffled[22] ; field23.buttonText = lettersShuffled[23] ;
            
            enabled0  = true ;  enabled1  = true ;  enabled2 = true
            enabled3  = true ;  enabled4  = true ;  enabled5 = true
            enabled6  = true ;  enabled7  = true ;  enabled8 = true
            enabled9  = true ;  enabled10 = true ;  enabled11= true
            enabled12 = true ;  enabled13 = true ;  enabled14= true
            enabled15 = true ;  enabled16 = true ;  enabled17= true
            enabled18 = true ;  enabled19 = true ;  enabled20= true
            enabled21 = true ;  enabled22 = true ;  enabled23= true

            textColor0  = colorHide ; textColor1  = colorHide ; textColor2 = colorHide
            textColor3  = colorHide ; textColor4  = colorHide ; textColor5 = colorHide
            textColor6  = colorHide ; textColor7  = colorHide ; textColor8 = colorHide
            textColor9  = colorHide ; textColor10 = colorHide ; textColor11= colorHide
            textColor12 = colorHide ; textColor13 = colorHide ; textColor14= colorHide
            textColor15 = colorHide ; textColor16 = colorHide ; textColor17= colorHide
            textColor18 = colorHide ; textColor19 = colorHide ; textColor20= colorHide
            textColor21 = colorHide ; textColor22 = colorHide ; textColor23= colorHide
        
        }

    }

// ---------------------------------------------------------------------

    function resetscores() {
        resetgame('Initialise')
    }

// ---------------------------------------------------------------------

    function clickTile(tile) {
    
//        log('clickTile : '+tile+' mode '+playMode)

        switch(playMode) {
        case 'play' :
            flipTile(tile,colortxt)
//            log('play '+selectedTile1+' and '+selectedTile2)
            if (selectedTile1 < 0) {
                selectedTile1 = tile 
            } else {
                if (selectedTile1 != tile) {
                    selectedTile2 = tile
                    if (lettersShuffled[selectedTile1] == lettersShuffled[selectedTile2] ) {
//                        log('found a pair')
                        playMode = 'collect'
                    } else {
//                        log('found no pair')
                        playMode = 'back'
                    }
                }
            }
            break
        case 'collect' :
            if ( tile == selectedTile1 || tile == selectedTile2 ) {
                playMode = 'play'
//                log('collect '+selectedTile1+' and '+selectedTile2)
                collectTile(selectedTile1)
                collectTile(selectedTile2)
                selectedTile1 = -1
                selectedTile2 = -1
                if (player1Active) { player1Pairs = player1Pairs + 1 } else { player2Pairs = player2Pairs + 1 }
//                log('collect pairs : '+player1Pairs+' and '+player2Pairs)
                if (player1Pairs == 6 ) { 
                    player1Score = player1Score + 1
                    player1Won = true
                    winner = true
                }
                if (player2Pairs == 6 ) { 
                    player2Score = player2Score + 1
                    player2Won = true
                    winner = true
                }
//                log('collect scores : '+player1Score+' and '+player2Score)
                if (winner) { resetgame('winner') }
            }
            break
        case 'back' :
            if ( tile == selectedTile1 || tile == selectedTile2 ) {
                playMode = 'play'
//                log('back '+selectedTile1+' and '+selectedTile2)
                flipTile(selectedTile1,colorHide)
                flipTile(selectedTile2,colorHide)
                selectedTile1 = -1
                selectedTile2 = -1
                player1Active = ! player1Active
                player2Active = ! player2Active
            }
            break
        }
//        log('------- '+playMode)
    }

// ---------------------------------------------------------------------

    function collectTile(tile) {
        
//        log('collectTile : '+tile)
        
        switch(tile) {
        case  0 : textColor0  = color0; enabled0  = false ; break
        case  1 : textColor1  = color0; enabled1  = false ; break
        case  2 : textColor2  = color0; enabled2  = false ; break
        case  3 : textColor3  = color0; enabled3  = false ; break
        case  4 : textColor4  = color0; enabled4  = false ; break
        case  5 : textColor5  = color0; enabled5  = false ; break
        case  6 : textColor6  = color0; enabled6  = false ; break
        case  7 : textColor7  = color0; enabled7  = false ; break
        case  8 : textColor8  = color0; enabled8  = false ; break
        case  9 : textColor9  = color0; enabled9  = false ; break
        case 10 : textColor10 = color0; enabled10 = false ; break
        case 11 : textColor11 = color0; enabled11 = false ; break
        case 12 : textColor12 = color0; enabled12 = false ; break
        case 13 : textColor13 = color0; enabled13 = false ; break
        case 14 : textColor14 = color0; enabled14 = false ; break
        case 15 : textColor15 = color0; enabled15 = false ; break
        case 16 : textColor16 = color0; enabled16 = false ; break
        case 17 : textColor17 = color0; enabled17 = false ; break
        case 18 : textColor18 = color0; enabled18 = false ; break
        case 19 : textColor19 = color0; enabled19 = false ; break
        case 20 : textColor20 = color0; enabled20 = false ; break
        case 21 : textColor21 = color0; enabled21 = false ; break
        case 22 : textColor22 = color0; enabled22 = false ; break
        case 23 : textColor23 = color0; enabled23 = false ; break
        }
    }

// ---------------------------------------------------------------------

    function flipTile(tile,color) {

//        log('flip '+tile+' '+color)

        switch(tile) {
        case  0 : textColor0  = color; break
        case  1 : textColor1  = color; break
        case  2 : textColor2  = color; break
        case  3 : textColor3  = color; break
        case  4 : textColor4  = color; break
        case  5 : textColor5  = color; break
        case  6 : textColor6  = color; break
        case  7 : textColor7  = color; break
        case  8 : textColor8  = color; break
        case  9 : textColor9  = color; break
        case 10 : textColor10 = color; break
        case 11 : textColor11 = color; break
        case 12 : textColor12 = color; break
        case 13 : textColor13 = color; break
        case 14 : textColor14 = color; break
        case 15 : textColor15 = color; break
        case 16 : textColor16 = color; break
        case 17 : textColor17 = color; break
        case 18 : textColor18 = color; break
        case 19 : textColor19 = color; break
        case 20 : textColor20 = color; break
        case 21 : textColor21 = color; break
        case 22 : textColor22 = color; break
        case 23 : textColor23 = color; break
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

// ---------------------------------------------------------------------

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
            height              : buttonHeight
            width               : buttonWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
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

        Text {
            id                  : player1PairsText
            text                : "Pairs : " + player1Pairs
            anchors {
                top             : player1.bottom
                left            : player1.left
                topMargin       : margin
            }
            font.pixelSize      : isNxt ? 50 : 40
        }

        YaLabel {
            id                  : player1Go
            buttonText          : "GO !"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color1
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                verticalCenter  : parent.verticalCenter
                horizontalCenter: player1.horizontalCenter
            }
            visible             : player1Active
        }
        
        YaLabel {
            id                  : player1won
            buttonText          : "Winner ! "
            height              : fieldHeight
            width               : buttonWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color1
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : player1Go.bottom
                topMargin       : margin
                horizontalCenter: player1.horizontalCenter
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize:  isNxt ? 50 : 40
            visible             : player1Won
        }

        Text {
            id                  : score1
            text                : player1Score
            anchors {
                top             : player1won.top
                horizontalCenter: player1.horizontalCenter
            }
            font.pixelSize      : isNxt ? 50 : 40
            visible             : ! player1Won
        }
        
        YaLabel {
            id                  : player2
            buttonText          : ""
            height              : buttonHeight
            width               : buttonWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
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

        Text {
            id                  : player2PairsText
            text                : "Pairs : " + player2Pairs
            anchors {
                top             : player2.bottom
                right           : player2.right
                topMargin       : margin
            }
            font.pixelSize      : isNxt ? 50 : 40
        }

        YaLabel {
            id                  : player2Go
            buttonText          : "GO !"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color2
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                verticalCenter  : parent.verticalCenter
                horizontalCenter: player2.horizontalCenter
            }
            visible             : player2Active
        }
            
        YaLabel {
            id                  : player2won
            buttonText          : "Winner ! "
            height              : fieldHeight
            width               : buttonWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color2
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : player2Go.bottom
                topMargin       : margin
                horizontalCenter: player2.horizontalCenter
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize:  isNxt ? 50 : 40
            visible             : player2Won
        }
        
        Text {
            id                  : score2
            text                : player2Score
            anchors {
                top             : player2won.top
                horizontalCenter: player2.horizontalCenter
            }
            font.pixelSize      : isNxt ? 50 : 40
            visible             : ! player2Won
        }

        YaLabel {
            id                  : draw
            buttonText          : "...Draw..."
            height              : buttonHeight
            width               : buttonWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color4
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : parent.bottom
                horizontalCenter: parent.horizontalCenter
                bottomMargin    : margin
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize:  isNxt ? 40 : 32
            visible             : (! winner && ( player1Pairs + player2Pairs == 12 ) )
        }

        YaLabel {
            id                  : resetScores
            buttonText          : "Reset Scores"
            height              : buttonHeight
            width               : buttonWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
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
            buttonText          : "New Game"
            height              : buttonHeight
            width               : buttonWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
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
                resetgame('New')
            }
        }
    
// ---------------------------------------  ----------- play field row 1

        YaLabel {
            id                  : field0
            buttonText          : "0"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : true
            enabled             : enabled0
            textColor           : textColor0
            anchors {
                top             : field2.top
                right           : field1.left
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(0)
            }
        }

        YaLabel {
            id                  : field1
            buttonText          : "1"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : true
            enabled             : enabled1
            textColor           : textColor1
            anchors {
                top             : field2.top
                right           : field2.left
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(1)
            }
        }

        YaLabel {
            id                  : field2
            buttonText          : "2"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : true
            enabled             : enabled2
            textColor           : textColor2
            anchors {
                top             : parent.top
                topMargin   : margin
                horizontalCenter: parent.horizontalCenter
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(2)
            }
        }

        YaLabel {
            id                  : field3
            buttonText          : "3"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : true
            enabled             : enabled3
            textColor           : textColor3
            anchors {
                top             : field2.top
                left       : field2.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(3)
            }
        }

        YaLabel {
            id                  : field4
            buttonText          : "4"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : true
            enabled             : enabled4
            textColor           : textColor4
            anchors {
                top             : field2.top
                left       : field3.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(4)
            }
        }

// ---------------------------------------------------- play field row 2

        YaLabel {
            id                  : field5
            buttonText          : "5"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : true
            enabled             : enabled5
            textColor           : textColor5
            anchors {
                top             : field0.bottom
                right           : field0.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(5)
            }
        }

        YaLabel {
            id                  : field6
            buttonText          : "6"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : true
            enabled             : enabled6
            textColor           : textColor6
            anchors {
                top             : field1.bottom
                right           : field1.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(6)
            }
        }

        YaLabel {
            id                  : field7
            buttonText          : "7"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : true
            enabled             : enabled7
            textColor           : textColor7
            anchors {
                top             : field2.bottom
                right           : field2.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(7)
            }
        }

        YaLabel {
            id                  : field8
            buttonText          : "8"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : true
            enabled             : enabled8
            textColor           : textColor8
            anchors {
                top             : field3.bottom
                right           : field3.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(8)
            }
        }

        YaLabel {
            id                  : field9
            buttonText          : "9"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : true
            enabled             : enabled9
            textColor           : textColor9
            anchors {
                top             : field4.bottom
                right           : field4.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(9)
            }
        }

// ---------------------------------------------------- play field row 3

        YaLabel {
            id                  : field10
            buttonText          : "10"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : true
            enabled             : enabled10
            textColor           : textColor10
            anchors {
                top             : field5.bottom
                right           : field5.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(10)
            }
        }

        YaLabel {
            id                  : field11
            buttonText          : "11"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : true
            enabled             : enabled11
            textColor           : textColor11
            anchors {
                top             : field6.bottom
                right           : field6.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(11)
            }
        }

        YaLabel {
            id                  : fieldX
            buttonText          : ""
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : color0
            buttonHoverColor    : color0
            buttonSelectedColor : color0
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : field7.bottom
                right           : field7.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
        }

        YaLabel {
            id                  : field12
            buttonText          : "12"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : true
            enabled             : enabled12
            textColor           : textColor12
            anchors {
                top             : field8.bottom
                right           : field8.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(12)
            }
        }

        YaLabel {
            id                  : field13
            buttonText          : "13"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : true
            enabled             : enabled13
            textColor           : textColor13
            anchors {
                top             : field9.bottom
                right           : field9.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(13)
            }
        }

// ---------------------------------------------------- play field row 4

        YaLabel {
            id                  : field14
            buttonText          : "14"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : true
            enabled             : enabled14
            textColor           : textColor14
            anchors {
                top             : field10.bottom
                right           : field10.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(14)
            }
        }

        YaLabel {
            id                  : field15
            buttonText          : "15"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : true
            enabled             : enabled15
            textColor           : textColor15
            anchors {
                top             : field11.bottom
                right           : field11.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(15)
            }
        }

        YaLabel {
            id                  : field16
            buttonText          : "16"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : true
            enabled             : enabled16
            textColor           : textColor16
            anchors {
                top             : fieldX.bottom
                right           : fieldX.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(16)
            }
        }

        YaLabel {
            id                  : field17
            buttonText          : "17"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : true
            enabled             : enabled17
            textColor           : textColor17
            anchors {
                top             : field12.bottom
                right           : field12.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(17)
            }
        }

        YaLabel {
            id                  : field18
            buttonText          : "18"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : true
            enabled             : enabled18
            textColor           : textColor18
            anchors {
                top             : field13.bottom
                right           : field13.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(18)
            }
        }

// ---------------------------------------------------- play field row 5

        YaLabel {
            id                  : field19
            buttonText          : "19"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : true
            enabled             : enabled19
            textColor           : textColor19
            anchors {
                top             : field14.bottom
                right           : field14.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(19)
            }
        }

        YaLabel {
            id                  : field20
            buttonText          : "20"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : true
            enabled             : enabled20
            textColor           : textColor20
            anchors {
                top             : field15.bottom
                right           : field15.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(20)
            }
        }

        YaLabel {
            id                  : field21
            buttonText          : "21"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : true
            enabled             : enabled21
            textColor           : textColor21
            anchors {
                top             : field16.bottom
                right           : field16.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(21)
            }
        }

        YaLabel {
            id                  : field22
            buttonText          : "22"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : true
            enabled             : enabled22
            textColor           : textColor22
            anchors {
                top             : field17.bottom
                right           : field17.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(22)
            }
        }

        YaLabel {
            id                  : field23
            buttonText          : "23"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : enabled23
            textColor           : textColor23
            anchors {
                top             : field18.bottom
                right           : field18.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                clickTile(23)
            }
        }

// --------------------------------------------------

    }

}

