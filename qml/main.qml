import QtQuick
import QtQuick.Controls
import io.qt.examples.backend

ApplicationWindow {
    id: root
    width: 300
    height: 480
    visible: true

    BackEnd {
        id: backend
    }

    TextField {
        text: backend.userName
        placeholderText: qsTr("Enter your name")
        anchors.centerIn: parent

        onEditingFinished: backend.userName = text
    }
}
