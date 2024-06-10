import QtQuick 2.5
import QtQuick.Window 2.5

Item {
    id: cactusItem
    width: parent.width
    height: parent.height

    property bool isOver: false
    property int multiplier: 1

    function randomCactusSpawn(max) {
        let rand = Math.floor(Math.random() * (max + 1));
        console.log("rand: " + rand)
        if (rand === max) {
            return true;
        }
        return false;
    }

    function randomCactusImage() {
        var images = [
            ["../../assets/two_cactus.png", 60, 70],
            ["../../assets/four_cactus.png", 90, 70],
            ["../../assets/three_cactus.png", 80, 70],
            ["../../assets/two_cactus_small.png", 40, 50],
        ];
        var index = Math.floor(Math.random() * images.length);
        return images[index];
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
        interval: 500
        running: true
        onTriggered: {
            console.log("cactusSpawnTimer triggered")
            var lastCactus;
            if (cactusModel.count > 0) {
                lastCactus = cactusModel.get(cactusModel.count - 1)
                console.log("number of cactus: " + cactusModel.count)
                console.log("pos last cactus: " + lastCactus.x)
            }
            if (cactusModel.count <= 0 || randomCactusSpawn(2) === true && lastCactus.x < mainWindow.width / 1.7) {
                console.log("Spawning a new cactus")
                var cactusInfo = randomCactusImage();
                cactusModel.append({
                    source: cactusInfo[0],
                    width: cactusInfo[1],
                    height: cactusInfo[2],
                    x: cactusItem.width,
                    y: cactusItem.height - cactusInfo[2] - 20
                });
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
