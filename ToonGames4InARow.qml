/*

Memory

Version 1.0.0 
Play 4 in a row

*/

import QtQuick 2.1
import qb.components 1.0
import BasicUIControls 1.0

Screen {
    id                          : toonGames4InARow
    screenTitle                 : qsTr(me)

// ---------------------------------------------------------------------

    property string me          : "                              Toon 4 In A Row\nPick a coin and drop it in the rack to get 4 in a row."

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
    
    property int fieldsFilled   : 0

    property int player1Score   : 0
    property int player2Score   : 0
    
    property int buttonHeight   : isNxt ? 40 : 32
//    property int buttonWidth    : isNxt ? 225 : 180
    property int buttonWidth    : isNxt ? 200 : 160

    property int diskSize       : isNxt ? 50 : 40
    property int diskRadius     : diskSize / 2
    property int diskMargin     : isNxt ? 10 : 8
    
    property int fieldHeight    : isNxt ? 100 : 80
    property int fieldWidth     : isNxt ? 100 : 80
    
    property int margin         : isNxt ? 30 : 24


    property variant stackHeight: [ -1, -1, -1, -1, -1, -1, -1, ]
    property variant playField  : [ 
    [ "green" , "green", "green", "green", "green", "green" ] , 
    [ "green" , "green", "green", "green", "green", "green" ] , 
    [ "green" , "green", "green", "green", "green", "green" ] , 
    [ "green" , "green", "green", "green", "green", "green" ] , 
    [ "green" , "green", "green", "green", "green", "green" ] , 
    [ "green" , "green", "green", "green", "green", "green" ] , 
    [ "green" , "green", "green", "green", "green", "green" ] ]

    property bool playEnabled

// --------------------------------------------------------------------- 
    
    onVisibleChanged: {
        if (visible) {
            playEnabled = false
            player1.buttonText = player1Name
            player2.buttonText = player2Name
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

        playEnabled = false
        player1Active = (lastWinner == 1)
        player2Active = ! player1Active
        player1Go.buttonSelectedColor = color1
        player2Go.buttonSelectedColor = color2
        stackHeight=[ -1, -1, -1, -1, -1, -1, -1, ]
        playField = [ [ "green" , "green", "green", "green", "green", "green" ] , [ "green" , "green", "green", "green", "green", "green" ] , [ "green" , "green", "green", "green", "green", "green" ] , [ "green" , "green", "green", "green", "green", "green" ] , [ "green" , "green", "green", "green", "green", "green" ] , [ "green" , "green", "green", "green", "green", "green" ] , [ "green" , "green", "green", "green", "green", "green" ] ]
        fieldsFilled = 0
        resetGame.buttonText = "Reset Game"
        disk00.buttonActiveColor = color0 ; disk01.buttonActiveColor = color0; disk02.buttonActiveColor = color0; disk03.buttonActiveColor = color0; disk04.buttonActiveColor = color0; disk05.buttonActiveColor = color0
        disk10.buttonActiveColor = color0 ; disk11.buttonActiveColor = color0; disk12.buttonActiveColor = color0; disk13.buttonActiveColor = color0; disk14.buttonActiveColor = color0; disk15.buttonActiveColor = color0
        disk20.buttonActiveColor = color0 ; disk21.buttonActiveColor = color0; disk22.buttonActiveColor = color0; disk23.buttonActiveColor = color0; disk24.buttonActiveColor = color0; disk25.buttonActiveColor = color0
        disk30.buttonActiveColor = color0 ; disk31.buttonActiveColor = color0; disk32.buttonActiveColor = color0; disk33.buttonActiveColor = color0; disk34.buttonActiveColor = color0; disk35.buttonActiveColor = color0
        disk40.buttonActiveColor = color0 ; disk41.buttonActiveColor = color0; disk42.buttonActiveColor = color0; disk43.buttonActiveColor = color0; disk44.buttonActiveColor = color0; disk45.buttonActiveColor = color0
        disk50.buttonActiveColor = color0 ; disk51.buttonActiveColor = color0; disk52.buttonActiveColor = color0; disk53.buttonActiveColor = color0; disk54.buttonActiveColor = color0; disk55.buttonActiveColor = color0
        disk60.buttonActiveColor = color0 ; disk61.buttonActiveColor = color0; disk62.buttonActiveColor = color0; disk63.buttonActiveColor = color0; disk64.buttonActiveColor = color0; disk65.buttonActiveColor = color0

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

    function dropDisk(x , y ) {
    
        if(stackHeight[x] < 5) {
            playEnabled = false
//            log('dropDisk button x: '+ x +  ' y: ' + y )
            stackHeight[x] = stackHeight[x] + 1
            var diskColor = color1 ; if (player2Active) { diskColor=color2 }
//            log('dropDisk fill   x: '+ x +  ' y: ' + stackHeight[x] )
            playField[x][stackHeight[x]] = diskColor
//            log('dropDisk fill   x: '+ x +  ' y: ' + stackHeight[x] +' field: '+playField)
            if ( x == 0 && stackHeight[x] == 0 ) ( disk00.buttonActiveColor = diskColor )
            if ( x == 0 && stackHeight[x] == 1 ) ( disk01.buttonActiveColor = diskColor )
            if ( x == 0 && stackHeight[x] == 2 ) ( disk02.buttonActiveColor = diskColor )
            if ( x == 0 && stackHeight[x] == 3 ) ( disk03.buttonActiveColor = diskColor )
            if ( x == 0 && stackHeight[x] == 4 ) ( disk04.buttonActiveColor = diskColor )
            if ( x == 0 && stackHeight[x] == 5 ) ( disk05.buttonActiveColor = diskColor )
            if ( x == 1 && stackHeight[x] == 0 ) ( disk10.buttonActiveColor = diskColor )
            if ( x == 1 && stackHeight[x] == 1 ) ( disk11.buttonActiveColor = diskColor )
            if ( x == 1 && stackHeight[x] == 2 ) ( disk12.buttonActiveColor = diskColor )
            if ( x == 1 && stackHeight[x] == 3 ) ( disk13.buttonActiveColor = diskColor )
            if ( x == 1 && stackHeight[x] == 4 ) ( disk14.buttonActiveColor = diskColor )
            if ( x == 1 && stackHeight[x] == 5 ) ( disk15.buttonActiveColor = diskColor )
            if ( x == 2 && stackHeight[x] == 0 ) ( disk20.buttonActiveColor = diskColor )
            if ( x == 2 && stackHeight[x] == 1 ) ( disk21.buttonActiveColor = diskColor )
            if ( x == 2 && stackHeight[x] == 2 ) ( disk22.buttonActiveColor = diskColor )
            if ( x == 2 && stackHeight[x] == 3 ) ( disk23.buttonActiveColor = diskColor )
            if ( x == 2 && stackHeight[x] == 4 ) ( disk24.buttonActiveColor = diskColor )
            if ( x == 2 && stackHeight[x] == 5 ) ( disk25.buttonActiveColor = diskColor )
            if ( x == 3 && stackHeight[x] == 0 ) ( disk30.buttonActiveColor = diskColor )
            if ( x == 3 && stackHeight[x] == 1 ) ( disk31.buttonActiveColor = diskColor )
            if ( x == 3 && stackHeight[x] == 2 ) ( disk32.buttonActiveColor = diskColor )
            if ( x == 3 && stackHeight[x] == 3 ) ( disk33.buttonActiveColor = diskColor )
            if ( x == 3 && stackHeight[x] == 4 ) ( disk34.buttonActiveColor = diskColor )
            if ( x == 3 && stackHeight[x] == 5 ) ( disk35.buttonActiveColor = diskColor )
            if ( x == 4 && stackHeight[x] == 0 ) ( disk40.buttonActiveColor = diskColor )
            if ( x == 4 && stackHeight[x] == 1 ) ( disk41.buttonActiveColor = diskColor )
            if ( x == 4 && stackHeight[x] == 2 ) ( disk42.buttonActiveColor = diskColor )
            if ( x == 4 && stackHeight[x] == 3 ) ( disk43.buttonActiveColor = diskColor )
            if ( x == 4 && stackHeight[x] == 4 ) ( disk44.buttonActiveColor = diskColor )
            if ( x == 4 && stackHeight[x] == 5 ) ( disk45.buttonActiveColor = diskColor )
            if ( x == 5 && stackHeight[x] == 0 ) ( disk50.buttonActiveColor = diskColor )
            if ( x == 5 && stackHeight[x] == 1 ) ( disk51.buttonActiveColor = diskColor )
            if ( x == 5 && stackHeight[x] == 2 ) ( disk52.buttonActiveColor = diskColor )
            if ( x == 5 && stackHeight[x] == 3 ) ( disk53.buttonActiveColor = diskColor )
            if ( x == 5 && stackHeight[x] == 4 ) ( disk54.buttonActiveColor = diskColor )
            if ( x == 5 && stackHeight[x] == 5 ) ( disk55.buttonActiveColor = diskColor )
            if ( x == 6 && stackHeight[x] == 0 ) ( disk60.buttonActiveColor = diskColor )
            if ( x == 6 && stackHeight[x] == 1 ) ( disk61.buttonActiveColor = diskColor )
            if ( x == 6 && stackHeight[x] == 2 ) ( disk62.buttonActiveColor = diskColor )
            if ( x == 6 && stackHeight[x] == 3 ) ( disk63.buttonActiveColor = diskColor )
            if ( x == 6 && stackHeight[x] == 4 ) ( disk64.buttonActiveColor = diskColor )
            if ( x == 6 && stackHeight[x] == 5 ) ( disk65.buttonActiveColor = diskColor )
            fieldsFilled = fieldsFilled + 1
            
            winner = checkWinner(x , stackHeight[x])

            if (winner) {
                player1Won = player1Active
                player2Won = player2Active
                if (player1Won) { player1Score = player1Score + 1} else { player2Score = player2Score + 1}
                player1Active = false
                player2Active = false
                resetGame.buttonText = "New Game"
            } else {
                player2Active = player1Active
                player1Active = !player1Active
                if (player1Active) player1Go.buttonSelectedColor = color1
                if (player2Active) player2Go.buttonSelectedColor = color2
                if (fieldsFilled == 42) { resetGame.buttonText = "New Game" }

            }

//        } else {
//            log('stackHeight full :'+ x)
        }
    }

//--------------------------------------------------------  check winner
    
    function checkWinner(x, y) {

//        log('check winner x: '+ x + ' y: '+y)
        var color = playField[x][y]
        var resultYES = false
        var counter   = 0
        var posX      = 0
        var posY      = 0
        var xMin = 0
        var xMax = 0
        var yMin = 0
        var yMax = 0
        
//--------------------------- | vertical check -------------------------

        counter   = 0

//        log('check winner | '+color)

        yMax = y
        yMin = Math.max(0, y - 3)
        
        for ( posY = yMin ; posY <= yMax ; posY++) {
//            log(' check | x: ' + x + '  posY: ' + posY + '  '+playField[x][posY])
            if (playField[x][posY] == color ) {counter = counter + 1} else {counter = 0}
        }
//        log('check winner | counter: '+ counter)
        
        resultYES = (counter > 3)

//--------------------------- - horizontal check -----------------------

        if ( ! resultYES ) {
        
            counter   = 0
            
//            log('check winner - '+color)

            xMin =Math.max(0, x - 3)
            xMax =Math.min(6, x + 3)

            for ( posX = xMin ; posX <= xMax ; posX++) {
//                log(' check - posX: ' + posX + '  y: ' + y + '  '+playField[posX][y])
                if (playField[posX][y] == color )  {counter = counter + 1} else {if (counter < 4) { counter = 0 } }
            }
//            log('check winner - counter: '+ counter)
            
            resultYES = (counter > 3)
        
        }

//--------------------------- / diagonal check 1 -----------------------

        if ( ! resultYES ) {
        
            counter   = 0
            
//            log('check winner / '+color)

            xMin = x
            yMin = y
            while ( (xMin > 0) && (yMin > 0) && ( x - xMin < 3 ) && ( y - yMin < 3 ) )  { xMin = xMin - 1 ; yMin = yMin - 1 }
            xMax = x
            yMax = y
            while ( (xMax < 6) && (yMax < 5) && ( xMax - x < 3 ) && ( yMax - y < 3 ) )  { xMax = xMax + 1 ; yMax = yMax + 1 }

//            log('check winner x: '+ x + ' y: '+y)
//            log('check winner / xMin: '+xMin+' yMin: '+yMin+' xMax: '+xMax+' yMax: '+yMax)

            posY = yMin
            
            for ( posX = xMin ; posX <= xMax ; posX++) {
//                log(' check / posX: ' + posX + '  posY: ' + posY + '  '+playField[posX][posY])

                if (playField[posX][posY] == color ) {counter = counter + 1} else {if (counter < 4) { counter = 0 } }
                
                posY = posY + 1
            }

//            log('check winner / counter: '+ counter)

            resultYES = (counter > 3)
            
        }

//--------------------------- \ diagonal check 2 -----------------------

        if ( ! resultYES ) {
        
            counter   = 0
            
//            log('check winner \\ '+color)

            xMin = x
            yMax = y
            while ( (xMin > 0) && (yMax < 5) && ( x - xMin < 3 ) && ( yMax - y < 3 ) )  { xMin = xMin - 1 ; yMax = yMax + 1 }
            xMax = x
            yMin = y
            while ( (xMax < 6) && (yMin > 0) && ( xMax - x < 3 ) && ( y - yMin < 3 ) )  { xMax = xMax + 1 ; yMin = yMin - 1 }

//            log('check winner x: '+ x + ' y: '+y)
//            log('check winner \\ xMin: '+xMin+' yMax: '+yMax+' xMax: '+xMax+' yMin: '+yMin)

            posY = yMax
            
            for ( posX = xMin ; posX <= xMax ; posX++) {
//                log(' check / posX: ' + posX + '  posY: ' + posY + '  '+playField[posX][posY])

                if (playField[posX][posY] == color ) {counter = counter + 1} else {if (counter < 4) { counter = 0 } }
                
                posY = posY - 1
            }

//            log('check winner / counter: '+ counter)

            resultYES = (counter > 3)           
             
        }
        
        return resultYES
    }
    
// ----------------------------------------------------------- rectangle

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
            id                  : player1Go
            buttonText          : "GO !"
            height              : fieldHeight
            width               : fieldWidth
            buttonBorderRadius  : fieldHeight / 2
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
            onClicked           : { player1Go.buttonSelectedColor = color0 ; playEnabled = true }
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
                bottom          : resetScores.top
                horizontalCenter: player1.horizontalCenter
            }
            pixelsizeoverride   : true
//           pixelsizeoverridesize: isNxt ? 50 : 40
           pixelsizeoverridesize: isNxt ? 45 : 36
            visible             : player1Won
        }

        Text {
            id                  : score1
            text                : player1Score
            anchors {
                bottom          : resetScores.top
                horizontalCenter: player1.horizontalCenter
                bottomMargin    : margin
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

        YaLabel {
            id                  : player2Go
            buttonText          : "GO !"
            height              : fieldHeight
            width               : fieldWidth
            buttonBorderRadius  : fieldHeight / 2
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
            onClicked           : { player2Go.buttonSelectedColor = color0 ; playEnabled = true }
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
                bottom          : resetScores.top
                horizontalCenter: player2.horizontalCenter
            }
            pixelsizeoverride   : true
//           pixelsizeoverridesize: isNxt ? 50 : 40
           pixelsizeoverridesize: isNxt ? 45 : 36
            visible             : player2Won
        }
        
        Text {
            id                  : score2
            text                : player2Score
            anchors {
                bottom          : resetScores.top
                horizontalCenter: player2.horizontalCenter
                bottomMargin    : margin
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
           pixelsizeoverridesize: isNxt ? 40 : 32
            visible             : (! winner && fieldsFilled == 42)
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
        
// ------------------------------------------------------------ blue box
        Rectangle {
                id                  : rack
                height              : 6 * ( isNxt ? 60 : 48 )
                width               :  7 * ( isNxt ? 60 : 48 )
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter  : parent.verticalCenter
                }
                color               : color4

// ------------------------------------------------------------ column 0

            YaLabel {
                id                  : disk05
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : rack.top
                    right           : disk15.left
                    topMargin       : diskMargin / 2
                    rightMargin     : diskMargin
                }
                onClicked: {
                    dropDisk(0,5)
                }
            }

            YaLabel {
                id                  : disk04
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk05.bottom
                    horizontalCenter: disk05.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(0,4)
                }
            }

            YaLabel {
                id                  : disk03
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk04.bottom
                    horizontalCenter: disk04.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(0,3)
                }
            }

            YaLabel {
                id                  : disk02
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk03.bottom
                    horizontalCenter: disk03.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(0,2)
                }
            }

            YaLabel {
                id                  : disk01
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk02.bottom
                    horizontalCenter: disk02.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(0,1)
                }
            }

            YaLabel {
                id                  : disk00
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk01.bottom
                    horizontalCenter: disk01.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(0,0)
                }
            }

