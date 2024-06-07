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
        console.log("r1 x: " + r1.x + " r2 x: " + r2.x)
        return !(
            r1.x + r1.width < r2.x ||
            r2.x + r2.width < r1.x ||
            r1.y + r1.height < r2.y ||
            r2.y + r2.height < r1.y
        );
    }

    onIs_jumpingChanged: {
        if (is_jumping) {
            rex.rexRunAnimation.running = false;
        } else {
            rex.rexRunAnimation.running = true;
        }
    }

    onTimeSpendChanged: {

    }

    Timer {
        id: gameTime
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            mainWindow.timeSpend += 1
        }
    }

    Timer {
        id: colisionCheck
        interval: 200
        running: true
        repeat: true
        onTriggered: {
            if (checkCollision(rex, cactus) === true) {
                console.log("!!!!Colision!!!!")
                mainWindow.gameOver = true
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

        }

        Cactus {
            id: cactus
        }


        Rex {
            id: rex
        }

        GameInfo {
            multiplier: timeSpend
        }

        focus: true
        Keys.onPressed: {
            if (!mainWindow.gamePaused) {
                if (event.key === Qt.Key_Space) {
                    if (!rex.rexJumpAnimation.running) {
                        rex.rexJumpAnimation.start()
                    }
                }
                if (event.key === Qt.Key_Down) {
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
