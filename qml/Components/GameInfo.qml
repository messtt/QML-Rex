import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    height: 50
    width: parent.width
    color: "lightblue"
    id: gameInfos
    property int timeElapsed: 0
    property int multiplier: 1

    Timer {
        id: timer
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            gameInfos.timeElapsed += (1 + (multiplier * 0.1))
        }
    }

    Text {
        id: timeText
        anchors.right: parent.right
        text: gameInfos.timeElapsed
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 24
    }
}
