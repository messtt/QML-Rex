import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: rex
    width: 55
    height: 60
    color: "green"
    y: game.height - height - 22
    x: 20

    property var rexJumpAnimation: rexJumpAnimation
    property var rexCrouchiAnimation: rexCrouchiAnimation
    property var rexRunAnimation: rexRunAnimation
    property var speedDown: speedDown
    property bool isOver: false
    property bool isRunning: false
    property bool isCrouching: false

    onIsRunningChanged: {
        if (isRunning) {
            rexCrouchAnimation.visible = false
            rexDeathAnimation.visible = false
            rexRunAnimation.visible = true
        } else {
            rexRunAnimation.visible = false
        }
    }

    onIsCrouchingChanged: {
        console.log("crouching")
        if (isCrouching) {
            rexCrouchAnimation.visible = true
            rexDeathAnimation.visible = false
            rexRunAnimation.visible = false
            rex.width = 60
            rex.height = 50
        } else {
            rexCrouchAnimation.visible = false
        }
    }

    onIsOverChanged: {
        if (isOver) {
            rexRunAnimation.visible = false
            rexCrouchAnimation.visible = false
            rexDeathAnimation.visible = true
            rexRunAnimation.running = false
            rexJumpAnimation.stop()
            animUp.stop()
            animDown.stop()
            speedDownAnimation.stop()
            rexCrouchiAnimation.stop()
            speedDown.stop()
        }
    }

    SpriteSequence {
        id: rexRunAnimation
        width: parent.width
        height: parent.height
        running: true
        interpolate: false
        goalSprite: "run"
        Sprite {
            id: rexRunAnimationSprite
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

    SpriteSequence {
        id: rexCrouchAnimation
        width: parent.width
        height: parent.height
        running: false
        interpolate: false
        visible: false
        goalSprite: "crouch"
        Sprite {
            id: rexCrouchAnimationSprite
            name: "crouch"
            source: "../../assets/offline-sprite-2x.png"
            frameCount: 2
            frameWidth: 88
            frameHeight: 93
            frameDuration: 100
            frameX: 200
            frameY: 0
        }
    }

    SpriteSequence {
        id: rexDeathAnimation
        width: parent.width
        height: parent.height
        running: false
        interpolate: false
        visible: false
        goalSprite: "dead"
        Sprite {
            id: rexDeathAnimationSprite
            name: "dead"
            source: "../../assets/offline-sprite-2x.png"
            frameCount: 1
            frameWidth: 90
            frameHeight: 93
            frameDuration: 10000
            frameX: 1690
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
            to: rex.y - 130
            duration: 250
            easing.type: Easing.OutQuad
        }
        PropertyAnimation {
            id: animDown
            target: rex
            property: "y"
            from: rex.y - 130
            to: rex.y
            duration: 250
            easing.type: Easing.InQuad
        }
        onRunningChanged: {
            mainWindow.is_jumping = !mainWindow.is_jumping
        }
    }

    SequentialAnimation {
        id: speedDown
        running: !isOver
        PropertyAnimation {
            id: speedDownAnimation
            target: rex
            property: "y"
            from: rex.y
            to: game.height - rex.height - 20
            duration: 150
            easing.type: Easing.OutQuad
        }
        onRunningChanged: {
            mainWindow.is_jumping = !mainWindow.is_jumping
        }
    }
}
