import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
RowLayout {
    property string labelStart: "X"
    property string labelEnd: "X-"
    property string valueText: "0.00"
    property color colorStart: "#2F2F40"
    property color colorEnd: "#2F2F40"
    property color labelColor: textSec
    spacing: 0

    Rectangle {
        Layout.preferredWidth: 40; Layout.preferredHeight: 28
        color: colorStart; border.color: borderColor; radius: 3
        Rectangle { width: 5; height: parent.height; anchors.right: parent.right; color: parent.color }
        Text { text: labelStart; anchors.centerIn: parent; font.pixelSize: 11; font.bold: true; color: labelColor }
    }
    TextField {
        text: valueText
        Layout.fillWidth: true; Layout.preferredHeight: 28
        selectByMouse: true
        color: primaryColor
        font.bold: true
        selectedTextColor: textDark; selectionColor: primaryColor
        background: Rectangle { color: inputBg; border.color: parent.activeFocus ? primaryColor : borderColor }
        horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter
        font.family: fontFamily; font.pixelSize: 12
    }
    Rectangle {
        Layout.preferredWidth: 40; Layout.preferredHeight: 28
        color: colorEnd; border.color: borderColor; radius: 3
        Rectangle { width: 5; height: parent.height; anchors.left: parent.left; color: parent.color }
        Text { text: labelEnd; anchors.centerIn: parent; font.pixelSize: 11; font.bold: true; color: labelColor }
    }
}
