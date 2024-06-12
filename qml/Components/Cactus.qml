import QtQuick 2.5
import QtQuick.Window 2.5

Item {
    id: cactusItem
    width: parent.width
    height: parent.height

    property bool restart: false
    property bool gameOver: false
    property real multiplier: 0.0

    function randomCactusSpawn(max) {
        let rand = Math.floor(Math.random() * (max + 1));
        if (rand === max) {
            return true;
        }
        return false;
    }

    function randomCactusImage() {
        var images = [
            ["qrc:/assets/two_cactus.png", 60, 61],
            ["qrc:/assets/four_cactus.png", 90, 59],
            ["qrc:/assets/three_cactus.png", 80, 78],
            ["qrc:/assets/two_cactus_small.png", 40, 40],
        ];
        var index = Math.floor(Math.random() * images.length);
        return images[index];
    }

    onMultiplierChanged: {
        if (multiplier > 3)
            multiplier = 3
    }

    onRestartChanged: {
        if (restart) {
            gameOver = false
            cactusModel.clear()
            multiplier = 0
            cactusMoveTimer.start()
            cactusSpawnTimer.start()
            restart = false
        }
    }

    onGameOverChanged: {
        if (gameOver) {
            cactusMoveTimer.stop()
            cactusSpawnTimer.stop()
        }
    }

    Timer {
        id: cactusMoveTimer
        repeat: true
        interval: 1
        running: true
        onTriggered: {
            for (let i = 0; i < cactusModel.count; i++) {
                let cactus = cactusModel.get(i);
                if (cactus.x < -cactus.width) {
                    cactusModel.remove(i);
                    game.firstCactus = cactusModel.get(0)
                } else {
                    cactus.x -= 2 + multiplier;
                    cactusModel.set(i, cactus);
                }
            }
        }
    }

    Timer {
        id: cactusSpawnTimer
        repeat: true
        interval: 400
        running: true
        onTriggered: {
            if (game.lastBird !== null) {
                if (game.lastBird.x > mainWindow.width - 400) {
                    return
                }
            }
            if (cactusModel.count <= 0 || randomCactusSpawn(2) === true && game.lastCactus.x < mainWindow.width - 300) {
                var cactusInfo = randomCactusImage();
                cactusModel.append({
                    name: "cactus",
                    source: cactusInfo[0],
                    width: cactusInfo[1],
                    height: cactusInfo[2],
                    x: cactusItem.width,
                    y: cactusItem.height - cactusInfo[2] - 20
                });
                game.lastCactus = cactusModel.get(cactusModel.count - 1)
                game.firstCactus = cactusModel.get(0)
            }
        }
    }

    ListModel {
        id: cactusModel
    }

    Repeater {
        id: cactusRepeater
        model: cactusModel
        delegate: Image {
            id: cactusImage
            source: model.source
            width: model.width
            height: model.height
            x: model.x
            y: model.y
        }
    }
}
