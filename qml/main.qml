import QtQuick 2.5
import QtQuick.Window 2.5
import QtMultimedia 5.15
import QtQuick.Controls 2.15

import "Components"

Window {
    id: mainWindow
    visible: true
    width: 720
    height: 300
    title: "QML-Rex"

    property bool gameOver: false
    property bool restart: false

    function checkCollision(r1, r2x, r2y, r2width, r2height)
    {
        var rexY = rex.rexStatus === "crouch" ? rex.y + 20 : rex.y
        return !(r1.x > r2x + r2width ||
                 r1.x + r1.width < r2x ||
                 rexY > r2y + r2height ||
                 r1.y + r1.height < r2y);
    }

    onRestartChanged: {
        if (!restart)
            return
        console.log("game restart")
        game.firstBird = null
        game.firstCactus = null
        game.lastBird = null
        game.lastCactus = null
        cloud.restart = true
        roof.restart = true
        cactus.restart = true
        rex.restart = true
        gameInfo.restart = true
        gameOver = false
        bird.restart = true
        restart = false
        colisionCheckTimer.start()
    }

    onGameOverChanged: {
        if (!gameOver)
            return
        cloud.gameOver = true
        roof.gameOver = true
        cactus.gameOver = true
        rex.gameOver = true
        gameInfo.gameOver = true
        colisionCheckTimer.stop()
        bird.gameOver = true
    }

    Audio {
        id: jumpAudio
        source: "qrc:/sounds/jump.mp3"
    }

    Audio {
        id: dieAudio
        source: "qrc:/sounds/die.mp3"
    }

    Timer {
        id: globalTimer
        interval: 4000
        repeat: true
        running: true
        onTriggered: {
            cactus.multiplier += 0.1
            roof.multiplier += 0.1
            bird.multiplier += 0.1
            gameInfo.multiplier += 5
        }
    }

    Timer {
        id: colisionCheckTimer
        interval: 1
        running: true
        repeat: true
        onTriggered: {
            if (game.firstBird === null && game.firstCactus === null) {
                return
            }
            var rexPos = Qt.point(rex.x, rex.y);
            var firstObstacle = null;
            if (game.firstBird === null) {
                firstObstacle = game.firstCactus
            } else if (game.firstCactus === null) {
                firstObstacle = game.firstBird
            } else if (game.firstBird.x < game.firstCactus.x) {
                firstObstacle = game.firstBird
            } else {
                firstObstacle = game.firstCactus
            }

            var obstaclePos = Qt.point(firstObstacle.x, firstObstacle.y);
            if (checkCollision(rex, firstObstacle.x, firstObstacle.y, firstObstacle.width, firstObstacle.height) === false) {
                return
            }
            console.log("collision!!!")
            var result = backend.checkCollision(":/assets/rex.png", rexPos, firstObstacle.source, obstaclePos);
            if (result) {
                dieAudio.play()
                gameOver = true;
            }
        }
    }

    Rectangle {
        id: game
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        color: "transparent"
        border.color: "black"
        border.width: 1

        property var lastBird: null
        property var firstBird: null

        property var lastCactus: null
        property var firstCactus: null

        Cloud {
            id: cloud
        }

        Roof {
            id: roof
        }

        Bird {
            id: bird
        }

        Cactus {
            id: cactus
        }

        Rex {
            id: rex
        }

        GameInfo {
            id: gameInfo
        }

        focus: true
        Keys.onPressed: {
            if(mainWindow.gameOver)
                return
            rex.currKeyPress = event.key
            if (event.key === Qt.Key_Space || event.key === Qt.Key_Up) {
                console.log("jump key press")
                rex.rexStatus = "jump"
                jumpAudio.play()
            } else if (event.key === Qt.Key_Down && !event.isAutoRepeat) {
                rex.rexStatus = "crouch"
            }
        }

        Keys.onReleased: {
            if(mainWindow.gameOver)
                return
            if (event.key === Qt.Key_Down && !event.isAutoRepeat) {
                rex.currKeyPress = 0
                rex.rexStatus = "run"
            }
        }

        Component.onCompleted: {
            console.log("Le jeu est chargé et prêt")
        }
    }

    Rectangle {
        id: endGame
        width: 300
        height: 200
        color: "transparent"
        anchors.centerIn: game
        visible: mainWindow.gameOver
        Image {
            id: gameOverText
            height: 20
            width: parent.width
            anchors.fill: parent.Center
            source: "qrc:/assets/game_over.png"
        }
        MouseArea {
            id: restartMouseArea
            anchors.fill: parent

            Image {
                id: restartImage
                height: 70
                width: 75
                anchors.centerIn: parent
                source: "qrc:/assets/restart.png"
            }

            onClicked: {
                console.log("Restart image clicked")
                restart = true
            }
        }
    }
}
