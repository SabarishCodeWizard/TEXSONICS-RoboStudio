import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
RowLayout {
    property string labelText: "Label"
    property string valueText: "0"
    property color btnColor: "#2F2F40"
    spacing: 0

    Rectangle {
        Layout.preferredWidth: 50; Layout.preferredHeight: 28
        color: btnColor; border.color: borderColor; border.width: 1; radius: 3
        Rectangle { width: 5; height: parent.height; anchors.right: parent.right; color: parent.color }
        Text { text: labelText; anchors.centerIn: parent; color: textSec; font.family: fontFamily; font.bold: true; font.pixelSize: 11 }
    }
    TextField {
        text: valueText
        Layout.fillWidth: true; Layout.preferredHeight: 28
        color: textMain
        selectedTextColor: textDark; selectionColor: primaryColor
        background: Rectangle {
            color: inputBg
            border.color: parent.activeFocus ? primaryColor : borderColor
            border.width: 1; radius: 3
            Rectangle { width: 5; height: parent.height; anchors.left: parent.left; color: parent.color }
        }
        font.family: fontFamily; font.pixelSize: 12
        leftPadding: 8; selectByMouse: true
        horizontalAlignment: Text.AlignLeft; verticalAlignment: Text.AlignVCenter
    }
}
