import QtQuick 2.15
import QtQuick.Controls 2.15

Row {
    id: root // 1. Give the root element an ID
    property string label: ""
    property string val: ""
    spacing: 2

    Rectangle {
        width: 28; height: 24
        color: "#2F2F40"
        radius: 2
        border.color: "#3f3f5f" // Used explicit color if borderColor isn't global
        border.width: 1

        Text {
            // 2. Reference 'root.label' instead of 'parent.label'
            text: root.label
            anchors.centerIn: parent
            font.pixelSize: 10
            font.bold: true
            color: "#FFFFFF"
        }
    }

    TextField {
        // 3. Reference 'root.val' for consistency
        text: root.val
        width: 48; height: 24
        color: "#ffffff" // textMain
        background: Rectangle {
            color: "#11111b" // inputBg
            border.color: "#3f3f5f" // borderColor
            radius: 2
        }
        font.pixelSize: 11
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
