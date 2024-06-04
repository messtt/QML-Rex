import QtQuick 2.5
import QtQuick.Window 2.5
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
        color: "transparent"
        border.color: "black"
        border.width: 1

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

        // Animation pour le saut
        SequentialAnimation {
            id: jumpAnimation
            running: false
            PropertyAnimation {
                target: spriteAnimationRun
                property: "y"
                from: spriteAnimationRun.y
                to: spriteAnimationRun.y - 150
                duration: 250
                easing.type: Easing.OutQuad
            }
            PropertyAnimation {
                target: spriteAnimationRun
                property: "y"
                from: spriteAnimationRun.y - 150
                to: spriteAnimationRun.y
                duration: 250
                easing.type: Easing.InQuad
            }
        }

        SequentialAnimation {
            id: crouchiAnimation
            running: false
            PropertyAnimation {
                target: spriteAnimationRun
                property: "y"
                from: spriteAnimationRun.y
                to: game.height - 55 - 20
                duration: 150
                easing.type: Easing.OutQuad
            }
        }

        GameInfo {
            multiplier: timeSpend
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("Clic de souris dans le jeu aux coordonnées:", mouse.x, mouse.y)
            }
        }

        focus: true
        Keys.onPressed: {
            console.log("Touche pressée dans le jeu:", event.key)
            if (event.key === Qt.Key_Space) {
                if (!jumpAnimation.running) {
                    jumpAnimation.start()
                }
            }
            if (event.key === Qt.Key_Down) {
                if (jumpAnimation.running) {
                    jumpAnimation.stop()
                    crouchiAnimation.start()
                }
            }
        }

        Component.onCompleted: {
            console.log("Le jeu est chargé et prêt")
        }
    }
}
