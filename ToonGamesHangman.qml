/*

Memory

Version 1.0.0 
Play Hangman

*/

import QtQuick 2.1
import qb.components 1.0
import BasicUIControls 1.0

Screen {
    id                          : toonGamesHangMan
    screenTitle                 : qsTr(me)

// ---------------------------------------------------------------------

    property string me          : "Toon Hangman"

    property string colortxt    : "black"
    property string color0      : "green"
    property string color1      : "red"
    property string color2      : "yellow"
    property string color3      : "lightgrey"
    property string color4      : "cyan"
    property string keyColor    : "lime"

    property string player1Name : 'Player 1'
    property string player2Name : 'Player 2'

    property int poleWidth      : isNxt ? 10 : 8

    property int buttonHeight   : isNxt ? 40 : 32
    property int buttonWidth    : isNxt ? 225 : 180
    property int wordWidth      : isNxt ? 225 : 180

    property int fieldHeight    : isNxt ? 100 : 80
    property int fieldWidth     : isNxt ? 100 : 80

    property int margin         : isNxt ? 30 : 24

    property string secret1
    property string secret2

    property int player1Score   : 0
    property int player2Score   : 0

    property int player1Counter : 0
    property int player2Counter : 0

    property bool player1Active : true
    property bool player2Active : false
    property bool player1Won    : false
    property bool player2Won    : false
    property bool winner        : false

    property bool initialised   : false

    property int keyHeight      : isNxt ? 40 : 32
    property int keyWidth       : isNxt ? 40 : 32

    property bool keyboardActive
    property bool secretsSet

// ---------------------------------------------------------------------

    onVisibleChanged: {
        if (visible) {
            if (! initialised ) {
                player1.buttonText = player1Name
                player2.buttonText = player2Name
                resetscores()
                initialised = true
/*
// testing
                player1Counter = 11
                player2Counter = 11
                player1Won = true
                player2Won = true
*/
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

        keyboardActive = false
        secretsSet = false

        secret1 = 'change me'
        secret2 = 'change me'

        word1.buttonText =  secret1
        word2.buttonText =  secret2

        player1Won = false
        player2Won = false

        winner = false

        player1Counter = 0
        player2Counter = 0

        if (player1Active)  { player1Go.buttonText = "Click\n  me" }
        else                { player2Go.buttonText = "Click\n  me" }
    }

// ---------------------------------------------------------------------

    function keyClicked(key) {
        if (keyboardActive) {
            keyboardActive = false
//            log('keyClicked : '+key)
            if (player1Active) {
                player1Go.buttonText = "Click\n  me"
                var oldText = word1.buttonText
//                log('Secret 1 : '+secret1+' button : '+word1.buttonText)

                for (var i = 0 ; i < secret1.length ; i++ ) {
                    if (key == secret1[i] ) {
//                        log('match') ;
                        word1.buttonText = word1.buttonText.substring(0, i) + key + word1.buttonText.substring(i + 1)
                        }
//                    log('keyClicked key : '+key +' secret i : ' + secret1[i] + '  '+word1.buttonText)
                }
                if (oldText == word1.buttonText ) {
                    player1Counter = player1Counter + 1
                    player1Active = false
                    player2Active = true
                }
                if (secret1 == word1.buttonText ) {
                    winner = true
                    player1Won = true
                    player1Score = player1Score + 1
                }

            } else {
                player2Go.buttonText = "Click\n  me"
                var oldText = word2.buttonText
//                log('Secret 2 : '+secret2+' button : '+word2.buttonText)

                for (var i = 0 ; i < secret2.length ; i++ ) {
                    if (key == secret2[i] ) {
//                        log('match') ;
                        word2.buttonText = word2.buttonText.substring(0, i) + key + word2.buttonText.substring(i + 1)
                        }
//                    log('keyClicked key : '+key +' secret i : ' + secret2[i] + '  '+word2.buttonText)
                }
                if (oldText == word2.buttonText ) {
                    player2Counter = player2Counter + 1
                    player2Active = false
                    player1Active = true
                }
                if (secret2 == word2.buttonText ) {
                    winner = true
                    player2Won = true
                    player2Score = player2Score + 1
                }

            }
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

// ----------------------------------------------- secret text functions

    function saveSecret1(text) {
        if (text) {
// only allow A-Z a-z and space
//            if (text == text.replace(/[^A-Za-z\s]+/g, '') ) {
// only allow A-Z a-z and no space
            if (text == text.replace(/[^A-Za-z]+/g, '') ) {
// replace multiple spaces by single space
                text = text.replace(/  +/g, ' ')
//                log('saveSecret1   '+text)
                secret1 = text.toLowerCase()
                word1.buttonText = '*'.repeat(text.length);
            } else {
                word1.buttonText = 'letters only';
            }
            secretsSet = ( word1.buttonText != secret1 ) && ( word2.buttonText != secret2 )
        }
    }

    function saveSecret2(text) {
        if (text) {
// only allow A-Z a-z and space
//            if (text == text.replace(/[^A-Za-z\s]+/g, '') ) {
// only allow A-Z a-z and no space
            if (text == text.replace(/[^A-Za-z]+/g, '') ) {
// replace multiple spaces by single space
                text = text.replace(/  +/g, ' ')
//                log('saveSecret2   '+text)
                secret2 = text.toLowerCase()
                word2.buttonText = '*'.repeat(text.length);
            } else {
                word2.buttonText = 'letters only';
            }
            secretsSet = ( word1.buttonText != secret1 ) && ( word2.buttonText != secret2 )
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

        YaLabel {
            id                  : word1
            buttonText          : ""
            height              : buttonHeight
            width               : wordWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : player1.bottom
                left            : parent.left
                topMargin       : margin
                leftMargin      : margin
            }
            onClicked: {
                qkeyboard.open("The word for Player 1 to guess", secret1, saveSecret1)
            }
        }

        YaLabel {
            id                  : player1Go
            buttonText          : "Click\n  me"
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
                left            : parent.left
                leftMargin      : margin
            }
            visible             : secretsSet && player1Active
            onClicked: {
                keyboardActive = true
                player1Go.buttonText = "Click\nletter"
            }
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
                verticalCenter  : parent.verticalCenter
                horizontalCenter: player1.horizontalCenter
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
                top: parent.top
                right           : parent.right
                topMargin       : margin
                rightMargin     : margin
            }
            onClicked: {
                qkeyboard.open("The name for Player 2", player2.buttonText, savePlayer2Name)
            }
        }

        YaLabel {
            id                  : word2
            buttonText          : ""
            height              : buttonHeight
            width               : wordWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : player2.bottom
                right           : parent.right
                topMargin       : margin
                rightMargin     : margin
            }
            onClicked: {
                qkeyboard.open("The word for Player 2 to guess", secret2, saveSecret2)
            }
        }

        YaLabel {
            id                  : player2Go
            buttonText          : "Click\n  me"
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
                right           : parent.right
                rightMargin     : margin
            }
            onClicked: {
                keyboardActive = true
                player2Go.buttonText = "Click\nletter"
            }
            visible             : secretsSet && player2Active
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
                verticalCenter  : parent.verticalCenter
                horizontalCenter: player2.horizontalCenter
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 50 : 40
            visible             : player2Won
        }

        Text {
            id                  : score2
            text                : player2Score
            anchors {
                bottom          : resetGame.top
                horizontalCenter: resetGame.horizontalCenter
            }
            font.pixelSize      : isNxt ? 50 : 40
        }

        YaLabel {
            id                  : resetScores
            buttonText          : "Reset Scores"
            height              : buttonHeight
            width               : buttonWidth * 3 / 4
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
            buttonText          : "Reset Game"
            height              : buttonHeight
            width               : buttonWidth * 3 / 4
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
                resetgame()
            }
        }

// ------------------------------------------------------------ Keyboard

// ------------------- bottom row keys

        YaLabel {
            id                  : keyZ
            buttonText          : "z"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyX.bottom
                right           : keyX.left
                rightMargin     : margin / 2
            }
            onClicked: {
                keyClicked("z")
            }
        }
        YaLabel {
            id                  : keyX
            buttonText          : "x"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyC.bottom
                right           : keyC.left
                rightMargin     : margin / 2
            }
            onClicked: {
                keyClicked("x")
            }
        }

        YaLabel {
            id                  : keyC
            buttonText          : "c"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyV.bottom
                right           : keyV.left
                rightMargin     : margin / 2
            }
            onClicked: {
                keyClicked("c")
            }
        }

        YaLabel {
            id                  : keyV
            buttonText          : "v"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : parent.bottom
                horizontalCenter: parent.horizontalCenter
                bottomMargin    : margin / 2
            }
            onClicked: {
                keyClicked("v")
            }
        }

        YaLabel {
            id                  : keyB
            buttonText          : "b"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyV.bottom
                left            : keyV.right
                leftMargin      : margin /2
            }
            onClicked: {
                keyClicked("b")
            }
        }

        YaLabel {
            id                  : keyN
            buttonText          : "n"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyB.bottom
                left            : keyB.right
                leftMargin      : margin /2
            }
            onClicked: {
                keyClicked("n")
            }
        }

        YaLabel {
            id                  : keyM
            buttonText          : "m"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyN.bottom
                left            : keyN.right
                leftMargin      : margin /2
            }
            onClicked: {
                keyClicked("m")
            }
        }

