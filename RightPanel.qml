import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

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
                // MM Increment Dropdown
                RowLayout {
                    spacing: 0
                    Rectangle {
                        Layout.preferredWidth: 50
                        Layout.preferredHeight: 28
                        color: "#2F2F40"
                        border.color: borderColor
                        radius: 3
                        Rectangle { width: 5; height: parent.height; anchors.right: parent.right; color: parent.color }
                        Text {
                            text: "mm"
                            anchors.centerIn: parent
                            color: textSec
                            font.family: fontFamily
                            font.bold: true
                            font.pixelSize: 11
                        }
                    }
                    ComboBox {
                        id: mmCombo
                        Layout.fillWidth: true
                        Layout.preferredHeight: 28
                        model: ["50", "25", "15", "10", "5", "2", "1", "0.1", "0.01", "0.001"]
                        currentIndex: 3
                        background: Rectangle {
                            color: inputBg
                            border.color: parent.activeFocus || parent.down ? primaryColor : borderColor
                            border.width: 1
                            radius: 3
                            Rectangle { width: 5; height: parent.height; anchors.left: parent.left; color: parent.color }
                        }
                        contentItem: Text {
                            text: parent.displayText
                            color: textMain
                            font.family: fontFamily
                            font.pixelSize: 12
                            verticalAlignment: Text.AlignVCenter
                            leftPadding: 10
                        }
                        popup: Popup {
                            y: parent.height + 1
                            width: parent.width
                            implicitHeight: contentItem.implicitHeight
                            padding: 1
                            contentItem: ListView {
                                clip: true
                                implicitHeight: contentHeight
                                model: mmCombo.popup.visible ? mmCombo.delegateModel : null
                                currentIndex: mmCombo.highlightedIndex
                                ScrollIndicator.vertical: ScrollIndicator { }
                            }
                            background: Rectangle {
                                color: panelBg
                                border.color: primaryColor
                                radius: 3
                            }
                        }
                        delegate: ItemDelegate {
                            width: parent.width
                            height: 24
                            contentItem: Text {
                                text: modelData
                                color: parent.hovered ? primaryColor : textMain
                                font.family: fontFamily
                                font.pixelSize: 12
                                verticalAlignment: Text.AlignVCenter
                                leftPadding: 10
                            }
                            background: Rectangle {
                                color: parent.hovered ? "#32324A" : "transparent"
                            }
                        }
                    }
                }

                ValueBox { labelText: "mm/s"; valueText: "1" }

                // Degree Increment Dropdown
                RowLayout {
                    spacing: 0
                    Rectangle {
                        Layout.preferredWidth: 50
                        Layout.preferredHeight: 28
                        color: "#2F2F40"
                        border.color: borderColor
                        radius: 3
                        Rectangle { width: 5; height: parent.height; anchors.right: parent.right; color: parent.color }
                        Text {
                            text: "Deg"
                            anchors.centerIn: parent
                            color: textSec
                            font.family: fontFamily
                            font.bold: true
                            font.pixelSize: 11
                        }
                    }
                    ComboBox {
                        id: degCombo
                        Layout.fillWidth: true
                        Layout.preferredHeight: 28
                        model: ["20", "15", "10", "5", "2", "1", "0.1", "0.01", "0.001"]
                        currentIndex: 2
                        background: Rectangle {
                            color: inputBg
                            border.color: parent.activeFocus || parent.down ? primaryColor : borderColor
                            border.width: 1
                            radius: 3
                            Rectangle { width: 5; height: parent.height; anchors.left: parent.left; color: parent.color }
                        }
                        contentItem: Text {
                            text: parent.displayText
                            color: textMain
                            font.family: fontFamily
                            font.pixelSize: 12
                            verticalAlignment: Text.AlignVCenter
                            leftPadding: 10
                        }
                        popup: Popup {
                            y: parent.height + 1
                            width: parent.width
                            implicitHeight: contentItem.implicitHeight
                            padding: 1
                            contentItem: ListView {
                                clip: true
                                implicitHeight: contentHeight
                                model: degCombo.popup.visible ? degCombo.delegateModel : null
                                currentIndex: degCombo.highlightedIndex
                                ScrollIndicator.vertical: ScrollIndicator { }
                            }
                            background: Rectangle {
                                color: panelBg
                                border.color: primaryColor
                                radius: 3
                            }
                        }
                        delegate: ItemDelegate {
                            width: parent.width
                            height: 24
                            contentItem: Text {
                                text: modelData
                                color: parent.hovered ? primaryColor : textMain
                                font.family: fontFamily
                                font.pixelSize: 12
                                verticalAlignment: Text.AlignVCenter
                                leftPadding: 10
                            }
                            background: Rectangle {
                                color: parent.hovered ? "#32324A" : "transparent"
                            }
                        }
                    }
                }

                ValueBox { labelText: "deg/s"; valueText: "1" }

                // Frame Dropdown
                RowLayout {
                    spacing: 0
                    Rectangle {
                        Layout.preferredWidth: 50
                        Layout.preferredHeight: 28
                        color: "#2F2F40"
                        border.color: borderColor
                        radius: 3
                        Rectangle { width: 5; height: parent.height; anchors.right: parent.right; color: parent.color }
                        Text {
                            text: "frames"
                            anchors.centerIn: parent
                            color: textSec
                            font.family: fontFamily
                            font.bold: true
                            font.pixelSize: 11
                        }
                    }
                    ComboBox {
                        id: frameCombo
                        Layout.fillWidth: true
                        Layout.preferredHeight: 28
                        model: ["Frame","Base", "Tool", "User"]
                        currentIndex: 0
                        background: Rectangle {
                            color: inputBg
                            border.color: parent.activeFocus || parent.down ? primaryColor : borderColor
                            border.width: 1
                            radius: 3
                            Rectangle { width: 5; height: parent.height; anchors.left: parent.left; color: parent.color }
                        }
                        contentItem: Text {
                            text: parent.displayText
                            color: textMain
                            font.family: fontFamily
                            font.pixelSize: 12
                            verticalAlignment: Text.AlignVCenter
                            leftPadding: 10
                        }
                        popup: Popup {
                            y: parent.height + 1
                            width: parent.width
                            implicitHeight: contentItem.implicitHeight
                            padding: 1
                            contentItem: ListView {
                                clip: true
                                implicitHeight: contentHeight
                                model: frameCombo.popup.visible ? frameCombo.delegateModel : null
                                currentIndex: frameCombo.highlightedIndex
                                ScrollIndicator.vertical: ScrollIndicator { }
                            }
                            background: Rectangle {
                                color: panelBg
                                border.color: primaryColor
                                radius: 3
                            }
                        }
                        delegate: ItemDelegate {
                            width: parent.width
                            height: 24
                            contentItem: Text {
                                text: modelData
                                color: parent.hovered ? primaryColor : textMain
                                font.family: fontFamily
                                font.pixelSize: 12
                                verticalAlignment: Text.AlignVCenter
                                leftPadding: 10
                            }
                            background: Rectangle {
                                color: parent.hovered ? "#32324A" : "transparent"
                            }
                        }
                    }
                }

                Item { height: 5; Layout.fillWidth: true } // Spacer

                // Slider (Left) and Ovr Input (Right) side-by-side
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 8

                    // Slider Component
                    Slider {
                        id: speedSlider
                        value: 1.0 // Default 100%
                        from: 0.0
                        to: 1.2    // Max 120%
                        Layout.fillWidth: true // Takes available space on the left
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
                            implicitWidth: 14 // Slightly smaller handle
                            implicitHeight: 14
                            radius: 7
                            color: primaryColor
                        }
                    }

                    // Ovr Input Section
                    RowLayout {
                        spacing: 4
                        Layout.preferredWidth: 70 // Fixed width for the right side
                        Text {
                            text: "Ovr"
                            font.pixelSize: 11
                            color: textSec
                            font.bold: true
                        }
                        TextField {
                            text: Math.round(speedSlider.value * 100) + "%" // Bind text to slider value
                            Layout.fillWidth: true
                            Layout.preferredHeight: 24
                            font.pixelSize: 11
                            color: textMain
                            horizontalAlignment: Text.AlignHCenter
                            background: Rectangle {
                                color: inputBg
                                border.color: borderColor
                                radius: 3
                            }
                        }
                    }
                }
            } // CLOSING BRACE FOR COL 1 (This was likely missing!)

            Rectangle { width: 1; Layout.fillHeight: true; color: borderColor } // Divider

            // Col 2: Cartesian
            ColumnLayout {
                Layout.alignment: Qt.AlignTop
                Layout.fillWidth: true

                AxisControl { labelStart: "X+"; valueText: "0.00"; labelEnd: "X-" }
                AxisControl { labelStart: "Y+"; valueText: "0.00"; labelEnd: "Y-" }
                AxisControl { labelStart: "Z+"; valueText: "0.00"; labelEnd: "Z-" }
                AxisControl { labelStart: "Rx+"; valueText: "0.00"; labelEnd: "Rx-" }
                AxisControl { labelStart: "Ry+"; valueText: "0.00"; labelEnd: "Ry-" }
                AxisControl { labelStart: "Rz+"; valueText: "0.00"; labelEnd: "Rz-" }
            }

            Rectangle { width: 1; Layout.fillHeight: true; color: borderColor } // Divider

            // Col 3: Joints
            ColumnLayout {
                Layout.alignment: Qt.AlignTop
                Layout.fillWidth: true

                AxisControl { labelStart: "J1+"; valueText: "0.00"; labelEnd: "J1-"; labelColor: accentColor }
                AxisControl { labelStart: "J2+"; valueText: "0.00"; labelEnd: "J2-"; labelColor: accentColor }
                AxisControl { labelStart: "J3+"; valueText: "0.00"; labelEnd: "J3-"; labelColor: accentColor }
                AxisControl { labelStart: "J4+"; valueText: "0.00"; labelEnd: "J4-"; labelColor: accentColor }
                AxisControl { labelStart: "J5+"; valueText: "0.00"; labelEnd: "J5-"; labelColor: accentColor }
                AxisControl { labelStart: "J6+"; valueText: "0.00"; labelEnd: "J6-"; labelColor: accentColor }
            }
        }
    }

    // Small Offset Grid (7 Columns x 2 Rows)
        PanelCard {
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            color: "#1e1e2e"

            GridLayout {
                anchors.centerIn: parent
                columns: 7
                rowSpacing: 8
                columnSpacing: 10

                // Row 1
                MiniInput { label: "a"; val: "0" }
                MiniInput { label: "b"; val: "0" }
                MiniInput { label: "c"; val: "0" }
                MiniInput { label: "qw"; val: "0" }
                MiniInput { label: "qx"; val: "0" }
                MiniInput { label: "qy"; val: "0" }
                MiniInput { label: "qz"; val: "0" }

                // Row 2
                MiniInput { label: "Fr"; val: "0" }
                MiniInput { label: "Fx"; val: "0" }
                MiniInput { label: "Fy"; val: "0" }
                MiniInput { label: "Fz"; val: "0" }
                MiniInput { label: "FRx"; val: "0" }
                MiniInput { label: "FRy"; val: "0" }
                MiniInput { label: "FRz"; val: "0" }
            }
        }

    // --- TOP MENU BAR (Scrollable) ---
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 35
                    color: "transparent"

                    ListView {
                        id: menuBarList
                        anchors.fill: parent
                        orientation: ListView.Horizontal
                        clip: true
                        spacing: 4

                        // The selected index controls the StackLayout below
                        property int selectedIndex: 0

                        model: ["Program", "Error pos", "Encoder offset", "Mech Setting", "Display Setting", "Monitoring log", "Axis limit"]

                        delegate: MouseArea {
                            width: textItem.implicitWidth + 30
                            height: parent.height
                            onClicked: menuBarList.selectedIndex = index

                            Rectangle {
                                anchors.fill: parent
                                color: menuBarList.selectedIndex === index ? panelBg : "transparent"
                                border.color: menuBarList.selectedIndex === index ? borderColor : "transparent"
                                border.width: 1
                                radius: 4

                                // Top Highlight Line for active tab
                                Rectangle {
                                    visible: menuBarList.selectedIndex === index
                                    height: 2; width: parent.width
                                    anchors.top: parent.top; color: primaryColor
                                }

                                Text {
                                    id: textItem
                                    text: modelData
                                    anchors.centerIn: parent
                                    color: menuBarList.selectedIndex === index ? primaryColor : textSec
                                    font.family: fontFamily
                                    font.bold: menuBarList.selectedIndex === index
                                    font.pixelSize: 12
                                }
                            }
                        }
                    }
                }


                // --- MAIN CONTENT AREA (Switches based on Menu) ---
                            StackLayout {
                                currentIndex: menuBarList.selectedIndex
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                // ============================================================
                                // INDEX 0: PROGRAM VIEW (Two Tables)
                                // ============================================================
                                RowLayout {
                                    spacing: 10

                                    // Helper Component for Table Cells
                                    component TableCell: Rectangle {
                                        property string textVal: ""
                                        property int cellWidth: 80
                                        property bool isHeader: false
                                        property bool isSelected: false

                                        width: cellWidth
                                        height: 28
                                        color: isSelected ? primaryColor : (isHeader ? "#32324A" : "transparent")
                                        border.color: borderColor
                                        border.width: 1

                                        Text {
                                            text: parent.textVal
                                            anchors.centerIn: parent
                                            font.family: fontFamily
                                            font.pixelSize: 12
                                            font.bold: parent.isHeader
                                            color: parent.isSelected ? "#FFFFFF" : (parent.isHeader ? textSec : textMain)
                                        }
                                    }

                                    // --- LEFT TABLE ---
                                    PanelCard {
                                        Layout.fillHeight: true
                                        Layout.preferredWidth: 450
                                        clip: true

                                        ScrollView {
                                            anchors.fill: parent
                                            clip: true
                                            ScrollBar.horizontal.policy: ScrollBar.AlwaysOn
                                            ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                                            Column {
                                                Row {
                                                    TableCell { textVal: "Name"; cellWidth: 80; isHeader: true }
                                                    TableCell { textVal: "Value"; cellWidth: 140; isHeader: true }
                                                    TableCell { textVal: "Deg"; cellWidth: 60; isHeader: true }
                                                    TableCell { textVal: "Tools"; cellWidth: 60; isHeader: true }
                                                    TableCell { textVal: "Frames"; cellWidth: 60; isHeader: true }
                                                }
                                                Repeater {
                                                    model: 15
                                                    Row {
                                                        property bool isRow1: index === 0
                                                        TableCell { textVal: "usr_fr_" + index; cellWidth: 80 }
                                                        TableCell { textVal: "x=749.99..."; cellWidth: 140; isSelected: isRow1 }
                                                        TableCell { textVal: "0"; cellWidth: 60 }
                                                        TableCell { textVal: "1"; cellWidth: 60 }
                                                        TableCell { textVal: "0"; cellWidth: 60 }
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    // --- RIGHT TABLE ---
                                    PanelCard {
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                        clip: true

                                        ScrollView {
                                            anchors.fill: parent
                                            clip: true
                                            ScrollBar.horizontal.policy: ScrollBar.AlwaysOn
                                            ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                                            Column {
                                                Row {
                                                    TableCell { textVal: "Inst"; cellWidth: 40; isHeader: true }
                                                    TableCell { textVal: "Name"; cellWidth: 60; isHeader: true }
                                                    TableCell { textVal: "Value"; cellWidth: 60; isHeader: true }
                                                    TableCell { textVal: "Deg"; cellWidth: 40; isHeader: true }
                                                    TableCell { textVal: "Speed"; cellWidth: 50; isHeader: true }
                                                    TableCell { textVal: "Radius"; cellWidth: 50; isHeader: true }
                                                    TableCell { textVal: "Tool"; cellWidth: 40; isHeader: true }
                                                    TableCell { textVal: "Fr"; cellWidth: 40; isHeader: true }
                                                    TableCell { textVal: "Cmt"; cellWidth: 60; isHeader: true }
                                                    TableCell { textVal: "Distance"; cellWidth: 70; isHeader: true }
                                                    TableCell { textVal: "Time"; cellWidth: 60; isHeader: true }
                                                }
                                                Repeater {
                                                    model: 15
                                                    Row {
                                                        TableCell { textVal: (index + 1).toString(); cellWidth: 40 }
                                                        TableCell { textVal: index % 2 == 0 ? "MOVL" : "MOVJ"; cellWidth: 60 }
                                                        TableCell { textVal: "P["+index+"]"; cellWidth: 60 }
                                                        TableCell { textVal: "100"; cellWidth: 40 }
                                                        TableCell { textVal: "50%"; cellWidth: 50 }
                                                        TableCell { textVal: "0"; cellWidth: 50 }
                                                        TableCell { textVal: "1"; cellWidth: 40 }
                                                        TableCell { textVal: "0"; cellWidth: 40 }
                                                        TableCell { textVal: "--"; cellWidth: 60 }
                                                        TableCell { textVal: "10.5mm"; cellWidth: 70 }
                                                        TableCell { textVal: "0.5s"; cellWidth: 60 }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }

                                // ============================================================
                                // INDEX 1: ERROR POS VIEW
                                // ============================================================
                                PanelCard {
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true

                                    component CompactRow: RowLayout {
                                        property string lbl: "Label"
                                        property string val: "0.00"
                                        spacing: 5
                                        Text {
                                            text: parent.lbl
                                            Layout.preferredWidth: 35
                                            font.pixelSize: 11
                                            font.bold: true
                                            color: textSec
                                            horizontalAlignment: Text.AlignRight
                                        }
                                        TextField {
                                            text: parent.val
                                            Layout.fillWidth: true
                                            Layout.preferredHeight: 26
                                            font.pixelSize: 12
                                            color: textMain
                                            background: Rectangle { color: inputBg; border.color: borderColor; radius: 3 }
                                            selectByMouse: true
                                        }
                                    }

                                    ScrollView {
                                        anchors.fill: parent
                                        anchors.margins: 10
                                        contentHeight: contentRow.height

                                        RowLayout {
                                            id: contentRow
                                            width: parent.width
                                            spacing: 15

                                            // Start/Set (S)
                                            RowLayout {
                                                spacing: 10
                                                ColumnLayout {
                                                    CompactRow { lbl: "X-S"; val: "0.758652" }
                                                    CompactRow { lbl: "Y-S"; val: "0.02999" }
                                                    CompactRow { lbl: "Z-S"; val: "0.50001" }
                                                    CompactRow { lbl: "a-S"; val: "-3.14154" }
                                                    CompactRow { lbl: "b-S"; val: "0.348813" }
                                                    CompactRow { lbl: "c-S"; val: "3.14156" }
                                                }
                                                ColumnLayout {
                                                    CompactRow { lbl: "J1-S"; val: "2.37066" }
                                                    CompactRow { lbl: "J2-S"; val: "8.80115" }
                                                    CompactRow { lbl: "J3-S"; val: "53.337" }
                                                    CompactRow { lbl: "J4-S"; val: "-5.89241" }
                                                    CompactRow { lbl: "J5-S"; val: "7.93357" }
                                                    CompactRow { lbl: "J6-S"; val: "8.06656" }
                                                }
                                            }
                                            Rectangle { width: 1; height: 160; color: borderColor } // Divider
                                            // End (E)
                                            RowLayout {
                                                spacing: 10
                                                ColumnLayout {
                                                    CompactRow { lbl: "X-E"; val: "0.758737" }
                                                    CompactRow { lbl: "Y-E"; val: "0.029896" }
                                                    CompactRow { lbl: "Z-E"; val: "0.49996" }
                                                    CompactRow { lbl: "a-E"; val: "-3.14154" }
                                                    CompactRow { lbl: "b-E"; val: "0.348813" }
                                                    CompactRow { lbl: "c-E"; val: "3.14156" }
                                                }
                                                ColumnLayout {
                                                    CompactRow { lbl: "J1-E"; val: "2.37038" }
                                                    CompactRow { lbl: "J2-E"; val: "8.81232" }
                                                    CompactRow { lbl: "J3-E"; val: "53.3297" }
                                                    CompactRow { lbl: "J4-E"; val: "-5.89453" }
                                                    CompactRow { lbl: "J5-E"; val: "7.92974" }
                                                    CompactRow { lbl: "J6-E"; val: "8.06845" }
                                                }
                                            }
                                            Rectangle { width: 1; height: 160; color: borderColor } // Divider
                                            // Error (Er)
                                            RowLayout {
                                                spacing: 10
                                                ColumnLayout {
                                                    CompactRow { lbl: "X-Er"; val: "0" }
                                                    CompactRow { lbl: "Y-Er"; val: "0" }
                                                    CompactRow { lbl: "Z-Er"; val: "0" }
                                                    CompactRow { lbl: "a-Er"; val: "0" }
                                                    CompactRow { lbl: "b-Er"; val: "0" }
                                                    CompactRow { lbl: "c-Er"; val: "0" }
                                                }
                                                ColumnLayout {
                                                    CompactRow { lbl: "J1-Er"; val: "0" }
                                                    CompactRow { lbl: "J2-Er"; val: "0" }
                                                    CompactRow { lbl: "J3-Er"; val: "0" }
                                                    CompactRow { lbl: "J4-Er"; val: "0" }
                                                    CompactRow { lbl: "J5-Er"; val: "0" }
                                                    CompactRow { lbl: "J6-Er"; val: "0" }
                                                }
                                            }
                                            Rectangle { width: 1; height: 160; color: borderColor } // Divider
                                            // Stats
                                            ColumnLayout {
                                                CompactRow { lbl: "Sp In"; val: "5" }
                                                CompactRow { lbl: "fun"; val: "1" }
                                                CompactRow { lbl: "Num"; val: "0" }
                                                CompactRow { lbl: "Dist"; val: "9.9e-05" }
                                                CompactRow { lbl: "ms"; val: "0.140723" }
                                                CompactRow { lbl: "Trl"; val: "0" }
                                            }
                                            Item { Layout.fillWidth: true }
                                        }
                                    }
                                }

                                // ============================================================
                                // INDEX 2: ENCODER OFFSET VIEW
                                // ============================================================
                                PanelCard {
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true

                                    // Local component for this view
                                    component EncoderRow: RowLayout {
                                        property string labelText: "Label"
                                        spacing: 8

                                        Text {
                                            text: parent.labelText
                                            Layout.preferredWidth: 120 // Adjusted for label length
                                            font.pixelSize: 12
                                            font.bold: true
                                            color: textSec
                                            horizontalAlignment: Text.AlignLeft
                                        }
                                        TextField {
                                            text: "" // Empty in screenshot
                                            Layout.fillWidth: true
                                            Layout.preferredHeight: 28
                                            font.pixelSize: 12
                                            color: textMain
                                            background: Rectangle {
                                                color: inputBg
                                                border.color: borderColor
                                                radius: 3
                                            }
                                        }
                                    }

                                    RowLayout {
                                        anchors.fill: parent
                                        anchors.margins: 20
                                        spacing: 30 // Space between main columns

                                        // Column 1: Encoder Pos
                                        ColumnLayout {
                                            spacing: 10
                                            Layout.alignment: Qt.AlignTop
                                            Repeater {
                                                model: 6
                                                EncoderRow { labelText: "J" + (index + 1) + "-Encoder Pos" }
                                            }
                                        }

                                        // Column 2: Encoder Offset
                                        ColumnLayout {
                                            spacing: 10
                                            Layout.alignment: Qt.AlignTop
                                            Repeater {
                                                model: 6
                                                EncoderRow { labelText: "J" + (index + 1) + "-Encoder Offset" }
                                            }
                                        }

                                        // Column 3: Zero
                                        ColumnLayout {
                                            spacing: 10
                                            Layout.alignment: Qt.AlignTop
                                            Repeater {
                                                model: 6
                                                EncoderRow { labelText: "J" + (index + 1) + " - Zero" }
                                            }
                                        }

                                        Item { Layout.fillWidth: true } // Fill remaining space
                                    }
                                }

                                // ============================================================
                                // INDEX 3+: Placeholders for remaining tabs
                                // ============================================================
                                Repeater {
                                    model: 4 // Handles indices 3, 4, 5, 6
                                    Rectangle {
                                        color: "transparent"
                                        Text {
                                            text: "Settings View " + (index + 3)
                                            color: textSec
                                            anchors.centerIn: parent
                                        }
                                    }
                                }
                            }


                            // ============================================================
                                        // FOOTER TABBED SECTION (Inst, Debug, Jog Deg)
                                        // ============================================================
                                        PanelCard {
                                            Layout.fillWidth: true
                                            Layout.preferredHeight: 180 // Increased height for the table
                                            clip: true

                                            ColumnLayout {
                                                anchors.fill: parent
                                                spacing: 0

                                                // 1. Footer Tab Bar
                                                Rectangle {
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30
                                                    color: "#1e1e2d" // Slightly darker header background

                                                    RowLayout {
                                                        anchors.fill: parent
                                                        spacing: 1

                                                        Repeater {
                                                            model: ["Inst", "Debug", "Jog Deg"]

                                                            Rectangle {
                                                                Layout.preferredWidth: 90
                                                                Layout.fillHeight: true
                                                                // Active: Panel Color, Inactive: Darker
                                                                color: footerStack.currentIndex === index ? panelBg : "transparent"
                                                                border.color: borderColor
                                                                border.width: 1

                                                                // Top Highlight for active tab
                                                                Rectangle {
                                                                    visible: footerStack.currentIndex === index
                                                                    height: 2; width: parent.width
                                                                    anchors.top: parent.top
                                                                    color: primaryColor
                                                                }

                                                                Text {
                                                                    text: modelData
                                                                    anchors.centerIn: parent
                                                                    color: footerStack.currentIndex === index ? primaryColor : textSec
                                                                    font.bold: footerStack.currentIndex === index
                                                                    font.pixelSize: 12
                                                                }

                                                                MouseArea {
                                                                    anchors.fill: parent
                                                                    onClicked: footerStack.currentIndex = index
                                                                }
                                                            }
                                                        }
                                                        Item { Layout.fillWidth: true } // Spacer
                                                    }
                                                }

                                                // 2. Footer Content Area
                                                StackLayout {
                                                    id: footerStack
                                                    currentIndex: 0
                                                    Layout.fillWidth: true
                                                    Layout.fillHeight: true

                                                    // --- TAB 1: INST (The Table from Screenshot) ---
                                                    Rectangle {
                                                        color: "transparent"

                                                        // Local Cell Component for this table
                                                        component FooterCell: Rectangle {
                                                            property string txt: ""
                                                            property int w: 80
                                                            property bool header: false
                                                            width: w; height: 26
                                                            color: header ? "#32324A" : "transparent" // Header styling
                                                            border.color: borderColor

                                                            Text {
                                                                text: parent.txt
                                                                anchors.centerIn: parent
                                                                color: parent.header ? textSec : textMain
                                                                font.bold: parent.header
                                                                font.pixelSize: 11
                                                            }
                                                        }

                                                        ScrollView {
                                                            anchors.fill: parent
                                                            clip: true
                                                            ScrollBar.horizontal.policy: ScrollBar.AlwaysOn
                                                            ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                                                            Column {
                                                                // Table Header
                                                                Row {
                                                                    FooterCell { txt: "Sl No"; w: 50; header: true }
                                                                    FooterCell { txt: "Inst"; w: 60; header: true }
                                                                    FooterCell { txt: "Name"; w: 80; header: true }
                                                                    FooterCell { txt: "Value_1"; w: 80; header: true }
                                                                    FooterCell { txt: "Deg_1"; w: 60; header: true }
                                                                    FooterCell { txt: "Name"; w: 80; header: true }
                                                                    FooterCell { txt: "Value_2"; w: 80; header: true }
                                                                    FooterCell { txt: "Deg_2"; w: 60; header: true }
                                                                }

                                                                // Table Rows (Empty placeholders)
                                                                Repeater {
                                                                    model: 8 // Number of visible rows
                                                                    Row {
                                                                        FooterCell { txt: (index + 1).toString(); w: 50 } // Sl No
                                                                        FooterCell { txt: ""; w: 60 }
                                                                        FooterCell { txt: ""; w: 80 }
                                                                        FooterCell { txt: ""; w: 80 }
                                                                        FooterCell { txt: ""; w: 60 }
                                                                        FooterCell { txt: ""; w: 80 }
                                                                        FooterCell { txt: ""; w: 80 }
                                                                        FooterCell { txt: ""; w: 60 }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }

                                                    // --- TAB 2: DEBUG (Placeholder) ---
                                                    Rectangle {
                                                        color: "transparent"
                                                        Text { text: "Debug View"; color: textSec; anchors.centerIn: parent }
                                                    }

                                                    // --- TAB 3: JOG DEG (Placeholder) ---
                                                    Rectangle {
                                                        color: "transparent"
                                                        Text { text: "Jog Degrees View"; color: textSec; anchors.centerIn: parent }
                                                    }
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

                        // Row 1
                        ActionButton { text: "Insert Inst"; Layout.fillWidth: true }
                        ActionButton { text: "Delete Inst"; Layout.fillWidth: true }
                        ActionButton { text: "New Prg"; Layout.fillWidth: true }
                        ActionButton { text: "Del Prg"; Layout.fillWidth: true }
                        ActionButton { text: "Open Prg"; Layout.fillWidth: true }
                        ActionButton { text: "Open Prg"; Layout.fillWidth: true }
                        StatusButton { text: "Trj Calc"; baseColor: primaryColor; Layout.fillWidth: true }

                        // Row 2
                        // UPDATED: Dropdown (Moves UPWARDS now)
                        ComboBox {
                            id: moveTypeCombo
                            Layout.fillWidth: true
                            Layout.preferredHeight: 28

                            model: ["Tp", "MOVL", "MOVJ"]
                            currentIndex: 1 // Default to "MOVL"

                            background: Rectangle {
                                color: inputBg
                                border.color: parent.activeFocus || parent.down ? primaryColor : borderColor
                                border.width: 1
                                radius: 4
                            }

                            contentItem: Text {
                                text: parent.displayText
                                color: textMain
                                font.family: fontFamily
                                font.pixelSize: 12
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                            }

                            popup: Popup {
                                // CHANGED: negative y value moves it UP
                                y: -height - 2
                                width: parent.width
                                implicitHeight: contentItem.implicitHeight
                                padding: 1

                                contentItem: ListView {
                                    clip: true
                                    implicitHeight: contentHeight
                                    model: moveTypeCombo.popup.visible ? moveTypeCombo.delegateModel : null
                                    currentIndex: moveTypeCombo.highlightedIndex
                                }

                                background: Rectangle {
                                    color: panelBg
                                    border.color: primaryColor
                                    radius: 4
                                }
                            }

                            delegate: ItemDelegate {
                                width: parent.width
                                height: 24
                                contentItem: Text {
                                    text: modelData
                                    color: parent.hovered ? primaryColor : textMain
                                    font.family: fontFamily
                                    font.pixelSize: 12
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                }
                                background: Rectangle {
                                    color: parent.hovered ? "#32324A" : "transparent"
                                }
                            }
                        }

                        ActionButton { text: "Run Tp"; Layout.fillWidth: true }
                        ActionButton { text: "Add Tp"; Layout.fillWidth: true }
                        ActionButton { text: "Modify Tp"; Layout.fillWidth: true }
                        ActionButton { text: "Delete Tp"; Layout.fillWidth: true }
                        ActionButton { text: "New Tp F1"; Layout.fillWidth: true }
                        ActionButton { text: "Open Tp F1"; Layout.fillWidth: true }
                        ActionButton { text: "Del Tp F1"; Layout.fillWidth: true }
                    }
                }

                PanelCard {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 110
                    color: "#1e1e2e"

                    // --- Internal Styling Components ---
                    component StyledLabel : Label {
                        color: "#ffffff"
                        padding: 5
                        font.pixelSize: 12
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        background: Rectangle {
                            color: "#2b2b3b"
                            border.color: "#3f3f5f"
                            border.width: 1
                            radius: 4
                        }
                    }

                    component StyledInput : TextField {
                        Layout.preferredWidth: 60
                        Layout.preferredHeight: 30
                        color: "#ffffff"
                        font.pixelSize: 12
                        verticalAlignment: Text.AlignVCenter
                        background: Rectangle {
                            color: "#11111b"
                            border.color: "#3f3f5f"
                            radius: 4
                        }
                    }

                    // --- UPDATED COMBOBOX COMPONENT ---
                    component StyledCombo : ComboBox {
                        id: control
                        Layout.preferredHeight: 30
                        font.pixelSize: 12

                        // Custom background for the button itself
                        background: Rectangle {
                            color: "#2b2b3b"
                            border.color: parent.activeFocus || parent.down ? "#5aa5ff" : "#3f3f5f" // added focus color
                            radius: 4
                        }

                        // Custom Text display
                        contentItem: Text {
                            text: control.displayText
                            color: "#ffffff"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            elide: Text.ElideRight
                            leftPadding: 5
                            rightPadding: 5
                        }

                        // The Dropdown Popup (Configured to open UPWARDS)
                        popup: Popup {
                            // Logic to open upwards: Move Y position up by the height of the popup + a small margin
                            y: -height - 2
                            width: control.width
                            implicitHeight: contentItem.implicitHeight
                            padding: 1

                            contentItem: ListView {
                                clip: true
                                implicitHeight: contentHeight
                                model: control.popup.visible ? control.delegateModel : null
                                currentIndex: control.highlightedIndex
                                ScrollIndicator.vertical: ScrollIndicator { }
                            }

                            background: Rectangle {
                                color: "#2b2b3b" // Match panel bg
                                border.color: "#3f3f5f"
                                radius: 4
                            }
                        }

                        // The Individual Items in the list
                        delegate: ItemDelegate {
                            width: control.width
                            height: 30
                            contentItem: Text {
                                text: modelData
                                color: parent.hovered ? "#5aa5ff" : "#ffffff" // Highlight color on hover
                                font: control.font
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                            }
                            background: Rectangle {
                                color: parent.hovered ? "#32324A" : "transparent"
                            }
                        }
                    }

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 8

                        // First Row
                        RowLayout {
                            spacing: 8

                            // Inst: inst1 to inst5
                            StyledCombo {
                                model: ["inst1", "inst2", "inst3", "inst4", "inst5"]
                                Layout.preferredWidth: 85
                            }

                            // Di-1: Di1 to Di5
                            StyledCombo {
                                model: ["Di1", "Di2", "Di3", "Di4", "Di5"]
                                Layout.preferredWidth: 75
                            }

                            // Di-2: D21 to D25
                            StyledCombo {
                                model: ["D21", "D22", "D23", "D24", "D25"]
                                Layout.preferredWidth: 75
                            }

                            Button {
                                text: "H/L"
                                Layout.preferredWidth: 45
                                Layout.preferredHeight: 30
                                contentItem: Text {
                                    text: "H/L"
                                    color: "#ffffff"
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.bold: true
                                }
                                background: Rectangle { color: "#2b2b3b"; border.color: "#3f3f5f"; radius: 4 }
                            }

                            // Dig: Dig1 to Dig5
                            StyledCombo {
                                model: ["Dig1", "Dig2", "Dig3", "Dig4", "Dig5"]
                                Layout.preferredWidth: 75
                            }

                            StyledLabel { text: "delay ms" }
                            StyledInput { }

                            StyledLabel { text: "go to" }
                            StyledInput { }

                            StyledLabel { text: "loop" }
                            StyledInput { }
                        }

                        // Second Row
                        RowLayout {
                            spacing: 8

                            StyledLabel { text: "mm/s" }
                            StyledInput { }

                            StyledLabel { text: "Radius" }
                            StyledInput { }

                            // Vr_1: v1 to v5
                            StyledCombo {
                                model: ["v1", "v2", "v3", "v4", "v5"]
                                Layout.preferredWidth: 75
                            }

                            StyledInput { }

                            // Vr_2: vd1 to vd5
                            StyledCombo {
                                model: ["vd1", "vd2", "vd3", "vd4", "vd5"]
                                Layout.preferredWidth: 75
                            }

                            StyledLabel { text: "AN ip" }
                            StyledInput { }

                            StyledLabel { text: "AN op" }
                            StyledInput { }
                        }
                    }
                }
}
