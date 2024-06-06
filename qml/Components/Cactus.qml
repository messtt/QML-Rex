import QtQuick 2.5
import QtQuick.Window 2.5

Rectangle {
    id: cactus
    width: 50
    height: 60
    color: "blue"
    y: parent.height - height - 10
    x: game.width

    property var currCactus: randomCactusImage()

    function randomCactusImage() {
        var images = [
            ["../../assets/two_cactus.png", 60, 70],
            ["../../assets/four_cactus.png", 90, 70],
            ["../../assets/three_cactus.png", 80, 70],
            ["../../assets/two_cactus_small.png", 40, 50],
        ];
        var index = Math.floor(Math.random() * images.length);
        return images[index];
    }

    Image {
        id: cactusImage
        anchors.fill: parent
        sourceSize.width: 50
        sourceSize.height: 60
        source: currCactus[0]
    }

    NumberAnimation on x {
        from: game.width
        to: -(width + 20)
        duration: 2775 + (currCactus[1] * 0.95)
        loops: Animation.Infinite
        running: true
    }
    onXChanged: {
        console.log("x: " + cactus.x)
        if (cactus.x > 1270) {
            currCactus = randomCactusImage()
            cactusImage.source = currCactus[0]
            cactusImage.sourceSize.width = currCactus[1]
            cactusImage.sourceSize.height = currCactus[2]
            cactus.width = currCactus[1]
            cactus.height = currCactus[2]
        }
    }
}
