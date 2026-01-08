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
    // Set to 0 for Automatic Dynamic Sizing.
    // Set a specific number to manually override.
    property real iconSize: 33
    property real fontSize: 20

    // Allow parent Layout to control size
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.preferredHeight: 55

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

        // 1. Icon Size Logic: Manual Override OR Auto Calculation
        property real autoIconHeight: hasLabel ? parent.height * 0.45 : parent.height * 0.6
        property real finalIconSize: control.iconSize > 0 ? control.iconSize : Math.min(autoIconHeight, parent.width * 0.8)

        // 2. Vertical Offset Logic
        property real verticalOffset: hasLabel ? -(parent.height * 0.12) : 0

        scale: control.pressed ? 0.94 : 1.0
        Behavior on scale { NumberAnimation { duration: 50; easing.type: Easing.OutQuad } }

        // --- THE ICON ---
        Shape {
            id: iconShape
            anchors.centerIn: parent
            anchors.verticalCenterOffset: parent.verticalOffset

            width: parent.finalIconSize
            height: parent.finalIconSize

            // Scaling logic: Assumes 24x24 standard SVG coordinate system
            scale: width / 24

            ShapePath {
                strokeWidth: 0
                fillColor: Qt.rgba(1,1,1, 0.95)
                PathSvg { path: control.pathData }
            }
        }

        // --- THE LABEL ---
        Text {
            visible: parent.hasLabel
            text: control.label

            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.08
            anchors.horizontalCenter: parent.horizontalCenter

            width: parent.width * 0.90

            // 3. Font Size Logic: Manual Override OR Auto Calculation
            font.pixelSize: control.fontSize > 0 ? control.fontSize : parent.height * 0.22

            minimumPixelSize: 8
            fontSizeMode: Text.HorizontalFit

            font.bold: true
            font.capitalization: Font.AllUppercase
            font.family: "Segoe UI"
            color: "#ffffff"
            style: Text.Outline
            styleColor: "#66000000"
            horizontalAlignment: Text.AlignHCenter
            layer.enabled: true
            // layer.effect: MultiEffect {
            //     shadowEnabled: true
            //     shadowHorizontalOffset: 4
            //     shadowVerticalOffset: 4
            //     shadowBlur: 0.25
            //     shadowOpacity: 0.85
            // }
        }
    }
}
