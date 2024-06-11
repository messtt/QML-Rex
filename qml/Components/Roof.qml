import QtQuick 2.5
import QtQuick.Window 2.5

Item {
    id: roofItem
    width: parent.width
    height: parent.height
    property bool gameOver: false
    property bool restart: false
    property int multiplier: 2

    onRestartChanged: {
        if (restart) {
            gameOver = false
            moveTimer.start()
            multiplier = 2
            restart = false
        }
    }

    onGameOverChanged: {
        if (gameOver) {
            moveTimer.stop()
        }
    }

    Timer {
        id: moveTimer
        interval: 1
        repeat: true
        running: true
        onTriggered: {
            for (var i = 0; i < roofModel.count; i++) {
                var roof = roofModel.get(i);
                roof.x -= 1 * multiplier
                if (roof.x < -2404) {
                    roof.x = 2404;
                }
                roofModel.set(i, roof);
            }
        }
    }

    ListModel {
        id: roofModel
    }

    function addRoofs() {
        var height = 28;
        roofModel.append({ x: 0, y: parent.height - height - 20 });
        roofModel.append({ x: 2404, y: parent.height - height - 20 });
    }

    Component.onCompleted: {
        addRoofs();
    }

    Repeater {
        id: roofRepeater
        model: roofModel

        delegate: Image {
            id: roofImage
            source: "qrc:/assets/roof.png"
            sourceSize.width: 2404
            sourceSize.height: 28
            width: 2404
            height: 28
            y: parent.height - height - 20
            x: model.x
        }
    }
}

