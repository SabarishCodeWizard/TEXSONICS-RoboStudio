import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Shapes 1.15
import QtQuick.Effects

Button {
    id: control

    property string pathData: ""
    property color baseColor: "#555"
    property string label: ""

    // --- SIZE CONFIGURATION ---
    // 0 = Automatic Dynamic Sizing
    property real iconSize: 0
    property real fontSize: 0

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.preferredHeight: 50

    background: Rectangle {
        id: bgRect
        radius: 6
        gradient: Gradient {
            GradientStop {
                position: 0.0;
                color: control.pressed ? Qt.darker(control.baseColor, 1.2) : Qt.lighter(control.baseColor, 1.3)
                Behavior on color { ColorAnimation { duration: 150 } }
            }
            GradientStop {
                position: 1.0;
                color: control.pressed ? Qt.darker(control.baseColor, 1.4) : control.baseColor
                Behavior on color { ColorAnimation { duration: 150 } }
            }
        }
        border.color: Qt.lighter(control.baseColor, 1.5)
        border.width: control.hovered ? 2 : 1
        Behavior on border.width { NumberAnimation { duration: 100 } }
    }

    contentItem: Item {
        id: contentContainer
        anchors.fill: parent

        // --- DYNAMIC CALCULATIONS ---
        property bool hasLabel: control.label !== ""
        property bool hasIcon: control.pathData !== ""

        // 1. Icon Size: Bigger now (55% of height) since it's side-by-side
        property real autoIconHeight: parent.height * 0.55
        property real calcIconSize: Math.min(autoIconHeight, 32)
        property real finalIconSize: control.iconSize > 0 ? control.iconSize : calcIconSize

        // 2. Font Size: Larger (35% of height)
        property real autoFontSize: parent.height * 0.35
        property real calcFontSize: Math.min(autoFontSize, 20)
        property real finalFontSize: control.fontSize > 0 ? control.fontSize : calcFontSize

        scale: control.pressed ? 0.96 : 1.0
        Behavior on scale { NumberAnimation { duration: 50; easing.type: Easing.OutQuad } }

        // --- HORIZONTAL LAYOUT (Left Icon, Right Text) ---
        RowLayout {
            anchors.centerIn: parent
            spacing: control.hasLabel ? 12 : 0 // Space between Icon and Text

            // --- THE ICON ---
            Shape {
                visible: parent.parent.hasIcon
                Layout.preferredWidth: parent.parent.finalIconSize
                Layout.preferredHeight: parent.parent.finalIconSize
                Layout.alignment: Qt.AlignVCenter

                // Scaling: Assumes 24x24 SVG viewport
                scale: width / 24
                transformOrigin: Item.Center

                ShapePath {
                    strokeWidth: 0
                    fillColor: Qt.rgba(1,1,1, 0.95)
                    PathSvg { path: control.pathData }
                }
            }

            // --- THE LABEL ---
            Text {
                visible: parent.parent.hasLabel
                text: control.label

                Layout.alignment: Qt.AlignVCenter

                font.pixelSize: parent.parent.finalFontSize
                font.bold: true
                font.capitalization: Font.AllUppercase
                font.family: "Segoe UI"

                color: "#ffffff"
                style: Text.Outline
                styleColor: "#80000000"

                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter

                layer.enabled: true
            }
        }
    }
}
