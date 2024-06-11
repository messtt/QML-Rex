import QtQuick 2.5
import QtQuick.Window 2.5

Item {
    id: cactusItem
    width: parent.width
    height: parent.height

    property bool gameOver: false
    property int multiplier: 2
    property int numberOfCactus: 0
    property var last: cactusModel.get(0)

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
                    numberOfCactus = cactusModel.count
                    last = cactusModel.get(0)
                } else {
                    cactus.x -= 1 * multiplier;
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
            var lastCactus;
            if (cactusModel.count > 0) {
                lastCactus = cactusModel.get(cactusModel.count - 1)
            }
            if (cactusModel.count <= 0 || randomCactusSpawn(1) === true && lastCactus.x < mainWindow.width / 1.5) {
                var cactusInfo = randomCactusImage();
                cactusModel.append({
                    source: cactusInfo[0],
                    width: cactusInfo[1],
                    height: cactusInfo[2],
                    x: cactusItem.width,
                    y: cactusItem.height - cactusInfo[2] - 20
                });
                numberOfCactus = cactusModel.count
                last = cactusModel.get(0)
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
