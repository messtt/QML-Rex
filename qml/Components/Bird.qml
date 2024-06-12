import QtQuick 2.5
import QtQuick.Window 2.5

Item {
    id: birdItem
    width: parent.width
    height: parent.height

    property bool restart: false
    property bool gameOver: false
    property real multiplier: 0.0


    function randomBirdSpawn(max)
    {
        let rand = Math.floor(Math.random() * (max + 1));
        if (rand === max) {
            return true;
        }
        return false;
    }

    function randomBirdPos()
    {
        let rand = Math.floor(Math.random() * (3));
        if (rand === 0) {
            return (game.height - 70);
        } else if (rand === 1) {
            return (game.height - 100);
        } else {
            return (game.height - 130);
        }
    }

    onMultiplierChanged: {
        if (multiplier > 3)
            multiplier = 3
    }

    onRestartChanged: {
        if (restart) {
            gameOver = false
            multiplier = 0
            birdModel.clear()
            birdMoveTimer.start()
            birdSpawnTimer.start()
            restart = false
        }
    }

    onGameOverChanged: {
        if (gameOver) {
            birdMoveTimer.stop()
            birdSpawnTimer.stop()
        }
    }

    Timer {
        id: birdMoveTimer
        repeat: true
        interval: 1
        running: true
        onTriggered: {
            for (let i = 0; i < birdModel.count; i++) {
                let cactus = birdModel.get(i);
                if (cactus.x < -cactus.width) {
                    birdModel.remove(i);
                    game.lastBird = birdModel.get(birdModel.count - 1)
                    game.firstBird = birdModel.get(0)
                } else {
                    cactus.x -= 2 + multiplier;
                    birdModel.set(i, cactus);
                }
            }
        }
    }

    Timer {
        id: birdSpawnTimer
        repeat: true
        interval: 400
        running: true
        onTriggered: {
            if (birdModel.count > 0) {
                var lastBird = birdModel.get(birdModel.count - 1)
                if (lastBird.x > mainWindow.width - 400) {
                    return
                }
            }
            if (game.lastCactus !== null) {
                if (game.lastCactus.x > mainWindow.width - 400) {
                    return
                }
            }
            if (randomBirdSpawn(3) === true) {
                var pos = randomBirdPos();
                console.log("pos: " + pos);
                birdModel.append({
                    name: "bird",
                    x: birdItem.width,
                    y: pos,
                    source: "qrc:/assets/bird.png",
                    height: 30,
                    width: 70
                });
                game.lastBird = birdModel.get(birdModel.count - 1)
                game.firstBird = birdModel.get(0)
            }
        }
    }

    ListModel {
        id: birdModel
    }

    Repeater {
        id: birdRepeater
        model: birdModel
        delegate: Rectangle {
            width: 50
            height: 30
            color: "transparent"
            y: model.y
            x: model.x

            SpriteSequence {
                id: birdSpriteSequence
                width: parent.width
                height: parent.height
                running: true
                anchors.horizontalCenter: parent.horizontalCenter
                interpolate: false
                goalSprite: "fly"
                Sprite {
                    id: birdSprite
                    name: "fly"
                    source: "qrc:/assets/offline-sprite-2x.png"
                    frameCount: 2
                    frameDuration: 100
                    frameWidth: 94
                    frameHeight: 72
                    frameX: 260
                    frameY: 0
                }
            }
        }
    }
}
