import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

ApplicationWindow {
    visible: true
    width: 1400
    height: 900
    title: "Robot Control Interface - TEXSONICS"
    color: "#1E1E2E" // Deep Dark Background (IDE Style)

    // --- THEME PROPERTIES ---
    property color primaryColor: "#40C4FF"      // Electric Blue
    property color accentColor: "#69F0AE"       // Neon Green
    property color dangerColor: "#FF5252"       // Bright Red
    property color successColor: "#00E676"      // Matrix Green
    property color warningColor: "#FFAB40"      // Amber

    // Text Colors
    property color textMain: "#FFFFFF"          // Pure White
    property color textSec: "#B0BEC5"           // Blue Grey (Labels)
    property color textDark: "#1E1E2E"          // For text on bright buttons

    // Surface Colors
    property color panelBg: "#27273A"           // Card Background
    property color inputBg: "#151520"           // Deepest dark for inputs
    property color borderColor: "#3B3B50"       // Subtle borders
    property color hoverColor: "#32324A"        // Light hover state

    property var  fontFamily: "Segoe UI"        // Clean system font

    // --- REUSABLE COMPONENTS ---

    // 1. Professional Label-Input Pair
    component ValueBox: RowLayout {
        property string labelText: "Label"
        property string valueText: "0"
        property color btnColor: "#2F2F40"
        spacing: 0

        Rectangle {
            Layout.preferredWidth: 50
            Layout.preferredHeight: 28
            color: btnColor
            border.color: borderColor
            border.width: 1

            radius: 3
            Rectangle {
                width: 5; height: parent.height
                anchors.right: parent.right
                color: parent.color
            }

            Text {
                text: labelText
                anchors.centerIn: parent
                color: textSec
                font.family: fontFamily
                font.bold: true
                font.pixelSize: 11
            }
        }

        TextField {
            text: valueText
            Layout.fillWidth: true
            Layout.preferredHeight: 28
            color: textMain
            selectedTextColor: textDark
            selectionColor: primaryColor

            background: Rectangle {
                color: inputBg
                border.color: parent.activeFocus ? primaryColor : borderColor
                border.width: 1
                radius: 3
                Rectangle {
                    width: 5; height: parent.height
                    anchors.left: parent.left
                    color: parent.color
                }
            }
            font.family: fontFamily
            font.pixelSize: 12
            leftPadding: 8
            selectByMouse: true
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }
    }

    // 2. New Axis Control
    component AxisControl: RowLayout {
        property string labelStart: "X"
        property string labelEnd: "X-"
        property string valueText: "0.00"
        property color colorStart: "#2F2F40"
        property color colorEnd: "#2F2F40"
        property color labelColor: textSec
        spacing: 0

        // Left Label (+)
        Rectangle {
            Layout.preferredWidth: 40
            Layout.preferredHeight: 28
            color: colorStart
            border.color: borderColor
            radius: 3
            Rectangle { width: 5; height: parent.height; anchors.right: parent.right; color: parent.color }
            Text { text: labelStart; anchors.centerIn: parent; font.pixelSize: 11; font.bold: true; color: labelColor }
        }

        // Center Input
        TextField {
            text: valueText
            Layout.fillWidth: true
            Layout.preferredHeight: 28
            selectByMouse: true
            color: primaryColor // Highlight values in blue
            font.bold: true
            selectedTextColor: textDark
            selectionColor: primaryColor

            background: Rectangle {
                color: inputBg
                border.color: parent.activeFocus ? primaryColor : borderColor
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: fontFamily
            font.pixelSize: 12
        }

        // Right Label (-)
        Rectangle {
            Layout.preferredWidth: 40
            Layout.preferredHeight: 28
            color: colorEnd
            border.color: borderColor
            radius: 3
            Rectangle { width: 5; height: parent.height; anchors.left: parent.left; color: parent.color }
            Text { text: labelEnd; anchors.centerIn: parent; font.pixelSize: 11; font.bold: true; color: labelColor }
        }
    }

    // 3. Professional Status Button (Colored)
    component StatusButton: Button {
        property color baseColor: successColor
        property bool isCritical: false

        background: Rectangle {
            color: parent.down ? Qt.darker(baseColor, 1.2) : (parent.hovered ? Qt.lighter(baseColor, 1.1) : Qt.darker(baseColor, 1.1))
            radius: 4
            border.color: baseColor
            border.width: 1
            opacity: parent.down ? 0.8 : 1.0
        }
        contentItem: Text {
            text: parent.text
            color: textMain // White text on colored buttons
            font.family: fontFamily
            font.bold: true
            font.pixelSize: 11
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
            style: Text.Outline
            styleColor: "#222" // Slight text shadow for readability
        }
    }

    // 4. Standard Action Button (Dark Grey)
    component ActionButton: Button {
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

    // 5. Panel Container (Card style)
    component PanelCard: Rectangle {
        color: panelBg
        radius: 6
        border.color: borderColor
        border.width: 1
    }

    // --- MAIN LAYOUT ---

    RowLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 12

        // === LEFT PANEL (3D View & Main Controls) ===
        ColumnLayout {
            Layout.preferredWidth: parent.width * 0.45
            Layout.fillHeight: true
            spacing: 12

            // Header Card
            PanelCard {
                Layout.fillWidth: true
                height: 60

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 15

                    Text {
                        text: "TEXSONICS"
                        font.family: fontFamily
                        font.bold: true
                        font.pixelSize: 22
                        color: primaryColor
                        font.letterSpacing: 1.2
                    }
                    Item { Layout.fillWidth: true } // Spacer
                    Text {
                        text: "ROBOT CONTROLLER V1.0"
                        font.family: fontFamily
                        font.pixelSize: 10
                        color: textSec
                    }
                }
            }

            // 3D Viewport Card
            PanelCard {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                color: "#fff5ee" // Even darker for viewport

                // Grid background (Inverted for Dark Mode)
                Grid {
                    anchors.fill: parent
                    opacity: 0.15
                    rows: 20; columns: 20
                    Repeater {
                        model: 400
                        Rectangle {
                            Layout.fillWidth: true
                            width: parent.width/20
                            height: parent.height/20
                            border.color: "#696969" // White lines, low opacity
                            color: "transparent"
                        }
                    }
                }

                // View Label Overlay
                Rectangle {
                    anchors.left: parent.left; anchors.top: parent.top
                    anchors.margins: 10
                    color: "#AA1E1E2E" // semi-transparent dark
                    radius: 4
                    width: 100; height: 24
                    border.color: borderColor
                    Text {
                        text: "▶ Live View"
                        anchors.centerIn: parent
                        font.pixelSize: 11
                        font.bold: true
                        color: successColor
                    }
                }
            }

            // Bottom Operation Controls
            PanelCard {
                Layout.fillWidth: true
                Layout.preferredHeight: 180

                GridLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    columns: 6
                    rowSpacing: 8
                    columnSpacing: 8

                    StatusButton { text: "Sim"; baseColor: successColor; Layout.fillWidth: true }
                    StatusButton { text: "Real"; baseColor: "#546E7A"; Layout.fillWidth: true } // Grey for inactive/real

                    ActionButton { text: "On/Off"; Layout.fillWidth: true }
                    ActionButton { text: "Error Clr"; Layout.fillWidth: true }
                    ActionButton { text: "Mark Clr"; Layout.fillWidth: true }
                    StatusButton { text: "Home"; baseColor: primaryColor; Layout.fillWidth: true }

                    StatusButton { text: "Pause/Run"; baseColor: warningColor; Layout.fillWidth: true }
                    StatusButton { text: "Start/Stop"; baseColor: dangerColor; Layout.fillWidth: true }
                    StatusButton { text: "Exit"; baseColor: "#78909c"; Layout.fillWidth: true }
                    ActionButton { text: "Close"; Layout.fillWidth: true }

                    // Speed Control
                    RowLayout {
                        Layout.columnSpan: 2
                        spacing: 5
                        Text { text: "Speed:"; font.pixelSize: 11; color: textSec }
                        TextField {
                            text: "0.05";
                            Layout.fillWidth: true;
                            Layout.preferredHeight: 28
                            color: textMain
                            background: Rectangle { color: inputBg; border.color: borderColor; radius: 3 }
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    // Status Bar
                    Rectangle {
                        color: Qt.darker(successColor, 1.8) // Dark Green background
                        border.color: successColor
                        border.width: 1
                        radius: 4
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        Layout.preferredHeight: 32

                        RowLayout {
                            anchors.centerIn: parent
                            spacing: 5
                            Text { text: "✓"; color: successColor; font.bold: true }
                            Text { text: "System Ready"; color: successColor; font.bold: true; font.pixelSize: 12 }
                        }
                    }

                    ActionButton { text: "Add Tool" }
                    ActionButton { text: "Tool IP" }
                    TextField {
                        placeholderText: "Tool ID..."
                        placeholderTextColor: "#555"
                        color: textMain
                        Layout.fillWidth: true
                        Layout.preferredHeight: 30
                        background: Rectangle { color: inputBg; border.color: borderColor; radius: 3 }
                    }
                    StatusButton { text: "ETH RST"; baseColor: "#00897B"; } // Teal
                }
            }
        }

        // === RIGHT PANEL (Parameters, Jogging, Tables) ===
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 12

            // Top Control Bar
            PanelCard {
                Layout.fillWidth: true
                height: 50
                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 10; anchors.rightMargin: 10
                    spacing: 10

                    StatusButton { text: "EMERGENCY STOP"; baseColor: dangerColor; Layout.preferredWidth: 140 }
                    StatusButton { text: "MOVE"; baseColor: "#D84315"; Layout.preferredWidth: 80 } // Deep Orange

                    Rectangle { width: 1; height: 30; color: borderColor } // Separator

                    ActionButton { text: "Jog"; Layout.preferredWidth: 70 }
                    ActionButton { text: "Auto"; Layout.preferredWidth: 70 }
                    StatusButton { text: "Manual"; baseColor: successColor; Layout.preferredWidth: 70 }
                    ActionButton { text: "Remote"; Layout.preferredWidth: 70 }
                }
            }

            // Coordinates Grid
            PanelCard {
                Layout.fillWidth: true
                Layout.preferredHeight: 220

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 15

                    // Col 1: Settings
                    ColumnLayout {
                        Layout.alignment: Qt.AlignTop
                        Text { text: "SETTINGS"; color: primaryColor; font.bold: true; font.pixelSize: 11 }
                        ValueBox { labelText: "mm"; valueText: "10" }
                        ValueBox { labelText: "mm/s"; valueText: "1" }
                        ValueBox { labelText: "Deg"; valueText: "deg" }
                        ValueBox { labelText: "deg/s"; valueText: "1" }
                        ValueBox { labelText: "Frame"; valueText: "Base" }

                        Item { height: 5; Layout.fillWidth: true }

                        Slider {
                            value: 0.5
                            Layout.fillWidth: true
                            Layout.preferredHeight: 20
                            background: Rectangle {
                                x: parent.leftPadding
                                y: parent.topPadding + parent.availableHeight / 2 - height / 2
                                implicitWidth: 200
                                implicitHeight: 4
                                width: parent.availableWidth
                                height: implicitHeight
                                radius: 2
                                color: "#3e3e50"
                                Rectangle {
                                    width: parent.visualPosition * parent.width
                                    height: parent.height
                                    color: primaryColor
                                    radius: 2
                                }
                            }
                            handle: Rectangle {
                                x: parent.leftPadding + parent.visualPosition * (parent.availableWidth - width)
                                y: parent.topPadding + parent.availableHeight / 2 - height / 2
                                implicitWidth: 16
                                implicitHeight: 16
                                radius: 8
                                color: primaryColor
                            }
                        }
                        RowLayout {
                            Text { text: "Ovr:"; font.pixelSize: 10; color: textSec }
                            TextField {
                                text: "100%";
                                Layout.fillWidth: true;
                                Layout.preferredHeight: 24
                                font.pixelSize: 11
                                color: textMain
                                background: Rectangle { color: inputBg; border.color: borderColor; radius: 2 }
                            }
                        }
                    }

                    Rectangle { width: 1; Layout.fillHeight: true; color: borderColor } // Divider

                    // Col 2: Cartesian
                    ColumnLayout {
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        Text { text: "CARTESIAN (Jog)"; color: primaryColor; font.bold: true; font.pixelSize: 11 }

                        AxisControl { labelStart: "X"; valueText: "795.5"; labelEnd: "X-" }
                        AxisControl { labelStart: "Y"; valueText: "0.00"; labelEnd: "Y-" }
                        AxisControl { labelStart: "Z"; valueText: "1174.0"; labelEnd: "Z-" }
                        AxisControl { labelStart: "Rx"; valueText: "0.00"; labelEnd: "Rx-" }
                        AxisControl { labelStart: "Ry"; valueText: "0.00"; labelEnd: "Ry-" }
                        AxisControl { labelStart: "Rz"; valueText: "0.00"; labelEnd: "Rz-" }
                    }

                    Rectangle { width: 1; Layout.fillHeight: true; color: borderColor } // Divider

                    // Col 3: Joints
                    ColumnLayout {
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        Text { text: "JOINTS (Jog)"; color: successColor; font.bold: true; font.pixelSize: 11 }

                        // Green theme logic handled by property, using darker bg for labels
                        AxisControl { labelStart: "J1"; valueText: "0.00"; labelEnd: "J1-"; labelColor: accentColor }
                        AxisControl { labelStart: "J2"; valueText: "0.00"; labelEnd: "J2-"; labelColor: accentColor }
                        AxisControl { labelStart: "J3"; valueText: "0.00"; labelEnd: "J3-"; labelColor: accentColor }
                        AxisControl { labelStart: "J4"; valueText: "0.00"; labelEnd: "J4-"; labelColor: accentColor }
                        AxisControl { labelStart: "J5"; valueText: "89.99"; labelEnd: "J5-"; labelColor: accentColor }
                        AxisControl { labelStart: "J6"; valueText: "0.00"; labelEnd: "J6-"; labelColor: accentColor }
                    }
                }
            }

            // Small Offset Grid
            PanelCard {
                Layout.fillWidth: true
                height: 40

                RowLayout {
                    anchors.centerIn: parent
                    spacing: 15

                    component MiniInput: Row {
                        property string label: ""
                        property string val: ""
                        spacing: 2
                        Rectangle { width: 25; height: 24; color: "#2F2F40"; radius: 2; border.color: borderColor
                            Text {
                                text: parent.label !== undefined ? parent.label : ""
                                anchors.centerIn: parent
                                font.pixelSize: 11
                                color: textSec
                            }
                        }
                        TextField {
                            text: parent.val !== undefined ? parent.val : ""
                            width: 50
                            height: 24
                            color: textMain
                            background: Rectangle { color: inputBg; border.color: borderColor; radius: 2 }
                            font.pixelSize: 11
                        }
                    }

                    MiniInput { label: "a"; val: "0" }
                    MiniInput { label: "b"; val: "180" }
                    MiniInput { label: "c"; val: "0" }
                    MiniInput { label: "qw"; val: "0" }
                    MiniInput { label: "qx"; val: "0" }
                }
            }

            TabBar {
                id: tabBar
                Layout.fillWidth: true
                contentHeight: 35
                background: Rectangle { color: "transparent" }

                Repeater {
                    model: ["Program", "Error Pos", "Encoder Offset", "Mech Setting"]
                    TabButton {
                        text: modelData
                        checked: tabBar.currentIndex === index // bind to TabBar's currentIndex
                        width: implicitWidth + 20

                        onClicked: tabBar.currentIndex = index // change active tab when clicked

                        contentItem: Text {
                            text: parent.text
                            font.family: fontFamily
                            font.pixelSize: 12
                            font.bold: parent.checked
                            color: parent.checked ? primaryColor : textSec
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        background: Rectangle {
                            color: parent.checked ? panelBg : "transparent"
                            border.color: parent.checked ? borderColor : "transparent"
                            border.width: 1
                            radius: 4
                            Rectangle {
                                visible: tabBar.currentIndex === index
                                height: 2
                                anchors.top: parent.top
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.margins: 1
                                color: primaryColor
                            }

                        }
                    }
                }
            }


            // Data Tables
            RowLayout {
                Layout.fillHeight: true
                Layout.fillWidth: true
                spacing: 10

                // Table 1
                PanelCard {
                    Layout.fillHeight: true
                    Layout.preferredWidth: 420
                    clip: true

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 0

                        // Header
                        Rectangle {
                            Layout.fillWidth: true
                            height: 30
                            color: "#32324A" // Header specific color
                            Text {
                                text: "Name        Value        Deg"
                                anchors.verticalCenter: parent.verticalCenter
                                x: 10
                                font.bold: true; color: textSec; font.pixelSize: 11
                            }
                        }

                        // Content
                        Rectangle {
                            Layout.fillWidth: true
                            height: 30
                            color: "#1A40C4FF" // Transparent Blue highlight

                            Text {
                                text: ""
                                anchors.verticalCenter: parent.verticalCenter
                                x: 10
                                font.family: "Consolas"
                                font.pixelSize: 12
                                color: textMain
                            }
                            Rectangle { width: 3; height: parent.height; color: primaryColor }
                        }
                        Item { Layout.fillHeight: true }
                    }
                }

                // Table 2
                PanelCard {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    clip: true

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 0

                        // Header
                        Rectangle {
                            Layout.fillWidth: true
                            height: 30
                            color: "#32324A"
                            Text {
                                text: "   Inst    Name    Value    Deg    Speed"
                                anchors.verticalCenter: parent.verticalCenter
                                font.bold: true; color: textSec; font.pixelSize: 11
                            }
                        }

                        // Rows
                        Column {
                            Layout.fillWidth: true
                            Repeater {
                                model: 5
                                Rectangle {
                                    width: parent.width
                                    height: 28
                                    color: index % 2 === 0 ? "transparent" : "#32324A" // Zebra striping
                                    Text {
                                        text: (index + 1)
                                        anchors.verticalCenter: parent.verticalCenter
                                        x: 15
                                        color: textSec
                                        font.pixelSize: 12
                                    }
                                    Rectangle { height: 1; width: parent.width; color: borderColor; anchors.bottom: parent.bottom; opacity: 0.5 }
                                }
                            }
                        }
                        Item { Layout.fillHeight: true }
                    }
                }
            }

            // Bottom Right Control Grid
            PanelCard {
                Layout.fillWidth: true
                Layout.preferredHeight: 100

                GridLayout {
                    anchors.fill: parent
                    anchors.margins: 8
                    columns: 6
                    columnSpacing: 6
                    rowSpacing: 6

                    ActionButton { text: "Insert Inst"; Layout.fillWidth: true }
                    ActionButton { text: "Delete Inst"; Layout.fillWidth: true }
                    ActionButton { text: "New Prg"; Layout.fillWidth: true }
                    ActionButton { text: "Del Prg"; Layout.fillWidth: true }
                    ActionButton { text: "Open Prg"; Layout.fillWidth: true }
                    StatusButton { text: "Trj Calc"; baseColor: primaryColor; Layout.fillWidth: true }

                    ActionButton { text: "MOVL"; Layout.fillWidth: true }
                    ActionButton { text: "Run Tp"; Layout.fillWidth: true }
                    ActionButton { text: "Add Tp"; Layout.fillWidth: true }
                    ActionButton { text: "Modify Tp"; Layout.fillWidth: true }
                    ActionButton { text: "Delete Tp"; Layout.fillWidth: true }
                    ActionButton { text: "New Tp F1"; Layout.fillWidth: true }
                }
            }

            // Footer Input
            PanelCard {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                color: "#181825" // Darker footer

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10

                    Text { text: "IP PG:"; font.bold: true; color: textSec }
                    TextField {
                        placeholderText: "tpn..."
                        placeholderTextColor: "#555"
                        Layout.preferredWidth: 100
                        color: textMain
                        background: Rectangle { color: inputBg; border.color: borderColor; radius: 3 }
                    }

                    TabBar {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 30
                        background: Rectangle { color: "transparent" }
                        TabButton {
                            text: "Inst"; width: 80
                            contentItem: Text { text: parent.text; color: textSec; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                            background: Rectangle { color: "transparent"; border.color: borderColor; radius: 3 }
                        }
                        TabButton {
                            text: "Debug"; width: 80
                            contentItem: Text { text: parent.text; color: textSec; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                            background: Rectangle { color: "transparent"; border.color: borderColor; radius: 3 }
                        }
                        TabButton {
                            text: "Jog Deg"; width: 80
                            contentItem: Text { text: parent.text; color: textSec; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                            background: Rectangle { color: "transparent"; border.color: borderColor; radius: 3 }
                        }
                    }
                }
            }
        }
    }
}
