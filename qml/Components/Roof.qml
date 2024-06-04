import QtQuick 2.5
import QtQuick.Window 2.5


Repeater {
    model: 2
    Image {
        source: "../../assets/roof.png"
        sourceSize.width: 2404
        sourceSize.height: 28
        width: 2404
        height: 14
        y: parent.height - height - 20
        x: index * width

        NumberAnimation on x {
            from: index * width
            to: (index - 1) * width
            duration: 5000
            loops: Animation.Infinite
            running: true
        }
    }
}
