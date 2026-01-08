import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: root

    /* ---------- CUSTOM PROPERTIES ---------- */
    property color baseColor: "#2F2F40"
    property color hoverColor: "#3A3A55"
    property color pressedColor: "#22222E"
    property color borderColor: "#4A4A60"
    property color textSec: "#EAEAF0"
    property string fontFamily: "Inter"

    /* ---------- BACKGROUND ---------- */
    background: Rectangle {
        radius: 4
        border.color: root.borderColor
        border.width: 1

        color: root.down
               ? root.pressedColor
               : (root.hovered ? root.hoverColor : root.baseColor)

        // Smooth animation
        Behavior on color {
            ColorAnimation {
                duration: 150
                easing.type: Easing.InOutQuad
            }
        }
    }

    /* ---------- TEXT ---------- */
    contentItem: Text {
        text: root.text
        color: root.textSec
        font.family: root.fontFamily
        font.pixelSize: 14   // 🔼 increased for better readability
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
