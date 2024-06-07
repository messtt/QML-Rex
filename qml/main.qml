import QtQuick 2.5
import QtQuick.Window 2.5
import QtQuick.Controls 2.15

import "Components"

Window {
    id: mainWindow
    visible: true
    width: 1280
    height: 720
    title: "QML-Rex"

    property bool is_jumping: false
    property int timeSpend: 0
    property bool gameOver: false

    function checkCollision(r1, r2) {
        return !(r1.x + r1.width < r2.x || r2.x + r2.width < r1.x || r1.y + (r1.height / 3) < r2.y || r2.y + r2.height < r1.y);
    }

    onIs_jumpingChanged: {
        if (is_jumping) {
            rex.rexRunAnimation.running = false;
        } else {
            rex.rexRunAnimation.running = true;
        }
    }

    Timer {
        id: gameTime
        interval: 300
        running: true
        repeat: true
        onTriggered: {
            mainWindow.timeSpend += 1
            gameInfo.multiplier += 1
        }
    }

    Timer {
        id: colisionCheck
        interval: 10
        running: true
        repeat: true
        onTriggered: {
            if (checkCollision(rex, cactus) === true) {
                mainWindow.gameOver = true
                roof.isOver = true
                cactus.isOver = true
                rex.isOver = true
                gameInfo.isOver = true
                gameTime.running = false
                gameTime.stop()
                gameTime.repeat = false
            }
        }
    }

    Rectangle {
        id: game
        width: 1280
        height: 480
        anchors.centerIn: parent
        color: "transparent"
        border.color: "black"
        border.width: 1

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
            if (!mainWindow.gameOver) {
                if (event.key === Qt.Key_Space) {
                    if (!rex.rexJumpAnimation.running) {
                        rex.rexJumpAnimation.start()
                    }
                }
                if (!mainWindow.gameOver && event.key === Qt.Key_Down) {
                    if (rex.rexJumpAnimation.running) {
                        rex.rexJumpAnimation.stop()
                        rex.rexCrouchiAnimation.start()
                    }
                }
            }
        }

        Component.onCompleted: {
            console.log("Le jeu est chargé et prêt")
        }
    }

    Button {
        id: pause
        text: "restart"
        anchors.centerIn: game
        visible: mainWindow.gameOver ? true : false
        onClicked: {
            console.log("test")
        }
    }
}
