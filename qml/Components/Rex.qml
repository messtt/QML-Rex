import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: rexRectangle
    width: 55
    height: 60
    color: "blue"

    // color: "transparent"
    x: 20
    y: game.height - height - 25

    property string rexStatus: "run"
    property int currKeyPress: 0
    property bool gameOver: false

    onGameOverChanged: {
        if (gameOver) {
            rexJumpUpTimer.stop()
            rexJumpDownTimer.stop()
            speedDown.stop()
            image.jumpTo("dead");
            rexStatus = "dead"
        }
    }

    Timer {
        id: rexJumpUpTimer
        running: false
        interval: 10
        repeat: true
        onTriggered: {
            if (currKeyPress === Qt.Key_Down) {
                running = false
            }
            if (rexRectangle.y > game.height - height - 90) {
                rexRectangle.y -= 8
            }
            else if (rexRectangle.y > game.height - height - 100) {
                rexRectangle.y -= 6
            }
            else if (rexRectangle.y > game.height - height - 110) {
                rexRectangle.y -= 3
            }
            else if (rexRectangle.y > game.height - height - 120) {
                rexRectangle.y -= 2
            }
            else if (rexRectangle.y > game.height - height - 125) {
                rexRectangle.y -= 1.5
            }
            else {
                rexJumpDownTimer.running = true
                running = false
            }
        }
    }

    Timer {
        id: rexJumpDownTimer
        running: false
        interval: 10
        repeat: true
        onTriggered: {
            if (currKeyPress === Qt.Key_Down) {
                running = false
            }

            if (rexRectangle.y < game.height - height - 120){
                rexRectangle.y += 1
            }
            else if (rexRectangle.y < game.height - height - 110) {
                rexRectangle.y += 2
            }
            else if (rexRectangle.y < game.height - height - 100) {
                rexRectangle.y += 3
            }
            else if (rexRectangle.y < game.height - height - 90) {
                rexRectangle.y += 5
            }
            else if (rexRectangle.y < game.height - height - 25) {
                rexRectangle.y += 7
            }
            else {
                running = false
                if (currKeyPress === Qt.Key_Down) {
                    rexStatus = "crouch"
                } else {
                    rexStatus = "run"
                }
            }
        }
    }

    Timer {
        id: speedDown
        running: false
        interval: 10
        repeat: true
        onTriggered: {
            if (rexRectangle.y < (game.height - height - 25)) {
                rexRectangle.y += 7
            } else {
                running = false
                if (currKeyPress === Qt.Key_Down) {
                    rexStatus = "crouch"
                } else {
                    rexStatus = "run"
                }
            }
        }
    }

    onRexStatusChanged: {
        image.width = 55
        image.height = 60
        if (rexStatus === "crouch") {
            image.width = 75
            image.height = 65
        }
        image.goalSprite = "";
        image.jumpTo(rexStatus);
        if (rexStatus === "crouch") {
            if (rexJumpDownTimer.running === true || rexJumpUpTimer.running === true) {
                rexJumpUpTimer.running = false
                rexJumpDownTimer.running = false
                speedDown.running = true
            }
        } else if (rexStatus === "jump") {
            rexJumpUpTimer.running = true
        } else if (rexStatus === "run") {
            rexRectangle.y = game.height - height - 25
        }
    }

    SpriteSequence {
        id: image
        width: parent.width
        height: parent.height
        running: true
        anchors.horizontalCenter: parent.horizontalCenter
        interpolate: false
        goalSprite: "run"
        Sprite {
            id: rexRunSprite
            name: "run"
            source: "qrc:/assets/offline-sprite-2x.png"
            frameCount: 2
            frameDuration: 100
            frameWidth: 88
            frameHeight: 97
            frameX: 1514
            frameY: 0
        }
        Sprite {
            id: rexCrouchSprite
            name: "crouch"
            source: "qrc:/assets/offline-sprite-2x.png"
            frameCount: 2
            frameDuration: 100
            frameWidth: 118
            frameHeight: 97
            frameX: 1865
            frameY: 0
        }
        Sprite {
            id: rexDieSprite
            name: "dead"
            source: "qrc:/assets/offline-sprite-2x.png"
            frameCount: 1
            frameDuration: 100
            frameWidth: 88
            frameHeight: 97
            frameX: 1690
            frameY: 0
        }
        Sprite {
            id: rexJumpSprite
            name: "jump"
            source: "qrc:/assets/offline-sprite-2x.png"
            frameCount: 1
            frameDuration: 100
            frameWidth: 86
            frameHeight: 97
            frameX: 1336
            frameY: 0
        }
    }
}

// The following code work but slowdown the all game:
/*SequentialAnimation {
    id: jump
    running: false
    PropertyAnimation {
        id: rexUpPropertyAnimation
        target: rexRectangle
        property: "y"
        from: rexRectangle.y
        to: rexRectangle.y - 100
        duration: 250
        easing.type: Easing.OutQuad
    }
    PropertyAnimation {
        id: rexDownPropertyAnimation
        target: rexRectangle
        property: "y"
        from: rexRectangle.y - 100
        to: game.height - height - 25
        duration: 250
        easing.type: Easing.InQuad
    }
    onRunningChanged: {
        if (jump.running === false && currKeyPress !== Qt.Key_Down) {
            rexStatus = "run"
        }
    }
}

SequentialAnimation {
    id: speedDown
    running: false
    PropertyAnimation {
        target: rexRectangle
        property: "y"
        from: rexRectangle.y
        to: game.height - height - 25
        duration: 250
        easing.type: Easing.OutQuad
    }
    onRunningChanged: {
        if (speedDown.running === false && currKeyPress !== Qt.Key_Down) {
            rexStatus = "run"
        }
    }
}*/
