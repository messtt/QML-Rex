import QtQuick 2.5
import QtQuick.Window 2.5



Rectangle {
    width: 50
    height: 30
    color: "red"
    y: parent.height - height - 40
    x: game.width

    NumberAnimation on x {
        from: game.width
        to: -width
        duration: 2775
        loops: Animation.Infinite
        running: true
    }
}
