import QtQuick
import QtQuick.Window
import "Components"

Window {
    id: mainWindow
    visible: true
    width: 1280
    height: 720
    title: "Jeu avec Animation de Sprites"
    property int timeSpend: 0

    Timer {
        id: timer
        interval: 1000
        running: true
        onTriggered: {
            mainWindow.timeSpend += 1
        }
    }

    Rectangle {
        id: game
        width: 1280
        height: 480
        anchors.centerIn: parent
        Rectangle {
            id: gameArea
            anchors.fill: parent
            color: "lightblue"

            Image {
                id: movingGround
                source: "../assets/roof.png"
                sourceSize.width: 2404
                sourceSize.height: 28
                width: 2404
                height: 14
                y: parent.height - height - 20

                NumberAnimation on x {
                    from: 0
                    to: -width
                    duration: 5000 // A changer car bouge en fonction de la taille de l'ecran
                    loops: Animation.Infinite
                    running: true
                }
            }

            Image {
                source: "../assets/roof.png"
                sourceSize.width: 2404
                sourceSize.height: 28
                width: 2404
                height: 14
                y: parent.height - height - 20
                x: movingGround.x + movingGround.width
            }
        }

        SpriteSequence {
            id: spriteAnimationRun
            width: 50
            height: 55
            running: true
            interpolate: false
            goalSprite: "run"
            y: parent.height - height - 22
            Sprite {
                name: "run"
                source: "../assets/offline-sprite-2x.png"
                frameCount: 2
                frameWidth: 88
                frameHeight: 93
                frameDuration: 100
                frameX: 1514
                frameY: 0

            }
        }
        GameInfo {
            multiplier: timeSpend
        }
    }
}
