var balloons = new Array();
var melons = new Array();

function collisionDetect() {
    for (var i = 0; i < balloons.length; i++) {
        var dart = game.getDartPosition();
        if (dart.x + 95 > balloons[i].x && dart.x < balloons[i].x)
            if (dart.y > balloons[i].y -20 && dart.y < balloons[i].y + 90)
                 balloons[i].explode();

    }

    for (var j = 0; j < melons.length; j++) {
        var dart2 = game.getDartPosition();
        if (dart2.x + 95 > melons[j].x && dart2.x < melons[j].x)
            if (dart2.y > melons[j].y  && dart2.y < melons[j].y + 100)
                 melons[j].explode();

    }
}
