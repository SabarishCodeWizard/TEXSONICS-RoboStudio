import QtQuick 2.15
import QtQuick.Controls 2.15
Button {
    property color baseColor: successColor
    background: Rectangle {
        color: parent.down ? Qt.darker(baseColor, 1.2) : (parent.hovered ? Qt.lighter(baseColor, 1.1) : Qt.darker(baseColor, 1.1))
        radius: 4
        border.color: baseColor
        border.width: 1
        opacity: parent.down ? 0.8 : 1.0
    }
    contentItem: Text {
        text: parent.text
        color: textMain
        font.family: fontFamily
        font.bold: true
        font.pixelSize: 11
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        style: Text.Outline
        styleColor: "#222"
    }
}
