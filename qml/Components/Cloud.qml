import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: parent.width
    height: parent.height

    function randomY(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }

    property int cloudCount: 0
    property bool gameOver: false

    onGameOverChanged: {
        if (gameOver) {
            cloudTimer.stop()
            moveTimer.stop()
        }
    }

    Timer {
        id: cloudTimer
        interval: 3000
        repeat: true
        running: true
        onTriggered: {
            for (var i = 0; i < cloudModel.count; i++) {
                if (cloudCount > 0) {
                    var cloud = cloudModel.get(i);
                    if (cloud.x < 0) {
                        cloudModel.remove(i);
                        cloudCount--;
                    }
                }
            }
            if (cloudCount < (mainWindow.width + mainWindow.height) / 200) {
                cloudModel.append({ x: mainWindow.width, y: randomY(0, (mainWindow.height - 100)) });
                cloudCount++;
            }
        }
    }

    Timer {
        id: moveTimer
        interval: 30
        repeat: true
        running: true
        onTriggered: {
            for (var i = 0; i < cloudModel.count; i++) {
                var cloud = cloudModel.get(i);
                cloud.x -= 2;
                if (cloud.x + 120 < 0) {
                    cloud.x = width;
                }
                cloudModel.set(i, cloud);
            }
        }
    }

    ListModel {
        id: cloudModel
    }

    Repeater {
        id: cloudRepeater
        model: cloudModel
        delegate: Image {
            id: cloudImage
            source: "qrc:/assets/cloud.png"
            x: model.x
            y: model.y
            width: 80
            height: 40
        }
    }
}
