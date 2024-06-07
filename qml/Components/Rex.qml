import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: rex
    width: 50
    height: 55
    color: "green"
    y: game.height - height - 22
    x: 20

    property var rexJumpAnimation: rexJumpAnimation // Exposer la propriété rexJumpAnimation
    property var rexCrouchiAnimation: rexCrouchiAnimation
    property var rexRunAnimation: rexRunAnimation
    property bool isOver: false


    onIsOverChanged: {
        if (isOver) {
            rexRunAnimation.running = false
            rexJumpAnimation.stop()
            animUp.stop()
            animDown.stop()
            rexCrouchiAnimation.stop()
            rexRunAnimation.sprites.frameCount = 1
        }
    }

    SpriteSequence {
        id: rexRunAnimation
        width: parent.width
        height: parent.height
        running: !isOver
        interpolate: false
        goalSprite: "run"
        Sprite {
            name: "run"
            source: "../../assets/offline-sprite-2x.png"
            frameCount: 2
            frameWidth: 88
            frameHeight: 93
            frameDuration: 100
            frameX: 1514
            frameY: 0
        }
    }

    SequentialAnimation {
        id: rexJumpAnimation
        running: !isOver
        PropertyAnimation {
            id: animUp
            target: rex
            property: "y"
            from: rex.y
            to: rex.y - 100
            duration: 250
            easing.type: Easing.OutQuad
        }
        PropertyAnimation {
            id: animDown
            target: rex
            property: "y"
            from: rex.y - 100
            to: rex.y
            duration: 250
            easing.type: Easing.InQuad
        }
        onRunningChanged: {
            mainWindow.is_jumping = !mainWindow.is_jumping
        }
    }

    SequentialAnimation {
        id: rexCrouchiAnimation
        running: !isOver
        PropertyAnimation {
            target: rex
            property: "y"
            from: rex.y
            to: game.height - 55 - 20
            duration: 150
            easing.type: Easing.OutQuad
        }
        onRunningChanged: {
            mainWindow.is_jumping = !mainWindow.is_jumping
        }
    }
}