// ------------------- middle row keys

        YaLabel {
            id                  : keyA
            buttonText          : "a"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyS.bottom
                right           : keyS.left
                rightMargin     : margin / 2
            }
            onClicked: {
                keyClicked("a")
            }
        }

        YaLabel {
            id                  : keyS
            buttonText          : "s"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyD.bottom
                right           : keyD.left
                rightMargin     : margin / 2
            }
            onClicked: {
                keyClicked("s")
            }
        }

        YaLabel {
            id                  : keyD
            buttonText          : "d"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyF.bottom
                right           : keyF.left
                rightMargin     : margin / 2
            }
            onClicked: {
                keyClicked("d")
            }
        }

        YaLabel {
            id                  : keyF
            buttonText          : "f"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyG.bottom
                right           : keyG.left
                rightMargin     : margin / 2
            }
            onClicked: {
                keyClicked("f")
            }
        }

        YaLabel {
            id                  : keyG
            buttonText          : "g"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyV.top
                horizontalCenter: parent.horizontalCenter
                bottomMargin    : margin / 2
            }
            onClicked: {
                keyClicked("g")
            }
        }

        YaLabel {
            id                  : keyH
            buttonText          : "h"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyG.bottom
                left            : keyG.right
                leftMargin      : margin / 2
            }
            onClicked: {
                keyClicked("h")
            }
        }

        YaLabel {
            id                  : keyJ
            buttonText          : "j"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyH.bottom
                left            : keyH.right
                leftMargin      : margin / 2
            }
            onClicked: {
                keyClicked("j")
            }
        }

        YaLabel {
            id                  : keyK
            buttonText          : "k"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyJ.bottom
                left            : keyJ.right
                leftMargin      : margin / 2
            }
            onClicked: {
                keyClicked("k")
            }
        }

        YaLabel {
            id                  : keyL
            buttonText          : "l"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyK.bottom
                left            : keyK.right
                leftMargin      : margin / 2
            }
            onClicked: {
                keyClicked("l")
            }
        }

