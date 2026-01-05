import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

ApplicationWindow {
    visible: true
    width: 1400
    height: 900
    title: "Robot Control Interface - Professional Edition"
    color: "#eaeff2" // Professional Light Grey Background (reduces glare)

    // --- THEME PROPERTIES ---
    property color primaryColor: "#0277BD"      // Deep Brand Blue
    property color accentColor: "#26A69A"       // Teal for highlights
    property color dangerColor: "#D32F2F"       // Professional Red
    property color successColor: "#388E3C"      // Professional Green
    property color neutralDark: "#37474F"       // Dark Blue-Grey for text
    property color neutralLight: "#CFD8DC"      // Light Grey for borders
    property color panelBg: "#FFFFFF"           // White panel background
    property var  fontFamily: "Segoe UI"        // Clean system font

    // --- REUSABLE COMPONENTS ---

    // 1. Professional Label-Input Pair (For Settings)
    component ValueBox: RowLayout {
        property string labelText: "Label"
        property string valueText: "0"
        property color btnColor: "#f5f7f9" // Lighter default background
        spacing: 0 // Connected look

        Rectangle {
            Layout.preferredWidth: 50
            Layout.preferredHeight: 28
            color: btnColor
            border.color: "#d0d7de"
            border.width: 1

            // Left rounded corners only
            radius: 3
            Rectangle {
                width: 5; height: parent.height
                anchors.right: parent.right
                color: parent.color
            }

            Text {
                text: labelText
                anchors.centerIn: parent
                color: "#455a64"
                font.family: fontFamily
                font.bold: true
                font.pixelSize: 11
            }
        }

        TextField {
            text: valueText
            Layout.fillWidth: true
            Layout.preferredHeight: 28
            color: "#263238"

            background: Rectangle {
                color: "white"
                border.color: parent.activeFocus ? primaryColor : "#d0d7de"
                border.width: 1
                // Right rounded corners only
                radius: 3
                Rectangle {
                    width: 5; height: parent.height
                    anchors.left: parent.left
                    color: "white"
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

    // 2. New Axis Control (Label Left - Input Center - Label Right)
    component AxisControl: RowLayout {
        property string labelStart: "X"
        property string labelEnd: "X-"
        property string valueText: "0.00"
        property color colorStart: "#E3F2FD"
        property color colorEnd: "#fafafa"
        spacing: 0

        // Left Label (+)
        Rectangle {
            Layout.preferredWidth: 40
            Layout.preferredHeight: 28
            color: colorStart
            border.color: "#d0d7de"
            radius: 3
            // Fix corners (Left Rounded Only)
            Rectangle { width: 5; height: parent.height; anchors.right: parent.right; color: parent.color }
            Text { text: labelStart; anchors.centerIn: parent; font.pixelSize: 11; font.bold: true; color: "#455a64" }
        }

        // Center Input
        TextField {
            text: valueText
            Layout.fillWidth: true
            Layout.preferredHeight: 28
            selectByMouse: true
            background: Rectangle {
                color: "white"
                border.color: parent.activeFocus ? primaryColor : "#d0d7de"
                // No radius (Square connections)
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
            border.color: "#d0d7de"
            radius: 3
            // Fix corners (Right Rounded Only)
            Rectangle { width: 5; height: parent.height; anchors.left: parent.left; color: parent.color }
            Text { text: labelEnd; anchors.centerIn: parent; font.pixelSize: 11; font.bold: true; color: "#78909c" }
        }
    }

    // 3. Professional Status Button
    component StatusButton: Button {
        property color baseColor: successColor
        property bool isCritical: false

        background: Rectangle {
            color: parent.down ? Qt.darker(baseColor, 1.1) : (parent.hovered ? Qt.lighter(baseColor, 1.1) : baseColor)
            radius: 4
            border.color: Qt.darker(baseColor, 1.2)
            border.width: 1

            // Subtle gradient effect for depth
            gradient: Gradient {
                GradientStop { position: 0.0; color: Qt.lighter(baseColor, 1.05) }
                GradientStop { position: 1.0; color: baseColor }
            }
        }
        contentItem: Text {
            text: parent.text
            color: "white"
            font.family: fontFamily
            font.bold: true
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
    }

    // 4. Standard Action Button (Grey)
    component ActionButton: Button {
        background: Rectangle {
            color: parent.down ? "#cfd8dc" : (parent.hovered ? "#eceff1" : "white")
            radius: 4
            border.color: "#b0bec5"
            border.width: 1
        }
        contentItem: Text {
            text: parent.text
            color: "#37474F"
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
        border.color: "#dce1e6"
        border.width: 1
        // Subtle shadow simulation
        Rectangle {
            z: -1
            anchors.fill: parent
            anchors.topMargin: 2
            anchors.leftMargin: 2
            color: "#000000"
            opacity: 0.05
            radius: 6
        }
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
                        color: "#90a4ae"
                    }
                }
            }

            // 3D Viewport Card
            PanelCard {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                Image {
                    source: "" // Placeholder
                    anchors.centerIn: parent
                }

                // Grid background
                Grid {
                    anchors.fill: parent
                    opacity: 0.08
                    rows: 20; columns: 20
                    Repeater {
                        model: 400
                        Rectangle {
                            Layout.fillWidth: true
                            width: parent.width/20
                            height: parent.height/20
                            border.color: "#37474F"
                            color: "transparent"
                        }
                    }
                }

                // View Label Overlay
                Rectangle {
                    anchors.left: parent.left; anchors.top: parent.top
                    anchors.margins: 10
                    color: "#ccffffff" // semi-transparent white
                    radius: 4
                    width: 100; height: 24
                    border.color: "#ddd"
                    Text {
                        text: "▶ Live View"
                        anchors.centerIn: parent
                        font.pixelSize: 11
                        font.bold: true
                        color: "#555"
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
                    StatusButton { text: "Real"; baseColor: "#78909c"; Layout.fillWidth: true } // Grey for inactive/real

                    ActionButton { text: "On/Off"; Layout.fillWidth: true }
                    ActionButton { text: "Error Clr"; Layout.fillWidth: true }
                    ActionButton { text: "Mark Clr"; Layout.fillWidth: true }
                    StatusButton { text: "Home"; baseColor: primaryColor; Layout.fillWidth: true }

                    StatusButton { text: "Pause/Run"; baseColor: "#FFA000"; Layout.fillWidth: true } // Amber
                    StatusButton { text: "Start/Stop"; baseColor: dangerColor; Layout.fillWidth: true }
                    StatusButton { text: "Exit"; baseColor: "#546E7A"; Layout.fillWidth: true }
                    ActionButton { text: "Close"; Layout.fillWidth: true }

                    // Speed Control
                    RowLayout {
                        Layout.columnSpan: 2
                        spacing: 5
                        Text { text: "Speed:"; font.pixelSize: 11; color: "#555" }
                        TextField {
                            text: "0.05";
                            Layout.fillWidth: true;
                            Layout.preferredHeight: 28
                            background: Rectangle { border.color: "#ccc"; radius: 3 }
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    // Status Bar
                    Rectangle {
                        color: "#2e7d32" // Darker green for success message
                        radius: 4
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        Layout.preferredHeight: 32

                        RowLayout {
                            anchors.centerIn: parent
                            spacing: 5
                            Text { text: "✓"; color: "white"; font.bold: true }
                            Text { text: "System Ready"; color: "white"; font.bold: true; font.pixelSize: 12 }
                        }
                    }

                    ActionButton { text: "Add Tool" }
                    ActionButton { text: "Tool IP" }
                    TextField {
                        placeholderText: "Tool ID..."
                        Layout.fillWidth: true
                        Layout.preferredHeight: 30
                        background: Rectangle { border.color: "#ccc"; radius: 3 }
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

                    Rectangle { width: 1; height: 30; color: "#ddd" } // Separator

                    ActionButton { text: "Jog"; Layout.preferredWidth: 70 }
                    ActionButton { text: "Auto"; Layout.preferredWidth: 70 }
                    StatusButton { text: "Manual"; baseColor: successColor; Layout.preferredWidth: 70 }
                    ActionButton { text: "Remote"; Layout.preferredWidth: 70 }
                }
            }

            // Coordinates Grid (UPDATED SECTION)
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
                        }
                        RowLayout {
                            Text { text: "Ovr:"; font.pixelSize: 10; color: "#777" }
                            TextField {
                                text: "100%";
                                Layout.fillWidth: true;
                                Layout.preferredHeight: 24
                                font.pixelSize: 11
                                background: Rectangle { border.color: "#ddd"; radius: 2 }
                            }
                        }
                    }

                    Rectangle { width: 1; Layout.fillHeight: true; color: "#eee" } // Divider

                    // Col 2: Cartesian (Merged)
                    ColumnLayout {
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        Text { text: "CARTESIAN (Jog)"; color: primaryColor; font.bold: true; font.pixelSize: 11 }

                        // Using new AxisControl for X+ Input X- layout
                        AxisControl { labelStart: "X"; valueText: "795.5"; labelEnd: "X-" }
                        AxisControl { labelStart: "Y"; valueText: "0.00"; labelEnd: "Y-" }
                        AxisControl { labelStart: "Z"; valueText: "1174.0"; labelEnd: "Z-" }
                        AxisControl { labelStart: "Rx"; valueText: "0.00"; labelEnd: "Rx-" }
                        AxisControl { labelStart: "Ry"; valueText: "0.00"; labelEnd: "Ry-" }
                        AxisControl { labelStart: "Rz"; valueText: "0.00"; labelEnd: "Rz-" }
                    }

                    Rectangle { width: 1; Layout.fillHeight: true; color: "#eee" } // Divider

                    // Col 3: Joints (Merged)
                    ColumnLayout {
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        Text { text: "JOINTS (Jog)"; color: successColor; font.bold: true; font.pixelSize: 11 }

                        // Green theme for Joints
                        AxisControl { labelStart: "J1"; valueText: "0.00"; labelEnd: "J1-"; colorStart: "#E8F5E9" }
                        AxisControl { labelStart: "J2"; valueText: "0.00"; labelEnd: "J2-"; colorStart: "#E8F5E9" }
                        AxisControl { labelStart: "J3"; valueText: "0.00"; labelEnd: "J3-"; colorStart: "#E8F5E9" }
                        AxisControl { labelStart: "J4"; valueText: "0.00"; labelEnd: "J4-"; colorStart: "#E8F5E9" }
                        AxisControl { labelStart: "J5"; valueText: "89.99"; labelEnd: "J5-"; colorStart: "#E8F5E9" }
                        AxisControl { labelStart: "J6"; valueText: "0.00"; labelEnd: "J6-"; colorStart: "#E8F5E9" }
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

                    // Helper for mini inputs
                    component MiniInput: Row {
                        property string label: ""
                        property string val: ""
                        spacing: 2
                        Rectangle { width: 25; height: 24; color: "#eee"; radius: 2;
                            Text {
                                text: parent.label !== undefined ? parent.label : ""
                                anchors.centerIn: parent
                                font.pixelSize: 11
                            }
                        }
                        TextField {
                            text: parent.val !== undefined ? parent.val : ""
                            width: 50
                            height: 24
                            background: Rectangle { border.color: "#ccc"; radius: 2 }
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

            // Tab Bar
            TabBar {
                Layout.fillWidth: true
                contentHeight: 35
                background: Rectangle { color: "transparent" }

                Repeater {
                    model: ["Program", "Error Pos", "Encoder Offset", "Mech Setting"]
                    TabButton {
                        text: modelData
                        checked: false   // <--- Add this
                        width: implicitWidth + 20

                        contentItem: Text {
                            text: parent.text
                            font.family: fontFamily
                            font.pixelSize: 12
                            font.bold: parent.checked !== undefined && parent.checked
                            color: parent.checked !== undefined && parent.checked ? primaryColor : "#666"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        background: Rectangle {
                            color: parent.checked !== undefined && parent.checked ? "white" : "#e0e0e0"
                            border.color: "#ccc"
                            border.width: 1
                            radius: 4

                            Rectangle {
                                visible: parent.checked !== undefined && parent.checked
                                height: 2
                                anchors.bottom: parent.bottom
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.margins: 1
                                color: "white"
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
                            color: "#f5f5f5"
                            border.width: 0
                            Rectangle { height: 1; anchors.bottom: parent.bottom; width: parent.width; color: "#ddd" }
                            Text {
                                text: "Name        Value        Deg"
                                anchors.verticalCenter: parent.verticalCenter
                                x: 10
                                font.bold: true; color: "#555"; font.pixelSize: 11
                            }
                        }

                        // Content
                        Rectangle {
                            Layout.fillWidth: true
                            height: 30
                            color: Qt.lighter(primaryColor, 1.8) // Selected Row Highlight

                            Text {
                                text: "13   usr_fr   x=749...   0"
                                anchors.verticalCenter: parent.verticalCenter
                                x: 10
                                font.family: "Consolas"
                                font.pixelSize: 12
                                color: "#000"
                            }
                            Rectangle { width: 3; height: parent.height; color: primaryColor } // Selection indicator
                        }
                        Item { Layout.fillHeight: true } // Spacer
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
                            color: "#f5f5f5"
                            Rectangle { height: 1; anchors.bottom: parent.bottom; width: parent.width; color: "#ddd" }
                            Text {
                                text: "   Inst    Name    Value    Deg    Speed"
                                anchors.verticalCenter: parent.verticalCenter
                                font.bold: true; color: "#555"; font.pixelSize: 11
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
                                    color: index % 2 === 0 ? "white" : "#fafafa" // Zebra striping
                                    Text {
                                        text: (index + 1)
                                        anchors.verticalCenter: parent.verticalCenter
                                        x: 15
                                        color: "#555"
                                        font.pixelSize: 12
                                    }
                                    Rectangle { height: 1; width: parent.width; color: "#f0f0f0"; anchors.bottom: parent.bottom }
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
                color: "#f1f3f4" // Slightly darker for footer

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10

                    Text { text: "IP PG:"; font.bold: true; color: "#555" }
                    TextField {
                        placeholderText: "tpn..."
                        Layout.preferredWidth: 100
                        background: Rectangle { color: "white"; border.color: "#ccc"; radius: 3 }
                    }

                    TabBar {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 30
                        background: Rectangle { color: "transparent" }
                        TabButton { text: "Inst"; width: 80 }
                        TabButton { text: "Debug"; width: 80 }
                        TabButton { text: "Jog Deg"; width: 80 }
                    }
                }
            }
        }
    }
}
