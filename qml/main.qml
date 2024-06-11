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
        return !(r1.x > r2x + r2width ||
                 r1.x + r1.width < r2x ||
                 r1.y > r2y + r2height ||
                 r1.y + r1.height < r2y);
    }

    onRestartChanged: {
        if (!restart)
            return
        console.log("game restart")
        cloud.restart = true
        roof.restart = true
        cactus.restart = true
        rex.restart = true
        gameInfo.restart = true
        gameOver = false
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
        id: colisionCheckTimer
        interval: 30
        running: true
        repeat: true
        onTriggered: {
            if (cactus.numberOfCactus <= 0) {
                return
            }
            var lastCactus = cactus.last;
            var rexPos = Qt.point(rex.x, rex.y);
            var cactusPos = Qt.point(lastCactus.x, lastCactus.y);
            if (checkCollision(rex, lastCactus.x, lastCactus.y, lastCactus.width, lastCactus.height) === false) {
                return
            }
            var result = backend.checkCollision(":/assets/rex.png", rexPos, lastCactus.source, cactusPos);
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

        Cloud {
            id: cloud
        }

        Roof {
            id: roof
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
