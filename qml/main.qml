import QtQuick 2.5
import QtQuick.Window 2.5
import "Components"

Window {
    id: mainWindow
    visible: true
    width: 1280
    height: 720
    title: "QML-Rex"
    property bool is_jumping: false
    property int timeSpend: 0

    onIs_jumpingChanged: {
        if (is_jumping) {
            rex.rexRunAnimation.running = false;
        } else {
            rex.rexRunAnimation.running = true;
        }
    }

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

        Roof {

        }

        Rex {
            id: rex
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
        Component.onCompleted: {
            console.log("Le jeu est chargé et prêt")
        }
    }
}