// ------------------- top row keys

        YaLabel {
            id                  : keyQ
            buttonText          : "q"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyW.bottom
                right           : keyW.left
                rightMargin     : margin / 2
            }
            onClicked: {
                keyClicked("q")
            }
        }

        YaLabel {
            id                  : keyW
            buttonText          : "w"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyE.bottom
                right           : keyE.left
                rightMargin     : margin / 2
            }
            onClicked: {
                keyClicked("w")
            }
        }

        YaLabel {
            id                  : keyE
            buttonText          : "e"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyR.bottom
                right           : keyR.left
                rightMargin     : margin / 2
            }
            onClicked: {
                keyClicked("e")
            }
        }

        YaLabel {
            id                  : keyR
            buttonText          : "r"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyT.bottom
                right           : keyT.left
                rightMargin     : margin / 2
            }
            onClicked: {
                keyClicked("r")
            }
        }

        YaLabel {
            id                  : keyT
            buttonText          : "t"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyG.top
                right           : parent.horizontalCenter
                bottomMargin    : margin / 2
                rightMargin     : margin / 4
            }
            onClicked: {
                keyClicked("t")
            }
        }

        YaLabel {
            id                  : keyY
            buttonText          : "y"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyT.bottom
                left            : parent.horizontalCenter
                leftMargin      : margin / 4
            }
            onClicked: {
                keyClicked("y")
            }
        }

        YaLabel {
            id                  : keyU
            buttonText          : "u"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyY.bottom
                left            : keyY.right
                leftMargin      : margin / 2
            }
            onClicked: {
                keyClicked("u")
            }
        }

        YaLabel {
            id                  : keyI
            buttonText          : "i"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyU.bottom
                left            : keyU.right
                leftMargin      : margin / 2
            }
            onClicked: {
                keyClicked("i")
            }
        }

        YaLabel {
            id                  : keyO
            buttonText          : "o"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyI.bottom
                left            : keyI.right
                leftMargin      : margin / 2
            }
            onClicked: {
                keyClicked("o")
            }
        }

        YaLabel {
            id                  : keyP
            buttonText          : "p"
            height              : keyHeight
            width               : keyWidth
            buttonActiveColor   : keyColor
            buttonHoverColor    : keyColor
            buttonSelectedColor : keyColor
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                bottom          : keyO.bottom
                left            : keyO.right
                leftMargin      : margin / 2
            }
            onClicked: {
                keyClicked("p")
            }
        }

