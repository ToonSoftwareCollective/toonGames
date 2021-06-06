/*

Tic Tac Toon 

Version 1.0.0 
Play like tic tac toe

*/

import QtQuick 2.1
import qb.components 1.0
import BasicUIControls 1.0

Screen {
    id                          : toonGamesTicTacToe
    screenTitle                 : qsTr(me)

// ---------------------------------------------------------------------

    property string me          : "Tic Tac Toon"
    
    property string colortxt    : "black"
    property string color0      : "green"
    property string color1      : "red"
    property string color2      : "yellow"
    property string color3      : "lightgrey"
    property string color4      : "cyan"
    
    property string player1Name : 'Player 1'
    property string player2Name : 'Player 2'

    property bool player1Active : true
    property bool player2Active : false
    property bool player1Won    : false
    property bool player2Won    : false
    property bool winner        : false
    property int lastWinner     : 1

    property string marker      : ""
    
    property int fieldsFilled   : 0

    property int player1Score   : 0
    property int player2Score   : 0
    
    property int buttonHeight   : isNxt ? 40 : 32
    property int buttonWidth    : isNxt ? 225 : 180

    property int fieldHeight    : isNxt ? 100 : 80
    property int fieldWidth     : isNxt ? 100 : 80
    
    property int margin         : isNxt ? 30 : 24

// ---------------------------------------------------------------------
    
    onVisibleChanged: {
        if (visible) {
            player1.buttonText = player1Name
            player2.buttonText = player2Name
        }
    }

// ---------------------------------------------------------------------

    function resetscores() {
        resetgame()
        player1Score = 0
        player2Score = 0
    }
    
    function resetgame() {

        resetGame.buttonText = "Reset Game"
        
        if (winner) {
            if (player1Won) { lastWinner = 1 } else { lastWinner = 2}
            player1Active = player1Won
            player2Active = player2Won
            player1Won = false
            player2Won = false
            winner = false
        } else {
            player1Active = ( lastWinner == 1 )
            player2Active = ( lastWinner == 2 ) 
        }
        field11.buttonText = ""
        field12.buttonText = ""
        field13.buttonText = ""
        field21.buttonText = ""
        field22.buttonText = ""
        field23.buttonText = ""
        field31.buttonText = ""
        field32.buttonText = ""
        field33.buttonText = ""
        fieldsFilled = 0
    }

// ---------------------------------------------------------------------
    
    function check(rc ) {

        if (!winner) {
            var valid = false
            if ( player1Active ) { marker = 'X' } else { marker = 'O' }
            if ( rc == 11 && field11.buttonText == "" ) { field11.buttonText = marker ; valid = true }
            if ( rc == 12 && field12.buttonText == "" ) { field12.buttonText = marker ; valid = true }
            if ( rc == 13 && field13.buttonText == "" ) { field13.buttonText = marker ; valid = true }
            if ( rc == 21 && field21.buttonText == "" ) { field21.buttonText = marker ; valid = true }
            if ( rc == 22 && field22.buttonText == "" ) { field22.buttonText = marker ; valid = true }
            if ( rc == 23 && field23.buttonText == "" ) { field23.buttonText = marker ; valid = true }
            if ( rc == 31 && field31.buttonText == "" ) { field31.buttonText = marker ; valid = true }
            if ( rc == 32 && field32.buttonText == "" ) { field32.buttonText = marker ; valid = true }
            if ( rc == 33 && field33.buttonText == "" ) { field33.buttonText = marker ; valid = true }
            
            if ( valid ) {
                
                winner = 
                   ( field11.buttonText != "" && field11.buttonText == field12.buttonText && field12.buttonText == field13.buttonText )
                || ( field21.buttonText != "" && field21.buttonText == field22.buttonText && field22.buttonText == field23.buttonText )
                || ( field31.buttonText != "" && field31.buttonText == field32.buttonText && field32.buttonText == field33.buttonText )
                || ( field11.buttonText != "" && field11.buttonText == field21.buttonText && field21.buttonText == field31.buttonText )
                || ( field12.buttonText != "" && field12.buttonText == field22.buttonText && field22.buttonText == field32.buttonText )
                || ( field13.buttonText != "" && field13.buttonText == field23.buttonText && field23.buttonText == field33.buttonText )
                || ( field11.buttonText != "" && field11.buttonText == field22.buttonText && field22.buttonText == field33.buttonText )
                || ( field13.buttonText != "" && field13.buttonText == field22.buttonText && field22.buttonText == field31.buttonText )

                if ( winner ) {
                    if (player1Active) {
                        player1Won = true
                        player1Score = player1Score + 1 
                    } else {
                        player2Won = true
                        player2Score = player2Score + 1 
                    }
                    player1Active = false
                    player2Active = false
                    resetGame.buttonText = "New Game"
                } else {
                    player1Active = !player1Active
                    player2Active = !player2Active
                }

                fieldsFilled = fieldsFilled + 1
                
                if ( fieldsFilled == 9 ) {
                    player1Active = false
                    player2Active = false
                    resetGame.buttonText = "New Game"
                }
            }
        }
    }

// ---------------------------------------------------------------------
    
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
    
        height  : parent.height - 20
        width   : parent.width - 40
        anchors {
            horizontalCenter    : parent.horizontalCenter
            verticalCenter      : parent.verticalCenter
        }
        color   : color0
    
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
            id                  : text1
            text                : "Side   X"
            anchors {
                top             : player1.bottom
                right           : player1.right
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
                top             : field22.top
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
                bottom          : field31.bottom
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
                top             : field31.top
                horizontalCenter: player1.horizontalCenter
            }
            font.pixelSize      : isNxt ? 50 : 40
            visible             : !player1Won
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
            id                  : text2
            text                : "O   Side"
            anchors {
                top             : player2.bottom
                left            : player2.left
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
                top             : field22.top
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
                bottom          : field33.bottom
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
                top             : field33.top
                horizontalCenter: player2.horizontalCenter
            }
            font.pixelSize      : isNxt ? 50 : 40
            visible             : !player2Won
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
                horizontalCenter: field32.horizontalCenter
                bottomMargin    : margin
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 40 : 32
            visible             : (!winner && fieldsFilled == 9)
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
            buttonText          : "Reset Game"
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
                resetgame()
            }
        }
    
