import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "ColumnLayout Example"

    ColumnLayout {
        anchors.fill: parent

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "red"
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "green"
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "blue"
        }
    }
}