// -------------------------------------------------- Hangman 1

        Rectangle {
            id                  : rectangle11
            height              : poleWidth
            width               : isNxt ? 190 : 152
            anchors {
                bottom          : parent.bottom
                right           : parent.horizontalCenter
                rightMargin     : isNxt ? 5 : 4
                bottomMargin    : isNxt ? 200 : 160
            }
            color               : color1
            visible             : player1Counter >= 1 || winner
        }

        Rectangle {
            id                  : rectangle12
            height              : isNxt ? 250 : 200
            width               : poleWidth
            anchors {
                bottom          : rectangle11.top
                left            : rectangle11.left
            }
            color               : color1
            visible             : player1Counter >= 2 || winner
        }

        Rectangle {
            id                  : rectangle13
            height              : poleWidth
            width               : isNxt ? 70 : 52
            anchors {
                top             : rectangle14.top
                left            : rectangle12.left
                leftMargin      : isNxt ? -15 : -12
            }
            transform           : Rotation { origin.x: isNxt ? 70 : 52 ; origin.y: 0 ; axis { x: 0; y: 0; z: 1 } angle: -45 }
            color               : color1
            visible             : player1Counter >= 3  || winner
        }

        Rectangle {
            id                  : rectangle14
            height              : poleWidth
            width               : isNxt ? 150 : 120
            anchors {
                bottom          : rectangle12.top
                left            : rectangle12.left
            }
            color               : color1
            visible             : player1Counter >= 4 || winner
        }

        Rectangle {
            id                  : rectangle15
            height              : poleWidth * 2
            width               : poleWidth
            anchors {
                top             : rectangle14.bottom
                horizontalCenter: rectangle11.horizontalCenter
            }
            color               : color1
            visible             : player1Counter >= 5 || winner
        }

