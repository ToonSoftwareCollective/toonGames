/*

Slide

Version 1.0.0 
Play slide

*/

import QtQuick 2.1
import qb.components 1.0
import BasicUIControls 1.0

Screen {
    id                          : toonGamesSlide
    screenTitle                 : qsTr(me)

// ---------------------------------------------------------------------

    property string me          : "Slide"
    
    property string colortxt    : "black"
    property string color0      : "green"
    property string color1      : "red"
    property string color2      : "yellow"
    property string color3      : "lightgrey"
    property string color4      : "cyan"

    property int fieldHeight    : isNxt ? 110 : 88
    property int fieldWidth     : isNxt ? 150 : 120

    property int buttonHeight   : isNxt ? 40 : 32
    property int buttonWidth    : isNxt ? 150 : 120

    property int margin         : isNxt ? 30 : 24

    property bool playing       : false

    property int prevBlank      : 14
    property int nowBlank       : 14
    
    property int bestScore      : 0
    property int scoreCount     : 0

// ---------------------------------------------------------------------

    function resetscores() {
        resetGame.buttonText = "Reset Game"
        resetgame()
        bestScore = 0
    }
    
    function resetgame() {

        if ( resetGame.buttonText == "Reset Game" ) {

            resetGame.buttonText = "New Game"
            
            field41.buttonText = "1"
            field42.buttonText = "2"
            field43.buttonText = "3"
            field44.buttonText = "4"
            field31.buttonText = "5"
            field32.buttonText = "6"
            field33.buttonText = "7"
            field34.buttonText = "8"
            field21.buttonText = "9"
            field22.buttonText = "10"
            field23.buttonText = "11"
            field24.buttonText = "12"
            field11.buttonText = "13"
            field12.buttonText = "14"
            field13.buttonText = "15"
            field14.buttonText = ""

            nowBlank = 14
            prevBlank = 14

            playing = false
        } else {

            resetGame.buttonText = "Reset Game"
            for (var i = 0; i < 64; i++) { move(selectShuffle()) } 
        
            playing = true
        }
        scoreCount = 0
    }

// ---------------------------------------------------------------------

    function selectShuffle() {

        var nextPos = []
                
        if ( nowBlank == 11 ) {nextPos = [12, 21] } 
        if ( nowBlank == 12 ) {nextPos = [11, 22, 13] } 
        if ( nowBlank == 13 ) {nextPos = [12, 23, 14] } 
        if ( nowBlank == 14 ) {nextPos = [13, 24] } 

        if ( nowBlank == 21 ) {nextPos = [31, 22, 11] } 
        if ( nowBlank == 22 ) {nextPos = [21 , 32, 23, 12] } 
        if ( nowBlank == 23 ) {nextPos = [22 , 33, 24, 13] } 
        if ( nowBlank == 24 ) {nextPos = [23, 34, 14] } 

        if ( nowBlank == 31 ) {nextPos = [41, 32, 21] } 
        if ( nowBlank == 32 ) {nextPos = [31 , 42, 33, 22] } 
        if ( nowBlank == 33 ) {nextPos = [32 , 43, 34, 23] } 
        if ( nowBlank == 34 ) {nextPos = [33, 44, 24] } 

        if ( nowBlank == 41 ) {nextPos = [42, 31] } 
        if ( nowBlank == 42 ) {nextPos = [41, 32, 43] } 
        if ( nowBlank == 43 ) {nextPos = [42, 33, 44] } 
        if ( nowBlank == 44 ) {nextPos = [43, 34] } 

        var toRemove = nextPos.indexOf(prevBlank);
        
// only after first call nowBlank == 14 and prevBlank == 14 which is not in nextPos resulting in -1 : 

        if (toRemove != -1) { nextPos.splice(toRemove, 1) }

        var item = nextPos[Math.floor(Math.random() * nextPos.length)];

        return item
    }

// ---------------------------------------------------------------------

    function move(rc) {

        var curBlank = nowBlank
        switch(rc) {
            case 11 : 
                if ( field21.buttonText == "" ) { field21.buttonText = field11.buttonText ; field11.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 11}
                if ( field12.buttonText == "" ) { field12.buttonText = field11.buttonText ; field11.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 11}
                break
            case 12 : 
                if ( field11.buttonText == "" ) { field11.buttonText = field12.buttonText ; field12.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 12}
                if ( field22.buttonText == "" ) { field22.buttonText = field12.buttonText ; field12.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 12}
                if ( field13.buttonText == "" ) { field13.buttonText = field12.buttonText ; field12.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 12}
                break
            case 13 : 
                if ( field12.buttonText == "" ) { field12.buttonText = field13.buttonText ; field13.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 13}
                if ( field23.buttonText == "" ) { field23.buttonText = field13.buttonText ; field13.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 13}
                if ( field14.buttonText == "" ) { field14.buttonText = field13.buttonText ; field13.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 13}
                break
            case 14 : 
                if ( field13.buttonText == "" ) { field13.buttonText = field14.buttonText ; field14.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 14}
                if ( field24.buttonText == "" ) { field24.buttonText = field14.buttonText ; field14.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 14}
                break
            case 21 : 
                if ( field31.buttonText == "" ) { field31.buttonText = field21.buttonText ; field21.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 21}
                if ( field22.buttonText == "" ) { field22.buttonText = field21.buttonText ; field21.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 21}
                if ( field11.buttonText == "" ) { field11.buttonText = field21.buttonText ; field21.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 21}
                break
            case 22 : 
                if ( field21.buttonText == "" ) { field21.buttonText = field22.buttonText ; field22.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 22}
                if ( field32.buttonText == "" ) { field32.buttonText = field22.buttonText ; field22.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 22}
                if ( field23.buttonText == "" ) { field23.buttonText = field22.buttonText ; field22.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 22}
                if ( field12.buttonText == "" ) { field12.buttonText = field22.buttonText ; field22.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 22}
                break
            case 23 : 
                if ( field22.buttonText == "" ) { field22.buttonText = field23.buttonText ; field23.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 23}
                if ( field33.buttonText == "" ) { field33.buttonText = field23.buttonText ; field23.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 23}
                if ( field24.buttonText == "" ) { field24.buttonText = field23.buttonText ; field23.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 23}
                if ( field13.buttonText == "" ) { field13.buttonText = field23.buttonText ; field23.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 23}
                break
            case 24 : 
                if ( field23.buttonText == "" ) { field23.buttonText = field24.buttonText ; field24.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 24}
                if ( field34.buttonText == "" ) { field34.buttonText = field24.buttonText ; field24.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 24}
                if ( field14.buttonText == "" ) { field14.buttonText = field24.buttonText ; field24.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 24}
                break
            case 31 : 
                if ( field41.buttonText == "" ) { field41.buttonText = field31.buttonText ; field31.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 31}
                if ( field32.buttonText == "" ) { field32.buttonText = field31.buttonText ; field31.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 31}
                if ( field21.buttonText == "" ) { field21.buttonText = field31.buttonText ; field31.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 31}
                break
            case 32 : 
                if ( field31.buttonText == "" ) { field31.buttonText = field32.buttonText ; field32.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 32}
                if ( field42.buttonText == "" ) { field42.buttonText = field32.buttonText ; field32.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 32}
                if ( field33.buttonText == "" ) { field33.buttonText = field32.buttonText ; field32.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 32}
                if ( field22.buttonText == "" ) { field22.buttonText = field32.buttonText ; field32.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 32}
                break
            case 33 : 
                if ( field32.buttonText == "" ) { field32.buttonText = field33.buttonText ; field33.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 33}
                if ( field43.buttonText == "" ) { field43.buttonText = field33.buttonText ; field33.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 33}
                if ( field34.buttonText == "" ) { field34.buttonText = field33.buttonText ; field33.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 33}
                if ( field23.buttonText == "" ) { field23.buttonText = field33.buttonText ; field33.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 33}
                break
            case 34 : 
                if ( field33.buttonText == "" ) { field33.buttonText = field34.buttonText ; field34.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 34}
                if ( field44.buttonText == "" ) { field44.buttonText = field34.buttonText ; field34.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 34}
                if ( field24.buttonText == "" ) { field24.buttonText = field34.buttonText ; field34.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 34}
                break
            case 41 : 
                if ( field42.buttonText == "" ) { field42.buttonText = field41.buttonText ; field41.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 41}
                if ( field31.buttonText == "" ) { field31.buttonText = field41.buttonText ; field41.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 41}
                break
            case 42 : 
                if ( field41.buttonText == "" ) { field41.buttonText = field42.buttonText ; field42.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 42}
                if ( field43.buttonText == "" ) { field43.buttonText = field42.buttonText ; field42.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 42}
                if ( field32.buttonText == "" ) { field32.buttonText = field42.buttonText ; field42.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 42}
                break
            case 43 : 
                if ( field42.buttonText == "" ) { field42.buttonText = field43.buttonText ; field43.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 43}
                if ( field44.buttonText == "" ) { field44.buttonText = field43.buttonText ; field43.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 43}
                if ( field33.buttonText == "" ) { field33.buttonText = field43.buttonText ; field43.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 43}
                break
            case 44 : 
                if ( field43.buttonText == "" ) { field43.buttonText = field44.buttonText ; field44.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 44}
                if ( field34.buttonText == "" ) { field34.buttonText = field44.buttonText ; field44.buttonText = "" ; prevBlank = nowBlank ; nowBlank = 44}
                break
        }        
        if ( nowBlank != curBlank ) { scoreCount = scoreCount + 1}        
    }
    
// ---------------------------------------------------------------------

    function finished() {

        var result =
               field41.buttonText == "1"
            && field42.buttonText == "2"
            && field43.buttonText == "3"
            && field44.buttonText == "4"
            && field31.buttonText == "5"
            && field32.buttonText == "6"
            && field33.buttonText == "7"
            && field34.buttonText == "8"
            && field21.buttonText == "9"
            && field22.buttonText == "10"
            && field23.buttonText == "11"
            && field24.buttonText == "12"
            && field11.buttonText == "13"
            && field12.buttonText == "14"
            && field13.buttonText == "15"
            && field14.buttonText == ""
            
        if ( (result) && ( (scoreCount < bestScore ) || (bestScore == 0) ) ) { bestScore = scoreCount }
    
        return result    
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
            id                  : newBest1
            buttonText          : "New\n\Best"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color4
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : parent.top
                left            : parent.left
                topMargin       : margin
                leftMargin      : margin
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 25 : 20
            visible             : ! playing && (bestScore == scoreCount) && (bestScore != 0)
        }
    
        YaLabel {
            id                  : newBest2
            buttonText          : "New\n\Best"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color4
            selected            : true
            enabled             : true
            textColor           : colortxt
            anchors {
                top             : parent.top
                right           : parent.right
                topMargin       : margin
                rightMargin     : margin
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 25 : 20
            visible             : ! playing && (bestScore == scoreCount) && (bestScore != 0)
        }

        Text {
            id                  : bestScoreText
            text                : "Best\n" + bestScore
            anchors {
                left            : parent.left
                bottom          : resetScores.top
                leftMargin      : margin
                bottomMargin    : margin
            }
// Strange but 5 : 4 ratio is not oke, 5 : is better
            font.pixelSize      : isNxt ? 60 : 36
            visible             : bestScore > 0
        }
    
        Text {
            id                  : scoreCountText
            text                : "Score\n" +scoreCount
            anchors {
                right           : parent.right
                bottom          : resetGame.top
                rightMargin     : margin
                bottomMargin    : margin
            }
// Strange but 5 : 4 ratio is not oke, 5 : is better
            font.pixelSize      : isNxt ? 60 : 36
            visible             : scoreCount > 0
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
                resetgame()
            }
        }

// -------------------------------------------------- play field top row

        YaLabel {
            id                  : field41
            buttonText          : "1"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : playing
            textColor           : colortxt
            anchors {
                top             : field42.top
                right           : field42.left
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                move(41)
            }
        }
    
        YaLabel {
            id                  : field42
            buttonText          : "2"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : playing
            textColor           : colortxt
            anchors {
                top             : parent.top
                right           : parent.horizontalCenter
                topMargin       : margin
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                move(42)
            }
        }
    
        YaLabel {
            id                  : field43
            buttonText          : "3"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : playing
            textColor           : colortxt
            anchors {
                top             : field42.top
                left            : field42.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                move(43)
            }
        }
    
        YaLabel {
            id                  : field44
            buttonText          : "4"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : playing
            textColor           : colortxt
            anchors {
                top             : field43.top
                left            : field43.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                move(44)
            }
        }
    
// ---------------------------------------------------- play field row 3

        YaLabel {
            id                  : field31
            buttonText          : "5"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : playing
            textColor           : colortxt
            anchors {
                top             : field41.bottom
                right           : field41.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                move(31)
            }
        }
    
        YaLabel {
            id                  : field32
            buttonText          : "6"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : playing
            textColor           : colortxt
            anchors {
                top             : field42.bottom
                right           : field42.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                move(32)
            }
        }
    
        YaLabel {
            id                  : field33
            buttonText          : "7"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : playing
            textColor           : colortxt
            anchors {
                top             : field43.bottom
                right           : field43.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                move(33)
            }
        }
    
        YaLabel {
            id                  : field34
            buttonText          : "8"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : playing
            textColor           : colortxt
            anchors {
                top             : field44.bottom
                right           : field44.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                move(34)
            }
        }
    
// ---------------------------------------------------- play field row 2

        YaLabel {
            id                  : field21
            buttonText          : "9"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : playing
            textColor           : colortxt
            anchors {
                top             : field31.bottom
                right           : field31.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                move(21)
            }
        }
    
        YaLabel {
            id                  : field22
            buttonText          : "10"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : playing
            textColor           : colortxt
            anchors {
                top             : field32.bottom
                right           : field32.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                move(22)
            }
        }
    
        YaLabel {
            id                  : field23
            buttonText          : "11"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : playing
            textColor           : colortxt
            anchors {
                top             : field33.bottom
                right           : field33.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                move(23)
            }
        }
    
        YaLabel {
            id                  : field24
            buttonText          : "12"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : playing
            textColor           : colortxt
            anchors {
                top             : field34.bottom
                right           : field34.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                move(24)
            }
        }

// ---------------------------------------------------- play field row 1

        YaLabel {
            id                  : field11
            buttonText          : "13"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : playing
            textColor           : colortxt
            anchors {
                top             : field21.bottom
                right           : field21.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                move(11)
            }
        }
    
        YaLabel {
            id                  : field12
            buttonText          : "14"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : playing
            textColor           : colortxt
            anchors {
                top             : field22.bottom
                right           : field22.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                move(12)
            }
        }
    
        YaLabel {
            id                  : field13
            buttonText          : "15"
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : playing
            textColor           : colortxt
            anchors {
                top             : field23.bottom
                right           : field23.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                move(13)
            }
        }
    
        YaLabel {
            id                  : field14
            buttonText          : ""
            height              : fieldHeight
            width               : fieldWidth
            buttonActiveColor   : buttonSelectedColor
            buttonHoverColor    : buttonSelectedColor
            buttonSelectedColor : color3
            selected            : false
            enabled             : playing
            textColor           : colortxt
            anchors {
                top             : field24.bottom
                right           : field24.right
            }
            pixelsizeoverride   : true
           pixelsizeoverridesize: isNxt ? 60 : 48
            onClicked: {
                move(14)
                playing =  ! finished()
            }
        }

// ---------------------------------------------------------------------

    }
}

