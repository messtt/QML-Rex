import QtQuick 2.15
import QtQuick.Controls 2.15
import QtMultimedia 5.15

Rectangle {
    id: gameInfos
    height: 30
    width: parent.width
    color: "transparent"

    property int timeElapsed: 0
    property string highScore: "0"
    property string currScore: "00000"
    property int multiplier: 0
    property bool gameOver: false
    property bool restart: false

    function getHighScore()
    {
        console.log("getHighScore")
        var str = backend.readInFile(":/save/save.txt")
        if (str === "" || str === "\n") {
            highScore = "0"
        }
        highScore = str
    }

    function saveScore(score, timeElapsed)
    {
        var high = parseInt(highScore, 10);
        if (high > timeElapsed) {
            return;
        }
        console.log("Score saved")
        var newScore = score.toString();
        backend.writeToFile(":/save/save.txt", newScore);
    }

    Audio {
        id: pointAudio
        source: "qrc:/sounds/point.mp3"
    }

    FontLoader {
        id: rexFont
        source: "qrc:/assets/Press_Start_2P/PressStart2P-Regular.ttf"
    }

    Component.onCompleted: {
        getHighScore()
    }

    onRestartChanged: {
        console.log("end")
        if (gameOver) {
            gameOver = false
            timer.start()
            currScore = "00000"
            multiplier = 0
            timeElapsed = 0
            restart = false
        }
    }

    onMultiplierChanged: {
        if (timer.interval <= 20)
            timer.interval = 20
        else
            timer.interval = 100 - multiplier
    }

    onGameOverChanged: {
        console.log("end!!")
        if (gameOver) {
            saveScore(currScore, timeElapsed)
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
            if (gameInfos.timeElapsed % 100 === 0) {
                pointAudio.play()
            }
        }
    }

    Row {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10

        Text {
            id: highScoreText
            text: "HI " + highScore
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
                currScore = score;
                score;
            }
            font.pixelSize: 16
            font.family: rexFont.name
            color: "#535353"
        }
    }
}
