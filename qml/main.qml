import QtQuick 2.5
import QtQuick.Window 2.5
import QtQuick.Controls 2.15

import "Components"

Window {
    id: mainWindow
    visible: true
    width: 720
    height: 300
    title: "QML-Rex"

    property bool gameOver: false

    onGameOverChanged: {
        if (!gameOver)
            return
        cloud.gameOver = true
        roof.gameOver = true
        cactus.gameOver = true
        rex.gameOver = true
        gameInfo.gameOver = true
    }

    Timer {
        id: colisionCheckTimer
        interval: 10
        running: true
        repeat: true
        onTriggered: {
            if (cactus.numberOfCactus > 0) {
                var lastCactus = cactus.last;
                var rexPos = Qt.point(rex.x, rex.y);
                var CactusPos = Qt.point(lastCactus.x, lastCactus.y);
                console.log("Cactus pos x: " + lastCactus.x, " y: " + lastCactus.y)
                console.log("Rex pos x: " + rexPos.x + " y: " + rexPos.y)
                console.log("Last Cactus source: " + lastCactus.source)
                var result = backend.checkCollision(":/assets/rex.png", rexPos, lastCactus.source, CactusPos);
                if (result)
                    gameOver = true
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
                id: restart
                height: 70
                width: 75
                anchors.centerIn: parent
                source: "qrc:/assets/restart.png"
            }

            onClicked: {
                console.log("Restart image clicked")
            }
        }
    }
}