// ------------------------------------------------------------ column 1

            YaLabel {
                id                  : disk15
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : rack.top
                    right           : disk25.left
                    topMargin       : diskMargin / 2
                    rightMargin     : diskMargin
                }
                onClicked: {
                    dropDisk(1,5)
                }
            }

            YaLabel {
                id                  : disk14
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk15.bottom
                    horizontalCenter: disk15.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(1,4)
                }
            }

            YaLabel {
                id                  : disk13
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk14.bottom
                    horizontalCenter: disk14.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(1,3)
                }
            }

            YaLabel {
                id                  : disk12
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk13.bottom
                    horizontalCenter: disk13.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(1,2)
                }
            }

            YaLabel {
                id                  : disk11
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk12.bottom
                    horizontalCenter: disk12.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(1,1)
                }
            }

            YaLabel {
                id                  : disk10
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk11.bottom
                    horizontalCenter: disk11.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(1,0)
                }
            }

// ------------------------------------------------------------ column 2

            YaLabel {
                id                  : disk25
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : rack.top
                    right           : disk35.left
                    topMargin       : diskMargin / 2
                    rightMargin     : diskMargin
                }
                onClicked: {
                    dropDisk(2,5)
                }
            }

            YaLabel {
                id                  : disk24
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk25.bottom
                    horizontalCenter: disk25.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(2,4)
                }
            }

            YaLabel {
                id                  : disk23
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk24.bottom
                    horizontalCenter: disk24.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(2,3)
                }
            }

            YaLabel {
                id                  : disk22
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk23.bottom
                    horizontalCenter: disk23.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(2,2)
                }
            }

            YaLabel {
                id                  : disk21
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk22.bottom
                    horizontalCenter: disk22.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(2,1)
                }
            }

            YaLabel {
                id                  : disk20
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk21.bottom
                    horizontalCenter: disk21.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(2,0)
                }
            }

