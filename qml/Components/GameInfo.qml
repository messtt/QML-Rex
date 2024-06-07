import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    height: 50
    width: parent.width
    color: "lightblue"
    id: gameInfos
    property int timeElapsed: 0
    property int multiplier: 0
    property bool isOver: false

    onMultiplierChanged: {
        console.log("mult: " + multiplier)
        console.log("interval: " + timer.interval)
        if (timer.interval <= 50)
            timer.interval = 50
        else
            timer.interval = 200 - multiplier
    }

    onIsOverChanged: {
        if (isOver) {
            timer.stop()
        }
    }

    Timer {
        id: timer
        interval: 200
        running: !isOver
        repeat: !isOver
        onTriggered: {
            gameInfos.timeElapsed += 1
        }
    }

    Text {
        id: timeText
        anchors.right: parent.right
        text: gameInfos.timeElapsed
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 24
    }
}
