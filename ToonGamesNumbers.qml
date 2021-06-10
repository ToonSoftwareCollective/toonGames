/*

Numbers

Version 1.0.0 
Play Numbers

Select a snake of the same numbers and click collect.
Your score will be the count of numbers x the value of the numbers.
All selected numbers will vanish and everything on top will move down.
The last number selected however stays and gets upgraded by 1.
To cancel a selection select something else.


*/

import QtQuick 2.1
import qb.components 1.0
import BasicUIControls 1.0

Screen {
    id                          : toonGamesSlide
    screenTitle                 : qsTr(me)

// ---------------------------------------------------------------------

    property string me          : "                                                        Toon Numbers\n      Collect snake of same numbers, last gets upgraded, others fall down."
    
    property string colortxt    : "black"
    property string color0      : "green"
    property string color1      : "red"
    property string color2      : "yellow"
    property string color3      : "lightgrey"
    property string color4      : "cyan"

    property string f00color ; property string f01color ; property string f02color ; property string f03color ; property string f04color
    property string f10color ; property string f11color ; property string f12color ; property string f13color ; property string f14color
    property string f20color ; property string f21color ; property string f22color ; property string f23color ; property string f24color
    property string f30color ; property string f31color ; property string f32color ; property string f33color ; property string f34color
    property string f40color ; property string f41color ; property string f42color ; property string f43color ; property string f44color

    property string f00txt ; property string f01txt ; property string f02txt ; property string f03txt ; property string f04txt
    property string f10txt ; property string f11txt ; property string f12txt ; property string f13txt ; property string f14txt
    property string f20txt ; property string f21txt ; property string f22txt ; property string f23txt ; property string f24txt
    property string f30txt ; property string f31txt ; property string f32txt ; property string f33txt ; property string f34txt
    property string f40txt ; property string f41txt ; property string f42txt ; property string f43txt ; property string f44txt

    property bool f00enabled ; property bool f01enabled ; property bool f02enabled ; property bool f03enabled ; property bool f04enabled
    property bool f10enabled ; property bool f11enabled ; property bool f12enabled ; property bool f13enabled ; property bool f14enabled
    property bool f20enabled ; property bool f21enabled ; property bool f22enabled ; property bool f23enabled ; property bool f24enabled
    property bool f30enabled ; property bool f31enabled ; property bool f32enabled ; property bool f33enabled ; property bool f34enabled
    property bool f40enabled ; property bool f41enabled ; property bool f42enabled ; property bool f43enabled ; property bool f44enabled

    property int buttonHeight   : isNxt ? 40 : 32
//    property int buttonWidth    : isNxt ? 150 : 120
    property int buttonWidth    : isNxt ? 200 : 160

    property int margin         : isNxt ? 30 : 24

    property int whiteBoxHeight : isNxt ? 410 : 352
//    property int whiteBoxWidth  : isNxt ? 550 : 440
    property int whiteBoxWidth  : isNxt ? 450 : 360

    property int fieldMargin    : isNxt ? 10 : 8

    property int fieldHeight    : whiteBoxHeight / 5 - fieldMargin
    property int fieldWidth     : whiteBoxWidth  / 5 - fieldMargin

    property int bestScore      : 0
    property int scoreCount     : 0

    property bool initialised   : false
    
    property variant fieldValues
    property variant clickedFields
    property int lastClicked
    
    property bool selectionOke
    property bool collectable
    property bool newBestscore

    property int maxFieldValue
    
    property variant fieldColors:[  "brown", "cyan", "yellow", "orange", "red", "purple", "blue", "lime", "white", "grey", "pink", "brown", "cyan", "yellow", "orange", "red", "purple", "blue", "lime", "white", "grey", "pink", "brown", "cyan", "yellow", "orange", "red", "purple", "blue", "lime", "white", "grey", "pink" ]
    
// ---------------------------------------------------------------------

    onVisibleChanged: {
        if (visible) {
            if (! initialised ) {
                resetscores()
                initialised = true
            }
        }
    }

// ---------------------------------------------------------------------

    function log(tolog) {
        console.log(me + ' games : ' + tolog.toString())
    }

// ---------------------------------------------------------------------

    function resetscores() {
//        resetGame.buttonText = "Reset Game"
        resetgame()
        bestScore = 0
    }
    
// ---------------------------------------------------------------------

    function resetgame() {
            
        scoreCount = 0

        maxFieldValue = 0
        newBestscore = false

        fieldValues    = [  [ 0, 0, 0, 0, 0 ] , 
                            [ 0, 0, 0, 0, 0 ] ,
                            [ 0, 0, 0, 0, 0 ] ,
                            [ 0, 0, 0, 0, 0 ] ,
                            [ 0, 0, 0, 0, 0 ] ]
        
        for ( var x = 0 ; x <=4 ; x++ ) {
            for ( var y = 0 ; y <=4 ; y++ ) {
                var number=Math.floor(Math.random() * 2.5 ) + 1
                if (number > maxFieldValue) { maxFieldValue = number }
                fillField(x, y, number)
            }        
        }
//        log('fieldValues : '+fieldValues)

        resetFields()
    }

// ---------------------------------------------------------------------

    function resetFields() {

// stack of coordinates with selected fields

        clickedFields = [  [ -1, -1 ] , [ -1, -1 ] , [ -1, -1 ] , [ -1, -1 ] , [ -1, -1 ] ,
                           [ -1, -1 ] , [ -1, -1 ] , [ -1, -1 ] , [ -1, -1 ] , [ -1, -1 ] ,
                           [ -1, -1 ] , [ -1, -1 ] , [ -1, -1 ] , [ -1, -1 ] , [ -1, -1 ] ,
                           [ -1, -1 ] , [ -1, -1 ] , [ -1, -1 ] , [ -1, -1 ] , [ -1, -1 ] ,
                           [ -1, -1 ] , [ -1, -1 ] , [ -1, -1 ] , [ -1, -1 ] , [ -1, -1 ] ]
        
        lastClicked = -1
        
        selectionOke = true
        collectable = false
        
        f00enabled = true ; f01enabled = true ; f02enabled = true ; f03enabled = true ; f04enabled = true
        f10enabled = true ; f11enabled = true ; f12enabled = true ; f13enabled = true ; f14enabled = true
        f20enabled = true ; f21enabled = true ; f22enabled = true ; f23enabled = true ; f24enabled = true
        f30enabled = true ; f31enabled = true ; f32enabled = true ; f33enabled = true ; f34enabled = true
        f40enabled = true ; f41enabled = true ; f42enabled = true ; f43enabled = true ; f44enabled = true
        
    }

// ---------------------------------------------------------------------

    function fillField(x , y , number) {
        
        fieldValues[x][y] = number
        
        switch(x) {
            case 0:
                switch(y) {
                case 0: f00txt = number ; f00color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                case 1: f01txt = number ; f01color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                case 2: f02txt = number ; f02color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                case 3: f03txt = number ; f03color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                case 4: f04txt = number ; f04color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                } break;
            case 1:
                switch(y) {
                case 0: f10txt = number ; f10color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                case 1: f11txt = number ; f11color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                case 2: f12txt = number ; f12color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                case 3: f13txt = number ; f13color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                case 4: f14txt = number ; f14color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                } break;
            case 2:
                switch(y) {
                case 0: f20txt = number ; f20color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                case 1: f21txt = number ; f21color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                case 2: f22txt = number ; f22color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                case 3: f23txt = number ; f23color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                case 4: f24txt = number ; f24color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                } break;
            case 3:
                switch(y) {
                case 0: f30txt = number ; f30color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                case 1: f31txt = number ; f31color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                case 2: f32txt = number ; f32color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                case 3: f33txt = number ; f33color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                case 4: f34txt = number ; f34color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                } break;
            case 4:
                switch(y) {
                case 0: f40txt = number ; f40color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                case 1: f41txt = number ; f41color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                case 2: f42txt = number ; f42color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                case 3: f43txt = number ; f43color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                case 4: f44txt = number ; f44color = fieldColors[ Math.max(0, number - 1 ) ] ; break;
                } break;
        }
    }

// ---------------------------------------------------------------------

    function fieldClicked(x , y) {

        newBestscore = false
    
//        log('You clicked : x: ' +x+ ' y: '+y )

        selectionOke = true
        
        if ( lastClicked > -1 ) {

            var prevX = clickedFields[lastClicked][0]
            var prevY = clickedFields[lastClicked][1]

// oke if value the same and neighbour field in x and y directions
            
            selectionOke = (fieldValues[x][y] == fieldValues[prevX][prevY]) &&
                            ( ( x == prevX && ((y == prevY - 1 ) || (y == prevY + 1 )) ) ||
                              ( y == prevY && ((x == prevX - 1 ) || (x == prevX + 1 )) ) )
        }
        
        if ( ! selectionOke ) { 
//            log('selection not oke with previous one so you started a new selection') ; 
            resetFields() 
        }
        
        lastClicked = lastClicked + 1
        clickedFields[lastClicked] = [x , y]

        disableField( x, y)
        
        collectable = ( lastClicked > 1 )  || ( ( lastClicked == 1 ) && (fieldValues[x][y] > 3 ) )

//        log('clickedFields : '+clickedFields)
    }

// ---------------------------------------------------------------------

    function collect() {
        
        if (collectable) {
            
            var lastX = clickedFields[lastClicked][0]
            var lastY = clickedFields[lastClicked][1]
            
            var fieldValue = fieldValues[lastX][lastY]

// first collect the points based on value of numbers collected and the count of the collected numbers
            
            scoreCount = scoreCount + fieldValue * (1 + lastClicked)

            newBestscore = scoreCount > bestScore
            
            if (newBestscore ) { bestScore = scoreCount }

// increment value in last field
            
            fillField(lastX , lastY , fieldValue + 1 )

            if ( (fieldValue + 1) > maxFieldValue) { maxFieldValue = fieldValue + 1 }

// put other fields at 0 so we can drop other fields down 
            
            for ( var i = 0 ; i < lastClicked ; i++ ) {
                var x = clickedFields[i][0]
                var y = clickedFields[i][1]
                fieldValues[x][y] = 0
            }

// drop fields down and fill at top with random numbers 

            for (var x = 0 ; x<5 ; x++ ) {
//                log('check -------------------------------- column : '+x)
                while (( fieldValues[x][0] * fieldValues[x][1] * fieldValues[x][2] * fieldValues[x][3] * fieldValues[x][4] ) == 0 ) {
                    var zeros = 0
                    var y = 0
                    while ( y < 5 ) {
//                        log('check ------ row : '+y)
                        if (fieldValues[x][y] == 0 ) {
//                            log('found a 0 so we need to drop all above 1 position down (0's above will first drop and vanish by outer while)')
                            for ( var ydrop = y+1 ; ydrop <5 ; ydrop++) {
                                var dropvalue = fieldValues[x][ydrop] 
//                                log('drop x: ' + x + ' ydrop - 1: ' + (ydrop - 1) + '  value: '+dropvalue)
                                fillField ( x, ydrop - 1, dropvalue )
                            }
// now we dropped all above 1 position down, we put a new random number on top
// value is between 1 and ( highest value - 1 ) with higher probability for lower numbers 

                            var number=Math.floor(Math.pow(Math.random() , 2 ) * ( maxFieldValue - 1 ) ) + 1
//                            log('drop fill x: '+x+' y: 4  number: '+number)
                            fillField ( x, 4, number )

                        }
                        y=y+1
                    } 
                }                
            }

// prepare for next move

            resetFields()
        }
    }
    
// ---------------------------------------------------------------------

    function disableField( x, y ) {

        switch(x) {
            case 0:
                switch(y) {
                case 0: f00enabled = false ; break;
                case 1: f01enabled = false ; break;
                case 2: f02enabled = false ; break;
                case 3: f03enabled = false ; break;
                case 4: f04enabled = false ; break;
                } break;
            case 1:
                switch(y) {
                case 0: f10enabled = false ; break;
                case 1: f11enabled = false ; break;
                case 2: f12enabled = false ; break;
                case 3: f13enabled = false ; break;
                case 4: f14enabled = false ; break;
                } break;
            case 2:
                switch(y) {
                case 0: f20enabled = false ; break;
                case 1: f21enabled = false ; break;
                case 2: f22enabled = false ; break;
                case 3: f23enabled = false ; break;
                case 4: f24enabled = false ; break;
                } break;
            case 3:
                switch(y) {
                case 0: f30enabled = false ; break;
                case 1: f31enabled = false ; break;
                case 2: f32enabled = false ; break;
                case 3: f33enabled = false ; break;
                case 4: f34enabled = false ; break;
                } break;
            case 4:
                switch(y) {
                case 0: f40enabled = false ; break;
                case 1: f41enabled = false ; break;
                case 2: f42enabled = false ; break;
                case 3: f43enabled = false ; break;
                case 4: f44enabled = false ; break;
                } break;
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
            id                  : newBest1
            buttonText          : "New\n\Best"
            height              : fieldHeight
            width               : buttonWidth
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
            visible             : newBestscore
        }
    
        YaLabel {
            id                  : collectButton
            buttonText          : (collectable) ? " Select or\n   Collect" : " Select"
            height              : fieldHeight
            width               : buttonWidth
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
            onClicked: {
                collect()
            }
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
//            visible             : bestScore > 0
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
//            visible             : scoreCount > 0
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

// ----------------------------------------------------------- white box

        Rectangle {
        
            height                  : whiteBoxHeight
            width                   : whiteBoxWidth
            anchors {
                horizontalCenter    : parent.horizontalCenter
                verticalCenter      : parent.verticalCenter
            }
            color                   : color3
    

// ------------------------------------------------------------ column 0

            YaLabel {
                id                  : f04
                buttonText          : f04txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f04color
                buttonHoverColor    : f04color
                buttonSelectedColor : f04color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f04enabled
                textColor           : colortxt
                anchors {
                    bottom          : f03.top
                    horizontalCenter: f03.horizontalCenter
                    bottomMargin    : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(0 , 4) }
            }

            YaLabel {
                id                  : f03
                buttonText          : f03txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f03color
                buttonHoverColor    : f03color
                buttonSelectedColor : f03color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f03enabled
                textColor           : colortxt
                anchors {
                    bottom          : f02.top
                    horizontalCenter: f02.horizontalCenter
                    bottomMargin    : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(0 , 3) }
            }

            YaLabel {
                id                  : f02
                buttonText          : f02txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f02color
                buttonHoverColor    : f02color
                buttonSelectedColor : f02color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f02enabled
                textColor           : colortxt
                anchors {
                    bottom          : f01.top
                    horizontalCenter: f01.horizontalCenter
                    bottomMargin    : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(0 , 2) }
            }

            YaLabel {
                id                  : f01
                buttonText          : f01txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f01color
                buttonHoverColor    : f01color
                buttonSelectedColor : f01color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f01enabled
                textColor           : colortxt
                anchors {
                    bottom          : f00.top
                    horizontalCenter: f00.horizontalCenter
                    bottomMargin    : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(0 , 1) }
            }

            YaLabel {
                id                  : f00
                buttonText          : f00txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f00color
                buttonHoverColor    : f00color
                buttonSelectedColor : f00color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f00enabled
                textColor           : colortxt
                anchors {
                    bottom          : parent.bottom
                    right           : f10.left
                    bottomMargin    : fieldMargin / 2
                    rightMargin     : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(0 , 0) }
            }

// ------------------------------------------------------------ column 1

            YaLabel {
                id                  : f14
                buttonText          : f14txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f14color
                buttonHoverColor    : f14color
                buttonSelectedColor : f14color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f14enabled
                textColor           : colortxt
                anchors {
                    bottom          : f13.top
                    horizontalCenter: f13.horizontalCenter
                    bottomMargin    : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(1 , 4) }
            }

            YaLabel {
                id                  : f13
                buttonText          : f13txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f13color
                buttonHoverColor    : f13color
                buttonSelectedColor : f13color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f13enabled
                textColor           : colortxt
                anchors {
                    bottom          : f12.top
                    horizontalCenter: f12.horizontalCenter
                    bottomMargin    : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(1 , 3) }
            }

            YaLabel {
                id                  : f12
                buttonText          : f12txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f12color
                buttonHoverColor    : f12color
                buttonSelectedColor : f12color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f12enabled
                textColor           : colortxt
                anchors {
                    bottom          : f11.top
                    horizontalCenter: f11.horizontalCenter
                    bottomMargin    : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(1 , 2) }
            }

            YaLabel {
                id                  : f11
                buttonText          : f11txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f11color
                buttonHoverColor    : f11color
                buttonSelectedColor : f11color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f11enabled
                textColor           : colortxt
                anchors {
                    bottom          : f10.top
                    horizontalCenter: f10.horizontalCenter
                    bottomMargin    : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(1 , 1) }
            }

            YaLabel {
                id                  : f10
                buttonText          : f10txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f10color
                buttonHoverColor    : f10color
                buttonSelectedColor : f10color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f10enabled
                textColor           : colortxt
                anchors {
                    bottom          : parent.bottom
                    right           : f20.left
                    bottomMargin    : fieldMargin / 2
                    rightMargin     : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(1 , 0) }
            }

// ------------------------------------------------------------ column 2

            YaLabel {
                id                  : f24
                buttonText          : f24txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f24color
                buttonHoverColor    : f24color
                buttonSelectedColor : f24color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f24enabled
                textColor           : colortxt
                anchors {
                    bottom          : f23.top
                    horizontalCenter: f23.horizontalCenter
                    bottomMargin    : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(2 , 4) }
            }

            YaLabel {
                id                  : f23
                buttonText          : f23txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f23color
                buttonHoverColor    : f23color
                buttonSelectedColor : f23color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f23enabled
                textColor           : colortxt
                anchors {
                    bottom          : f22.top
                    horizontalCenter: f22.horizontalCenter
                    bottomMargin    : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(2 , 3) }
            }

            YaLabel {
                id                  : f22
                buttonText          : f22txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f22color
                buttonHoverColor    : f22color
                buttonSelectedColor : f22color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f22enabled
                textColor           : colortxt
                anchors {
                    bottom          : f21.top
                    horizontalCenter: f21.horizontalCenter
                    bottomMargin    : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(2 , 2) }
            }

            YaLabel {
                id                  : f21
                buttonText          : f21txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f21color
                buttonHoverColor    : f21color
                buttonSelectedColor : f21color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f21enabled
                textColor           : colortxt
                anchors {
                    bottom          : f20.top
                    horizontalCenter: f20.horizontalCenter
                    bottomMargin    : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(2 , 1) }
            }

            YaLabel {
                id                  : f20
                buttonText          : f20txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f20color
                buttonHoverColor    : f20color
                buttonSelectedColor : f20color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f20enabled
                textColor           : colortxt
                anchors {
                    bottom          : parent.bottom
                    horizontalCenter: parent.horizontalCenter
                    bottomMargin    : fieldMargin / 2
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(2 , 0) }
            }

// ------------------------------------------------------------ column 3

            YaLabel {
                id                  : f34
                buttonText          : f34txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f34color
                buttonHoverColor    : f34color
                buttonSelectedColor : f34color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f34enabled
                textColor           : colortxt
                anchors {
                    bottom          : f33.top
                    horizontalCenter: f33.horizontalCenter
                    bottomMargin    : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(3 , 4) }
            }

            YaLabel {
                id                  : f33
                buttonText          : f33txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f33color
                buttonHoverColor    : f33color
                buttonSelectedColor : f33color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f33enabled
                textColor           : colortxt
                anchors {
                    bottom          : f32.top
                    horizontalCenter: f32.horizontalCenter
                    bottomMargin    : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(3 , 3) }
            }

            YaLabel {
                id                  : f32
                buttonText          : f32txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f32color
                buttonHoverColor    : f32color
                buttonSelectedColor : f32color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f32enabled
                textColor           : colortxt
                anchors {
                    bottom          : f31.top
                    horizontalCenter: f31.horizontalCenter
                    bottomMargin    : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(3 , 2) }
            }

            YaLabel {
                id                  : f31
                buttonText          : f31txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f31color
                buttonHoverColor    : f31color
                buttonSelectedColor : f31color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f31enabled
                textColor           : colortxt
                anchors {
                    bottom          : f30.top
                    horizontalCenter: f30.horizontalCenter
                    bottomMargin    : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(3 , 1) }
            }

            YaLabel {
                id                  : f30
                buttonText          : f30txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f30color
                buttonHoverColor    : f30color
                buttonSelectedColor : f30color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f30enabled
                textColor           : colortxt
                anchors {
                    bottom          : parent.bottom
                    left            : f20.right
                    bottomMargin    : fieldMargin / 2
                    leftMargin      : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(3 , 0) }
            }

// ------------------------------------------------------------ column 3

            YaLabel {
                id                  : f44
                buttonText          : f44txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f44color
                buttonHoverColor    : f44color
                buttonSelectedColor : f44color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f44enabled
                textColor           : colortxt
                anchors {
                    bottom          : f43.top
                    horizontalCenter: f43.horizontalCenter
                    bottomMargin    : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(4 , 4) }
            }

            YaLabel {
                id                  : f43
                buttonText          : f43txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f43color
                buttonHoverColor    : f43color
                buttonSelectedColor : f43color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f43enabled
                textColor           : colortxt
                anchors {
                    bottom          : f42.top
                    horizontalCenter: f42.horizontalCenter
                    bottomMargin    : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(4 , 3) }
            }

            YaLabel {
                id                  : f42
                buttonText          : f42txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f42color
                buttonHoverColor    : f42color
                buttonSelectedColor : f42color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f42enabled
                textColor           : colortxt
                anchors {
                    bottom          : f41.top
                    horizontalCenter: f41.horizontalCenter
                    bottomMargin    : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(4 , 2) }
            }

            YaLabel {
                id                  : f41
                buttonText          : f41txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f41color
                buttonHoverColor    : f41color
                buttonSelectedColor : f41color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f41enabled
                textColor           : colortxt
                anchors {
                    bottom          : f40.top
                    horizontalCenter: f40.horizontalCenter
                    bottomMargin    : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(4 , 1) }
            }

            YaLabel {
                id                  : f40
                buttonText          : f40txt
                height              : fieldHeight
                width               : fieldWidth
                buttonBorderRadius  : fieldHeight / 2
                buttonActiveColor   : f40color
                buttonHoverColor    : f40color
                buttonSelectedColor : f40color
                buttonDisabledColor : color0
                selected            : false
                enabled             : f40enabled
                textColor           : colortxt
                anchors {
                    bottom          : parent.bottom
                    left            : f30.right
                    bottomMargin    : fieldMargin / 2
                    leftMargin      : fieldMargin
                }
                pixelsizeoverride   : true
               pixelsizeoverridesize: isNxt ? 60 : 48
                onClicked           : { fieldClicked(4 , 0) }
            }

// ------------------------------------------------------- end white box

        }
    }
}

