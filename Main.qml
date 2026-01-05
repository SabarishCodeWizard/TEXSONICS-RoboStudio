import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

ApplicationWindow {
    visible: true
    width: 1400
    height: 900
    title: "Robot Control Interface"
    color: "#f0f0f0" // Light professional background

    // --- REUSABLE COMPONENTS ---

    // 1. A standard label-input pair (e.g., "mm 10", "X+ 795.5")
    component ValueBox: RowLayout {
        property string labelText: "Label"
        property string valueText: "0"
        property color btnColor: "#e0e0e0"
        spacing: 2

        Rectangle {
            width: 60; height: 30
            color: btnColor
            border.color: "#ccc"
            Text {
                text: labelText
                anchors.centerIn: parent
                font.bold: true
                font.pixelSize: 12
            }
        }
        TextField {
            text: valueText
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            background: Rectangle { color: "white"; border.color: "#ccc" }
            font.pixelSize: 12
            horizontalAlignment: Text.AlignLeft
        }
    }

    // 2. A green/red status button
    component StatusButton: Button {
        property color baseColor: "#4CAF50"
        background: Rectangle {
            color: parent.down ? Qt.darker(baseColor, 1.2) : baseColor
            radius: 2
        }
        contentItem: Text {
            text: parent.text
            color: "white"
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    // --- MAIN LAYOUT ---

    RowLayout {
        anchors.fill: parent
        anchors.margins: 5
        spacing: 5

        // === LEFT PANEL (3D View & Main Controls) ===
        ColumnLayout {
            Layout.preferredWidth: parent.width * 0.45
            Layout.fillHeight: true
            spacing: 5

            // Logo Header Placeholder
            Rectangle {
                Layout.fillWidth: true
                height: 50
                color: "white"
                border.color: "#ccc"
                Text {
                    text: "TEXSONICS"
                    font.bold: true; font.pixelSize: 24; color: "#0277BD"
                    anchors.centerIn: parent
                }
            }

            // 3D Viewport Placeholder
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#fafafa"
                border.color: "#999"

                Image {
                    // Placeholder for where the 3D robot would render
                    source: ""
                    anchors.centerIn: parent
                }

                Grid {
                    // Grid lines simulation
                    anchors.fill: parent
                    opacity: 0.1
                    rows: 20
                    columns: 20

                    Repeater {
                        model: 400
                        Rectangle {
                            width: parent.width / 20
                            height: parent.height / 20
                            border.color: "black"
                            color: "transparent"
                        }
                    }
                }

                // Label container (replaces invalid Text properties)
                Rectangle {
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.margins: 10

                    color: "#dddddd"
                    radius: 4

                    implicitWidth: titleText.implicitWidth + 10
                    implicitHeight: titleText.implicitHeight + 6

                    Text {
                        id: titleText
                        text: "Robot 3D View"
                        anchors.centerIn: parent
                        font.pixelSize: 14
                        color: "#666666"
                    }
                }
            }


            // Bottom Operation Controls (Sim, Real, Pause, etc.)
            GridLayout {
                columns: 6
                rowSpacing: 5
                columnSpacing: 5
                Layout.fillWidth: true

                StatusButton { text: "Sim"; baseColor: "#4CAF50"; Layout.fillWidth: true }
                StatusButton { text: "Real"; baseColor: "#9E9E9E"; Layout.fillWidth: true }

                StatusButton {
                    text: "On_Off"
                    baseColor: "#f0f0f0"
                    Layout.fillWidth: true
                    contentItem: Text {
                        text: "On_Off"
                        color: "black"
                        anchors.centerIn: parent
                        font.pixelSize: 12
                    }
                }

                StatusButton {
                    text: "Error clr"
                    baseColor: "#f0f0f0"
                    Layout.fillWidth: true
                    contentItem: Text {
                        text: "Error clr"
                        color: "black"
                        anchors.centerIn: parent
                        font.pixelSize: 12
                    }
                }

                StatusButton {
                    text: "Mark Clr"
                    baseColor: "#f0f0f0"
                    Layout.fillWidth: true
                    contentItem: Text {
                        text: "Mark Clr"
                        color: "black"
                        anchors.centerIn: parent
                        font.pixelSize: 12
                    }
                }

                StatusButton { text: "Home"; baseColor: "#4CAF50"; Layout.fillWidth: true }

                StatusButton { text: "pause_run"; baseColor: "#4CAF50"; Layout.fillWidth: true }
                StatusButton { text: "start_stop"; baseColor: "#F44336"; Layout.fillWidth: true }
                StatusButton { text: "Exit"; baseColor: "#F44336"; Layout.fillWidth: true }

                Button { text: "Close"; Layout.fillWidth: true }

                RowLayout {
                    Layout.columnSpan: 2
                    Text { text: "speed op" }
                    TextField { text: "0.05"; Layout.preferredWidth: 60 }
                }

                Rectangle {
                    color: "red"
                    Layout.columnSpan: 2
                    Layout.fillWidth: true
                    height: 30

                    Text {
                        text: "No error"
                        color: "white"
                        anchors.centerIn: parent
                        font.bold: true
                    }
                }

                Button { text: "Add tool" }
                Button { text: "Tool ip" }
                TextField { Layout.fillWidth: true }
                Button {
                    text: "Eth rst"
                    background: Rectangle { color: "#4CAF50" }
                }
            }

        }

        // === RIGHT PANEL (Parameters, Jogging, Tables) ===
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 5

            // Top Control Bar (Emer_stop, Move, Jog...)
            RowLayout {
                spacing: 10
                StatusButton { text: "Emer_stop"; baseColor: "#4CAF50" }
                StatusButton { text: "Move"; baseColor: "#F44336" } // Red
                Button { text: "Jog"; implicitWidth: 80 }
                Button { text: "Auto"; implicitWidth: 80 }
                StatusButton { text: "Manual"; baseColor: "#4CAF50" }
                Button { text: "Remote"; implicitWidth: 80 }
            }

            // Cartesian & Joint Coordinates Grid
            RowLayout {
                Layout.fillWidth: true
                spacing: 10

                // Left Column: Parameters (mm, deg, frames)
                ColumnLayout {
                    Layout.alignment: Qt.AlignTop
                    ValueBox { labelText: "mm"; valueText: "10" }
                    ValueBox { labelText: "mm/s"; valueText: "1" }
                    ValueBox { labelText: "Deg"; valueText: "deg" }
                    ValueBox { labelText: "deg/s"; valueText: "1" }
                    ValueBox { labelText: "frames"; valueText: "Base" }

                    RowLayout {
                        Slider { value: 0.5; Layout.fillWidth: true }
                        TextField { text: "100"; implicitWidth: 50 }
                    }
                }

                // Middle Column: Cartesian (X, Y, Z, Rx...)
                ColumnLayout {
                    Layout.alignment: Qt.AlignTop
                    ValueBox { labelText: "X+"; valueText: "795.5" }
                    ValueBox { labelText: "Y+"; valueText: "0" }
                    ValueBox { labelText: "Z+"; valueText: "1174" }
                    ValueBox { labelText: "Rx+"; valueText: "0" }
                    ValueBox { labelText: "Ry+"; valueText: "0" }
                    ValueBox { labelText: "Rz+"; valueText: "0" }
                }
                 // Right Column: Cartesian Negatives (Placeholder labels as per image logic)
                ColumnLayout {
                    Layout.alignment: Qt.AlignTop
                    ValueBox { labelText: "X-"; valueText: "-" }
                    ValueBox { labelText: "Y-"; valueText: "-" }
                    ValueBox { labelText: "Z-"; valueText: "-" }
                    ValueBox { labelText: "Rx-"; valueText: "-" }
                    ValueBox { labelText: "Ry-"; valueText: "-" }
                    ValueBox { labelText: "Rz-"; valueText: "-" }
                }

                // Far Right Column: Joints (J1 - J6)
                ColumnLayout {
                    Layout.alignment: Qt.AlignTop
                    ValueBox { labelText: "J1+"; valueText: "0" }
                    ValueBox { labelText: "J2+"; valueText: "0" }
                    ValueBox { labelText: "J3+"; valueText: "0" }
                    ValueBox { labelText: "J4+"; valueText: "0" }
                    ValueBox { labelText: "J5+"; valueText: "89.99" }
                    ValueBox { labelText: "J6+"; valueText: "0" }
                }
                 // Far Right Column: Joints Negatives
                ColumnLayout {
                    Layout.alignment: Qt.AlignTop
                    ValueBox { labelText: "J1-"; valueText: "-" }
                    ValueBox { labelText: "J2-"; valueText: "-" }
                    ValueBox { labelText: "J3-"; valueText: "-" }
                    ValueBox { labelText: "J4-"; valueText: "-" }
                    ValueBox { labelText: "J5-"; valueText: "-" }
                    ValueBox { labelText: "J6-"; valueText: "-" }
                }
            }

            // Small offset grid (a, b, c, qw, qx...)
            GridLayout {
                columns: 8
                Layout.fillWidth: true
                rowSpacing: 2; columnSpacing: 2

                // Row 1
                Label { text: "a"; background: Rectangle{color:"#ddd"} }
                TextField { text: "0"; implicitWidth: 40 }
                Label { text: "b"; background: Rectangle{color:"#ddd"} }
                TextField { text: "180"; implicitWidth: 40 }
                Label { text: "c"; background: Rectangle{color:"#ddd"} }
                TextField { text: "0"; implicitWidth: 40 }

                Label { text: "qw"; background: Rectangle{color:"#ddd"} }
                TextField { implicitWidth: 40 }
                // ... (simplified for brevity, can duplicate for qx, qy, qz)
            }

            // Tab Bar / Middle Section Headers
            TabBar {
                Layout.fillWidth: true
                TabButton { text: "Program" }
                TabButton { text: "Error pos" }
                TabButton { text: "Encoder offset" }
                TabButton { text: "Mech Setting" }
            }

            // Data Tables Area
            RowLayout {
                Layout.fillHeight: true
                Layout.fillWidth: true

                // Table 1 (Left)
                Rectangle {
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width * 0.3
                    border.color: "#ccc"
                    color: "white"
                    Column {
                        width: parent.width
                        padding: 5
                        Text { text: "Name   Value    Deg"; font.bold: true }
                        Rectangle { height: 1; width: parent.width; color: "#ccc" }
                        Rectangle {
                            color: "#2196F3"
                            opacity: 0.3
                            Layout.fillWidth: true
                            height: 30

                            Text {
                                text: "13  usr_fr   x=749...  0"
                                anchors.centerIn: parent
                                font.pixelSize: 12
                            }
                        }

                    }
                }

                // Table 2 (Right)
                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    border.color: "#ccc"
                    color: "white"
                    Column {
                        width: parent.width
                        padding: 5
                        Text { text: "   Inst    Name    Value    Deg    Speed"; font.bold: true }
                        Rectangle { height: 1; width: parent.width; color: "#ccc" }
                        // Empty Rows
                        Repeater { model: 5; Text { text: index + 1; padding: 5 } }
                    }
                }
            }

            // Bottom Right Control Grid (Insert, Delete, File ops)
            GridLayout {
                columns: 6
                Layout.fillWidth: true
                columnSpacing: 2
                rowSpacing: 2

                Button { text: "Insert Inst" }
                Button { text: "Delete Inst" }
                Button { text: "New Prg File" }
                Button { text: "Del Prg File" }
                Button { text: "Open Prg File" }
                StatusButton { text: "Trj Calc"; baseColor: "#4CAF50" }

                Button { text: "MOVL" }
                Button { text: "Run Tp" }
                Button { text: "Add Tp" }
                Button { text: "modify Tp" }
                Button { text: "Delete Tp" }
                Button { text: "New Tp f1" }
            }

            // Footer Input Area
            Rectangle {
                Layout.fillWidth: true
                height: 100
                border.color: "#ccc"
                color: "#f9f9f9"

                GridLayout {
                    anchors.fill: parent
                    anchors.margins: 5
                    columns: 4

                    Text { text: "ip pg" }
                    TextField { placeholderText: "tpn" }

                    // Simple representation of the tabbed input area at bottom right
                    TabBar {
                         Layout.columnSpan: 2
                         Layout.fillWidth: true
                         TabButton { text: "Inst" }
                         TabButton { text: "Debug" }
                         TabButton { text: "Jog Deg" }
                    }
                }
            }
        }
    }
}
