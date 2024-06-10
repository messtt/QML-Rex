import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: rexRectangle
    width: 55
    height: 60

    color: "transparent"
    x: 20
    y: game.height - height - 25

    property string rexStatus: "run"

    onRexStatusChanged: {
        anim.start();
    }


    SequentialAnimation {
        id: anim
        ScriptAction {
            script: {
                image.goalSprite = "";
                image.jumpTo(rexStatus);
            }
        }
        PropertyAction {
            target: image;
            property: "y";
            value: 0
        }
    }
    SpriteSequence {
        id: image
        width: parent.width
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        interpolate: false
        Sprite {
            id: rexRunSprite
            name: "run"
            source: "../../assets/offline-sprite-2x.png"
            frameCount: 2
            frameDuration: 100
            frameWidth: 88
            frameHeight: 97
            frameX: 1514
            frameY: 0
        }
        Sprite {
            id: rexDieSprite
            name: "die"
            source: "../../assets/offline-sprite-2x.png"
            frameCount: 1
            frameDuration: 10000
            frameWidth: 88
            frameHeight: 97
            frameX: 1690
            frameY: 0
        }
        Sprite {
            id: rexCrouchSprite
            name: "crouch"
            source: "../../assets/offline-sprite-2x.png"
            frameCount: 2
            frameDuration: 100
            frameWidth: 118
            frameHeight: 97
            frameX: 1865
            frameY: 0
        }
        Sprite {
            id: rexJumpSprite
            name: "jump"
            source: "../../assets/offline-sprite-2x.png"
            frameCount: 2
            frameDuration: 100
            frameWidth: 118
            frameHeight: 97
            frameX: 1865
            frameY: 0
        }
    }
}
