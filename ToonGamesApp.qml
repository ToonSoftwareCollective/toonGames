import QtQuick 2.1
import qb.components 1.0
import qb.base 1.0;

App {

    property url                tileUrl                 : "ToonGamesTile.qml"
    property ToonGamesTile      toonGamesTile

    property url                toonGamesTicTacToeUrl   : "ToonGamesTicTacToe.qml"
    property ToonGamesTicTacToe toonGamesTicTacToe

    property url                toonGamesSlideUrl       : "ToonGamesSlide.qml"
    property ToonGamesSlide     toonGamesSlide

    property url                toonGamesMemoryUrl      : "ToonGamesMemory.qml"
    property ToonGamesMemory    toonGamesMemory

    property url                toonGames4InARowUrl     : "ToonGames4InARow.qml"
    property ToonGames4InARow   toonGames4InARow

    property url                toonGamesHangmanUrl     : "ToonGamesHangman.qml"
    property ToonGamesHangman   toonGamesHangman

    property url                toonGamesMinesUrl       : "ToonGamesMines.qml"
    property ToonGamesMines     toonGamesMines

    property url                toonGamesNumbersUrl     : "ToonGamesNumbers.qml"
    property ToonGamesNumbers   toonGamesNumbers

    property url 		        toonGamesBalloonUrl 	: "ToonGamesBalloon.qml"
    property ToonGamesBalloon   toonGamesBalloon

    property url                toonGamesInfoUrl        : "ToonGamesInfo.qml"
    property ToonGamesInfo      toonGamesInfo

    function init() {

        const args = {
            thumbCategory       : "general",
            thumbLabel          : "Toon Games",
            thumbIcon           : "qrc:/tsc/BalloonIcon.png",
            thumbIconVAlignment : "center",
            thumbWeight         : 30
        }

        registry.registerWidget("tile",   tileUrl,               this, "toonGamesTile", args);

        registry.registerWidget("screen", toonGamesTicTacToeUrl, this, "toonGamesTicTacToe");

        registry.registerWidget("screen", toonGamesSlideUrl,     this, "toonGamesSlide");

        registry.registerWidget("screen", toonGamesMemoryUrl,    this, "toonGamesMemory");

        registry.registerWidget("screen", toonGames4InARowUrl,   this, "toonGames4InARow");

        registry.registerWidget("screen", toonGamesHangmanUrl,   this, "toonGamesHangman");

        registry.registerWidget("screen", toonGamesMinesUrl,     this, "toonGamesMines");

        registry.registerWidget("screen", toonGamesNumbersUrl,   this, "toonGamesNumbers");
        
        registry.registerWidget("screen", toonGamesBalloonUrl,   this, "toonGamesBalloon");        

        registry.registerWidget("screen", toonGamesInfoUrl,      this, "toonGamesInfo");

    }

}