// ------------------------------------------------------------ column 3

            YaLabel {
                id                  : disk35
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : rack.top
                    horizontalCenter: rack.horizontalCenter
                    topMargin       : diskMargin / 2
                }
                onClicked: {
                    dropDisk(3,5)
                }
            }

            YaLabel {
                id                  : disk34
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk35.bottom
                    horizontalCenter: disk35.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(3,4)
                }
            }

            YaLabel {
                id                  : disk33
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk34.bottom
                    horizontalCenter: disk34.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(3,3)
                }
            }

            YaLabel {
                id                  : disk32
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk33.bottom
                    horizontalCenter: disk33.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(3,2)
                }
            }

            YaLabel {
                id                  : disk31
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk32.bottom
                    horizontalCenter: disk32.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(3,1)
                }
            }

            YaLabel {
                id                  : disk30
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk31.bottom
                    horizontalCenter: disk31.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(3,0)
                }
            }

// ------------------------------------------------------------ column 4

            YaLabel {
                id                  : disk45
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : rack.top
                    left            : disk35.right
                    topMargin       : diskMargin / 2
                    leftMargin      : diskMargin
                }
                onClicked: {
                    dropDisk(4,5)
                }
            }

            YaLabel {
                id                  : disk44
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk45.bottom
                    horizontalCenter: disk45.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(4,4)
                }
            }

            YaLabel {
                id                  : disk43
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk44.bottom
                    horizontalCenter: disk44.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(4,3)
                }
            }

            YaLabel {
                id                  : disk42
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk43.bottom
                    horizontalCenter: disk43.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(4,2)
                }
            }

            YaLabel {
                id                  : disk41
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk42.bottom
                    horizontalCenter: disk42.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(4,1)
                }
            }

            YaLabel {
                id                  : disk40
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk41.bottom
                    horizontalCenter: disk41.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(4,0)
                }
            }