// --------------------------------------------------

        Rectangle {

            id                  : rectangle1Pop
            height              : poleWidth
            width               : poleWidth * 4
            anchors {
                top             : rectangle15.bottom
                horizontalCenter: rectangle15.horizontalCenter
                topMargin       : player1Won ? isNxt ? 35 : 28 : 0
            }
            color               : color0

            YaLabel {
                id                  : rectangle16
                buttonText          : ""
                height              : isNxt ? 60 : 48
                width               : isNxt ? 50 : 40
                buttonActiveColor   : color0
                buttonHoverColor    : color0
                buttonSelectedColor : color0
                buttonBorderColor   : color1
                buttonBorderRadius  : isNxt ? 25 : 20
                buttonBorderWidth   : poleWidth
                selected            : false
                enabled             : true
                textColor           : color1
                anchors {
                    top             : parent.top
                    horizontalCenter: parent.horizontalCenter
                }
                visible             : player1Counter >= 6  || winner
            }

            YaLabel {
                id                  : rectangle17
                buttonText          : ""
                height              : isNxt ? 100 : 80
                width               : isNxt ? 60 : 48
                buttonActiveColor   : color0
                buttonHoverColor    : color0
                buttonSelectedColor : color0
                buttonBorderColor   : color1
                buttonBorderRadius  : isNxt ? 25 : 20
                buttonBorderWidth   : poleWidth
                selected            : false
                enabled             : true
                textColor           : color1
                anchors {
                    top             : rectangle16.bottom
                    horizontalCenter: parent.horizontalCenter
                }
                visible             : player1Counter >= 7  || winner
            }

            Rectangle {
                id                  : rectangle18
                height              : poleWidth
                width               : isNxt ? 60 : 48
                anchors {
                    right           : rectangle1Pop.left
                    top             : rectangle17.bottom
                }
                transform           : Rotation { origin.x: isNxt ? 50 : 40 ; origin.y: 0 ; axis { x: 0; y: 0; z: 1 } angle: -45 }
                color               : color1
                visible             : player1Counter >= 8  || winner
            }

            Rectangle {
                id                  : rectangle19
                height              : poleWidth
                width               : isNxt ? 60 : 48
                anchors {
                    left            : rectangle1Pop.right
                    top             : rectangle17.bottom
                }
                transform           : Rotation { origin.x: isNxt ? 10 : 8 ; origin.y: 0 ; axis { x: 0; y: 0; z: 1 } angle: 45 }
                color               : color1
                visible             : player1Counter >= 9 || winner
            }

            Rectangle {
                id                  : rectangle110
                height              : poleWidth
                width               : isNxt ? 60 : 48
                anchors {
                    right           : rectangle1Pop.left
                    top             : rectangle17.top
                }
                transform           : Rotation { origin.x: isNxt ? 50 : 40 ; origin.y: 0 ; axis { x: 0; y: 0; z: 1 } angle: 45 }
                color               : color1
                visible             : player1Counter >= 10 || winner
            }

            Rectangle {
                id                  : rectangle111
                height              : poleWidth
                width               : isNxt ? 60 : 48
                anchors {
                    left            : rectangle1Pop.right
                    top             : rectangle17.top
                }
                transform           : Rotation { origin.x: isNxt ? 10 : 8 ; origin.y: 0 ; axis { x: 0; y: 0; z: 1 } angle: -45 }
                color               : color1
                visible             : player1Counter >= 11 || winner
            }
        }

// -------------------------------------------------- Hangman 2

        Rectangle {
            id                  : rectangle21
            height              : poleWidth
            width               : isNxt ? 190 : 152
            anchors {
                bottom          : rectangle11.bottom
                left            : parent.horizontalCenter
                leftMargin      : isNxt ? 5 : 4
            }
            color               : color2
            visible             : player2Counter >= 1 || winner
        }

        Rectangle {
            id                  : rectangle22
            height              : isNxt ? 250 : 200
            width               : poleWidth
            anchors {
                bottom          : rectangle21.top
                right           : rectangle21.right
            }
            color               : color2
            visible             : player2Counter >= 2 || winner
        }

        Rectangle {
            id                  : rectangle23
            height              : poleWidth
            width               : isNxt ? 70 : 52
            anchors {
                top             : rectangle24.top
                right           : rectangle22.right
                rightMargin     : isNxt ? -15 : -12
            }
            transform           : Rotation { origin.x: 0 ; origin.y: 0 ; axis { x: 0; y: 0; z: 1 } angle: 45 }
            color               : color2
            visible             : player2Counter >= 3  || winner
        }

        Rectangle {
            id                  : rectangle24
            height              : poleWidth
            width               : isNxt ? 150 : 120
            anchors {
                bottom          : rectangle22.top
                right           : rectangle22.right
            }
            color               : color2
            visible             : player2Counter >= 4 || winner
        }

        Rectangle {
            id                  : rectangle25
            height              : poleWidth * 2
            width               : poleWidth
            anchors {
                top             : rectangle24.bottom
                horizontalCenter: rectangle21.horizontalCenter
            }
            color               : color2
            visible             : player2Counter >= 5 || winner
        }

