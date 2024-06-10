import QtQuick 2.5
import QtQuick.Window 2.5
import QtQuick.Controls 2.15

import "Components"
import backend 1.0

Window {
    id: mainWindow
    visible: true
    width: 720
    height: 300
    title: "QML-Rex"

    property bool is_jumping: false
    property int timeSpend: 0
    property bool gameOver: false

    function checkCollision(r1, r2)
    {
        return !(r1.x + r1.width < r2.x || r2.x + r2.width < r1.x || r1.y + (r1.height / 1.5) < r2.y || r2.y + (r2.height / 3) < r1.y);
    }

    onGameOverChanged: {
        BackEnd.writeToFile("qrc:Save/save.txt", gameInfo.timeElapsed)
    }

    // onIs_jumpingChanged: {
    //     if (is_jumping || gameOver) {
    //         rex.rexRunAnimation.running = false;
    //     } else {
    //         rex.rexRunAnimation.running = true;
    //     }
    // }

    // Timer {
    //     id: gameTime
    //     interval: 300
    //     running: true
    //     repeat: true
    //     onTriggered: {
    //         mainWindow.timeSpend += 1
    //         gameInfo.multiplier += 1
    //     }
    // }

    // Timer {
    //     id: colisionCheck
    //     interval: 10
    //     running: true
    //     repeat: true
    //     onTriggered: {
    //         if (checkCollision(rex, cactus) === true) {
    //             mainWindow.gameOver = true
    //             roof.isOver = true
    //             cactus.isOver = true
    //             rex.isOver = true
    //             gameInfo.isOver = true
    //             gameTime.running = false
    //             gameTime.stop()
    //             gameTime.repeat = false
    //         }
    //     }
    // }

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

        // Rex {
        //     id: rex
        // }

        // GameInfo {
        //     id: gameInfo
        // }

    //     focus: true
    //     Keys.onPressed: {
    //         if (!mainWindow.gameOver) {
    //             if (event.key === Qt.Key_Space && event.key !== Qt.Key_Down) {
    //                 if (!rex.rexJumpAnimation.running) {
    //                     rex.rexJumpAnimation.start()
    //                 }
    //             }
    //             if (!mainWindow.gameOver && event.key === Qt.Key_Down) {
    //                 if (rex.rexJumpAnimation.running) {
    //                     rex.rexJumpAnimation.stop()
    //                     rex.speedDown.start()
    //                 }
    //                 rex.isCrouching = true
    //             }
    //         }
    //     }

    //     Keys.onReleased: {
    //         if (!mainWindow.gameOver && event.key === Qt.Key_Down) {
    //             console.log("down key release")
    //             rex.isRunning = true
    //         }
    //     }

    //     Component.onCompleted: {
    //         console.log("Le jeu est chargé et prêt")
    //     }
    }

    Rectangle {
        id: endGame
        width: 300
        height: 200
        anchors.centerIn: game
        visible: mainWindow.gameOver ? true : false
        Image {
            id: gameOverText
            height: 20
            width: parent.width
            anchors.fill: parent.Center
            source: "../assets/game_over.png"
        }
        MouseArea {
            id: restartMouseArea
            anchors.fill: parent

            Image {
                id: restart
                height: 70
                width: 80
                anchors.centerIn: parent
                source: "../assets/restart.png"
            }

            onClicked: {
                console.log("Restart image clicked")
            }
        }
    }
}