// ------------------------------------------------------------ column 5

            YaLabel {
                id                  : disk55
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : rack.top
                    left            : disk45.right
                    topMargin       : diskMargin / 2
                    leftMargin      : diskMargin
                }
                onClicked: {
                    dropDisk(5,5)
                }
            }

            YaLabel {
                id                  : disk54
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk55.bottom
                    horizontalCenter: disk55.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(5,4)
                }
            }

            YaLabel {
                id                  : disk53
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk54.bottom
                    horizontalCenter: disk54.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(5,3)
                }
            }

            YaLabel {
                id                  : disk52
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk53.bottom
                    horizontalCenter: disk53.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(5,2)
                }
            }

            YaLabel {
                id                  : disk51
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk52.bottom
                    horizontalCenter: disk52.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(5,1)
                }
            }

            YaLabel {
                id                  : disk50
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk51.bottom
                    horizontalCenter: disk51.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(5,0)
                }
            }

// ------------------------------------------------------------ column 6

            YaLabel {
                id                  : disk65
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : rack.top
                    left            : disk55.right
                    topMargin       : diskMargin / 2
                    leftMargin      : diskMargin
                }
                onClicked: {
                    dropDisk(6,5)
                }
            }

            YaLabel {
                id                  : disk64
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk65.bottom
                    horizontalCenter: disk65.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(6,4)
                }
            }

            YaLabel {
                id                  : disk63
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk64.bottom
                    horizontalCenter: disk64.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(6,3)
                }
            }

            YaLabel {
                id                  : disk62
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk63.bottom
                    horizontalCenter: disk63.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(6,2)
                }
            }

            YaLabel {
                id                  : disk61
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk62.bottom
                    horizontalCenter: disk62.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(6,1)
                }
            }

            YaLabel {
                id                  : disk60
                buttonText          : ""
                height              : diskSize
                width               : diskSize
                buttonActiveColor   : color0
                buttonHoverColor    : buttonActiveColor
                buttonSelectedColor : buttonActiveColor
                buttonDisabledColor : buttonActiveColor
                selected            : false
                enabled             : playEnabled
                textColor           : colortxt
                buttonBorderRadius  : diskRadius
                anchors {
                    top             : disk61.bottom
                    horizontalCenter: disk61.horizontalCenter
                    topMargin       : diskMargin
                }
                onClicked: {
                    dropDisk(6,0)
                }
            }

        }
    
// -------------------------------------------------------- end blue box

    }    

}
