import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: gameInfos
    height: 30
    width: parent.width
    color: "transparent"

    property int timeElapsed: 0
    property int multiplier: 0
    property bool gameOver: false

    FontLoader {
        id: rexFont
        source: "qrc:/assets/Press_Start_2P/PressStart2P-Regular.ttf"
    }

    onMultiplierChanged: {
        if (timer.interval <= 20)
            timer.interval = 20
        else
            timer.interval = 100 - multiplier
    }

    onGameOverChanged: {
        if (gameOver) {
            timer.stop()
        }
    }

    Timer {
        id: timer
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            gameInfos.timeElapsed += 1
        }
    }

    Row {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: 5

        Text {
            id: highScoreText
            text: "HI 0 "
            font.pixelSize: 16
            font.family: rexFont.name
            color: "#535353"
        }

        Text {
            id: timeText
            text: {
                var score = gameInfos.timeElapsed.toString();
                while (score.length < 5) {
                    score = "0" + score;
                }
                score;
            }
            font.pixelSize: 16
            font.family: rexFont.name
            color: "#535353"
        }
    }
}