// --------------------------------------------------

        YaLabel {
            id                  : field11
            buttonText          : ""
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : field12.top
                right           : field12.left
                rightMargin     : margin
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                check(11)
            }
        }
    
        YaLabel {
            id                  : field12
            buttonText          : ""
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : parent.top
                horizontalCenter: parent.horizontalCenter
                topMargin       : margin * 2
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize : isNxt ? 60 : 48
            onClicked: {
                check(12)
            }
        }
    
        YaLabel {
            id                  : field13
            buttonText          : ""
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : field12.top
                left            : field12.right
                leftMargin      : margin
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                check(13)
            }
        }
    
        YaLabel {
            id                  : field21
            buttonText          : ""
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : field22.top
                right           : field22.left
                rightMargin     : margin
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                check(21)
            }
        }
    
        YaLabel {
            id                  : field22
            buttonText          : ""
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : field12.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin       : margin
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                check(22)
            }
        }
    
        YaLabel {
            id                  : field23
            buttonText          : ""
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : field22.top
                left            : field22.right
                leftMargin      : margin
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                check(23)
            }
        }
    
        YaLabel {
            id                  : field31
            buttonText          : ""
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : field32.top
                right           : field32.left
                rightMargin     : margin
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                check(31)
            }
        }
    
        YaLabel {
            id                  : field32
            buttonText          : ""
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : field22.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin       : margin
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                check(32)
            }
        }
    
        YaLabel {
            id                  : field33
            buttonText          : ""
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : field32.top
                left            : field32.right
                leftMargin      : margin
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                check(33)
            }
        }

// --------------------------------------------------

    }    
}