// --------------------------------------------------

        Rectangle {

            id                  : rectangle2Pop
            height              : poleWidth
            width               : poleWidth * 4
            anchors {
                top             : rectangle25.bottom
                horizontalCenter: rectangle25.horizontalCenter
                topMargin       : player2Won ? isNxt ? 35 : 28 : 0
            }
            color               : color0

            YaLabel {
                id                  : rectangle26
                buttonText          : ""
                height              : isNxt ? 60 : 48
                width               : isNxt ? 50 : 40
                buttonActiveColor   : color0
                buttonHoverColor    : color0
                buttonSelectedColor : color0
                buttonBorderColor   : color2
                buttonBorderRadius  : isNxt ? 25 : 20
                buttonBorderWidth   : poleWidth
                selected            : false
                enabled             : true
                textColor           : color2
                anchors {
                    top             : parent.top
                    horizontalCenter: parent.horizontalCenter
                }
                visible             : player2Counter >= 6  || winner
            }

            YaLabel {
                id                  : rectangle27
                buttonText          : ""
                height              : isNxt ? 100 : 80
                width               : isNxt ? 60 : 48
                buttonActiveColor   : color0
                buttonHoverColor    : color0
                buttonSelectedColor : color0
                buttonBorderColor   : color2
                buttonBorderRadius  : isNxt ? 25 : 20
                buttonBorderWidth   : poleWidth

                selected            : false
                enabled             : true
                textColor           : color2
                anchors {
                    top             : rectangle26.bottom
                    horizontalCenter: parent.horizontalCenter
                }
                visible             : player2Counter >= 7  || winner
            }

            Rectangle {
                id                  : rectangle28
                height              : poleWidth
                width               : isNxt ? 60 : 48
                anchors {
                    right           : rectangle2Pop.left
                    top             : rectangle27.bottom
                }
                transform           : Rotation { origin.x: isNxt ? 50 : 40 ; origin.y: 0 ; axis { x: 0; y: 0; z: 1 } angle: -45 }
                color               : color2
                visible             : player2Counter >= 8  || winner
            }

            Rectangle {
                id                  : rectangle29
                height              : poleWidth
                width               : isNxt ? 60 : 48
                anchors {
                    left            : rectangle2Pop.right
                    top             : rectangle27.bottom
                }
                transform           : Rotation { origin.x: isNxt ? 10 : 8 ; origin.y: 0 ; axis { x: 0; y: 0; z: 1 } angle: 45 }
                color               : color2
                visible             : player2Counter >= 9 || winner
            }

            Rectangle {
                id                  : rectangle210
                height              : poleWidth
                width               : isNxt ? 60 : 48
                anchors {
                    right           : rectangle2Pop.left
                    top             : rectangle27.top
                }
                transform           : Rotation { origin.x: isNxt ? 50 : 40 ; origin.y: 0 ; axis { x: 0; y: 0; z: 1 } angle: 45 }
                color               : color2
                visible             : player2Counter >= 10 || winner
            }

            Rectangle {
                id                  : rectangle211
                height              : poleWidth
                width               : isNxt ? 60 : 48
                anchors {
                    left            : rectangle2Pop.right
                    top             : rectangle27.top
                }
                transform           : Rotation { origin.x: isNxt ? 10 : 8 ; origin.y: 0 ; axis { x: 0; y: 0; z: 1 } angle: -45 }
                color               : color2
                visible             : player2Counter >= 11 || winner
            }
        }

//----------------------------------------------------------------------

    }

}
