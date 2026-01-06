import QtQuick 2.15
import QtQuick.Controls 2.15
Button {
    background: Rectangle {
        color: parent.down ? "#22222E" : (parent.hovered ? hoverColor : "#2F2F40")
        radius: 4
        border.color: borderColor
        border.width: 1
    }
    contentItem: Text {
        text: parent.text
        color: textSec
        font.family: fontFamily
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
