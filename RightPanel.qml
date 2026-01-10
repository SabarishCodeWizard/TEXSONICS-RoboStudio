import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes

Rectangle {
    id: rightPanel
    color: "#1e1e2e" // Dark theme background
    radius: 8

    // --- ACCESS ICONS ---
    IconPaths { id: icons }

    // --- STATE MANAGEMENT ---
    property string currentTab: "Jog"
    property string jogTab: "Cartesian"

    // --- THEME PROPERTIES ---
    property color primaryColor: "#40C4FF"
    property color textMain: "#FFFFFF"
    property color textSec: "#B0BEC5"
    property color textSpeed: "#00ff7f"
    property color panelBg: "#27273A"
    property color borderColor: "#3B3B50"
    property color inputBg: "#151520"
    property string fontFamily: "Segoe UI"

    // --- BUTTON PALETTE (Professional Colors) ---
    property color btnBlue: "#0288D1"
    property color btnGreen: "#00b341"
    property color btnPurple: "#7B1FA2"
    property color btnSlate: "#455A64"  // For Labels acting as buttons
    property color btnTeal: "#00897B"
    property color btnDark: "#37474F"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 15

        // ============================================================
        // 1. TOP HEADER (Buttons - Fixed Height)
        // ============================================================
        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            component StatusButton: Button {
                id: statusBtnRoot
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                property color baseColor: "#546E7A"
                property color txtColor: "white"
                property bool isActive: false
                property string pathData: ""

                background: Rectangle {
                    id: bgRect
                    radius: 6
                    // --- YOUR SPECIFIC GRADIENT STYLING ---
                    gradient: Gradient {
                        GradientStop {
                            position: 0.0
                            color: statusBtnRoot.pressed ? Qt.darker(statusBtnRoot.baseColor, 1.2) : Qt.lighter(statusBtnRoot.baseColor, 1.3)
                            Behavior on color { ColorAnimation { duration: 150 } }
                        }
                        GradientStop {
                            position: 1.0
                            color: statusBtnRoot.pressed ? Qt.darker(statusBtnRoot.baseColor, 1.4) : statusBtnRoot.baseColor
                            Behavior on color { ColorAnimation { duration: 150 } }
                        }
                    }
                    // --- BORDER STYLING ---
                    border.color: statusBtnRoot.isActive ? "white" : Qt.lighter(statusBtnRoot.baseColor, 1.5)
                    border.width: statusBtnRoot.hovered || statusBtnRoot.isActive ? 2 : 1
                    Behavior on border.width { NumberAnimation { duration: 100 } }
                }

                contentItem: RowLayout {
                    id: contentLayout
                    spacing: 8
                    // Center the entire row inside the button
                    anchors.centerIn: parent

                    // Icon Shape
                    Shape {
                        visible: statusBtnRoot.pathData !== ""
                        Layout.preferredWidth: 20
                        Layout.preferredHeight: 20
                        Layout.alignment: Qt.AlignVCenter
                        ShapePath {
                            strokeWidth: 0
                            fillColor: statusBtnRoot.txtColor
                            PathSvg { path: statusBtnRoot.pathData }
                        }
                        scale: 18/24
                        transformOrigin: Item.Center
                    }

                    // Dynamic Text Alignment
                    Text {
                        text: statusBtnRoot.text
                        color: statusBtnRoot.txtColor
                        font.bold: true
                        font.capitalization: Font.AllUppercase

                        // Layout properties for dynamic centering
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        fontSizeMode: Text.Fit
                        minimumPixelSize: 10
                        font.pixelSize: 18
                        style: Text.Outline
                        styleColor: "#80000000"
                    }
                }
                onClicked: rightPanel.currentTab = text
            }

            // --- BUTTON INSTANCES ---

            StatusButton { text: "Speed"; baseColor: "#546E7A"; isActive: currentTab === "Speed"; pathData: icons.gauge }

            StatusButton {
                text: "Jog"
                baseColor: btnBlue
                isActive: currentTab === "Jog"
                pathData: icons.robot
                onClicked: jogPopup.open()

                Popup {
                    id: jogPopup
                    y: parent.height + 5
                    x: (parent.width - width) / 2
                    width: 200
                    padding: 10
                    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
                    background: Rectangle { color: "#1e1e2e"; border.color: "#3f3f5f"; radius: 8 }
                    contentItem: RowLayout {
                        spacing: 10
                        Button {
                            text: "Cartesian"; Layout.fillWidth: true; Layout.preferredHeight: 50
                            background: Rectangle { color: "#0091EA"; radius: 4 }
                            contentItem: Text { text: parent.text; color: "white"; font.bold: true; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter ; style: Text.Outline;styleColor: "#80000000";font.pixelSize : 16  }
                            onClicked: { currentTab = "Jog"; jogTab = "Cartesian"; jogPopup.close() }
                        }
                        Button {
                            text: "Joints"; Layout.fillWidth: true; Layout.preferredHeight: 50
                            background: Rectangle { color: "#0091EA"; radius: 4 }
                            contentItem: Text { text: parent.text; color: "white"; font.bold: true; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter ; style: Text.Outline;styleColor: "#80000000";font.pixelSize : 16  }
                            onClicked: { currentTab = "Jog"; jogTab = "Joints"; jogPopup.close() }
                        }
                    }
                }
            }

            StatusButton {
                text: "Move"
                baseColor: btnGreen
                isActive: currentTab === "Move"
                pathData: icons.target
                onClicked: movePopup.open()

                Popup {
                    id: movePopup
                    y: parent.height + 5
                    x: (parent.width - width) / 2
                    width: 200
                    padding: 10
                    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
                    background: Rectangle { color: "#1e1e2e"; border.color: "#3f3f5f"; radius: 8 }
                    contentItem: RowLayout {
                        spacing: 10
                        Button {
                            text: "Cartesian"; Layout.fillWidth: true; Layout.preferredHeight: 50
                            background: Rectangle { color: "#2E7D32"; radius: 4 }
                            contentItem: Text { text: parent.text; color: "white"; font.bold: true; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter; style: Text.Outline;styleColor: "#80000000";font.pixelSize : 16 }
                            onClicked: { currentTab = "Move"; jogTab = "Cartesian"; movePopup.close() }
                        }
                        Button {
                            text: "Joints"; Layout.fillWidth: true; Layout.preferredHeight: 50
                            background: Rectangle { color: "#2E7D32"; radius: 4 }
                            contentItem: Text { text: parent.text; color: "white"; font.bold: true; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter ; style: Text.Outline;styleColor: "#80000000";font.pixelSize : 16 }
                            onClicked: { currentTab = "Move"; jogTab = "Joints"; movePopup.close() }
                        }
                    }
                }
            }

            StatusButton { text: "Auto"; baseColor: "#6A1B9A"; isActive: currentTab === "Auto"; pathData: icons.refresh }
            StatusButton { text: "Manual"; baseColor: "#4527A0"; isActive: currentTab === "Manual"; pathData: icons.settings }
            StatusButton { text: "Remote"; baseColor: "#283593"; isActive: currentTab === "Remote"; pathData: icons.network }
            StatusButton { text: "Emergency"; baseColor: "#C62828"; isActive: currentTab === "Emergency"; pathData: icons.power }
        }
        // ============================================================
        // 2. CONTENT AREA (Split Top 40% / Bottom 60%)
        // ============================================================
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 15

            // --------------------------------------------------------
            // A. TOP ROW (Height: 40%)
            // --------------------------------------------------------
            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: rightPanel.height * 0.4
                spacing: 15

                // --- SECTION 1: TOP-LEFT (Width: 20%) ---
                PanelCard {
                    Layout.preferredWidth: rightPanel.width * 0.2
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    clip: true
                    color: "transparent"
                    border.width: 0

                    // *** VIEW A: SPEED SETTINGS ***
                    ColumnLayout {
                        visible: currentTab === "Speed"
                        anchors.fill: parent
                        spacing: 0

                        Text {
                            text: "SETTINGS"
                            color: "white"
                            font.bold: true
                            font.pixelSize: 14
                            Layout.bottomMargin: 8
                        }

                        ScrollView {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            clip: true
                            contentWidth: availableWidth
                            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                            ScrollBar.vertical.policy: ScrollBar.AsNeeded

                            ColumnLayout {
                                width: parent.width
                                spacing: 10

                                RowLayout {
                                    Layout.fillWidth: true; spacing: 10
                                    Text { text: "MM"; color: textSpeed; font.bold: true; font.pixelSize: 18; Layout.preferredWidth: 60; Layout.alignment: Qt.AlignVCenter }
                                    CustomComboBox { model: ["0.1", "1.0", "10", "100"]; Layout.fillWidth: true }
                                }
                                RowLayout {
                                    Layout.fillWidth: true; spacing: 10
                                    Text { text: "MM/S"; color: textSpeed; font.bold: true; font.pixelSize: 18; Layout.preferredWidth: 60; Layout.alignment: Qt.AlignVCenter }
                                    CustomTextField { text: "100"; Layout.fillWidth: true }
                                }
                                RowLayout {
                                    Layout.fillWidth: true; spacing: 10
                                    Text { text: "Deg"; color: textSpeed; font.bold: true; font.pixelSize: 18; Layout.preferredWidth: 60; Layout.alignment: Qt.AlignVCenter }
                                    CustomComboBox { model: ["Deg", "Rad"]; Layout.fillWidth: true }
                                }
                                RowLayout {
                                    Layout.fillWidth: true; spacing: 10
                                    Text { text: "Deg/S"; color: textSpeed; font.bold: true; font.pixelSize: 18; Layout.preferredWidth: 60; Layout.alignment: Qt.AlignVCenter }
                                    CustomTextField { text: "10"; Layout.fillWidth: true }
                                }
                                RowLayout {
                                    Layout.fillWidth: true; spacing: 10
                                    Text { text: "Frame"; color: textSpeed; font.bold: true; font.pixelSize: 18; Layout.preferredWidth: 60; Layout.alignment: Qt.AlignVCenter }
                                    CustomComboBox { model: ["User", "World", "Tool"]; Layout.fillWidth: true }
                                }
                                Item { Layout.fillHeight: true }
                            }
                        }
                    }

                    // *** VIEW B: JOG BUTTONS ***
                    ColumnLayout {
                        visible: currentTab === "Jog" || currentTab === "Move"
                        anchors.fill: parent
                        spacing: 5

                        // Cartesian Grid
                        GridLayout {
                            visible: jogTab === "Cartesian"
                            columns: 2; rowSpacing: 4; columnSpacing: 4
                            Layout.fillWidth: true; Layout.fillHeight: true
                            Text { text: "NEG"; color: "#EF5350"; font.bold: true; font.pixelSize: 10; Layout.alignment: Qt.AlignHCenter }
                            Text { text: "POS"; color: "#00E676"; font.bold: true; font.pixelSize: 10; Layout.alignment: Qt.AlignHCenter }
                            JogBtn { text: "X-" } JogBtn { text: "X+" }
                            JogBtn { text: "Y-" } JogBtn { text: "Y+" }
                            JogBtn { text: "Z-" } JogBtn { text: "Z+" }
                            JogBtn { text: "Rx-" } JogBtn { text: "Rx+" }
                            JogBtn { text: "Ry-" } JogBtn { text: "Ry+" }
                            JogBtn { text: "Rz-" } JogBtn { text: "Rz+" }
                        }

                        // Joints Grid
                        GridLayout {
                            visible: jogTab === "Joints"
                            columns: 2; rowSpacing: 4; columnSpacing: 4
                            Layout.fillWidth: true; Layout.fillHeight: true
                            Text { text: "NEG"; color: "#EF5350"; font.bold: true; font.pixelSize: 10; Layout.alignment: Qt.AlignHCenter }
                            Text { text: "POS"; color: "#00E676"; font.bold: true; font.pixelSize: 10; Layout.alignment: Qt.AlignHCenter }
                            JogBtn { text: "J1-" } JogBtn { text: "J1+" }
                            JogBtn { text: "J2-" } JogBtn { text: "J2+" }
                            JogBtn { text: "J3-" } JogBtn { text: "J3+" }
                            JogBtn { text: "J4-" } JogBtn { text: "J4+" }
                            JogBtn { text: "J5-" } JogBtn { text: "J5+" }
                            JogBtn { text: "J6-" } JogBtn { text: "J6+" }
                        }
                    }
                }

                // --- SECTION 2: TOP-RIGHT (Width: 80%) ---
                PanelCard {
                    Layout.preferredWidth: rightPanel.width * 0.8
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    clip: true

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 0

                        // 1. Footer Tab Bar
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 30
                            color: "#1e1e2d"

                            RowLayout {
                                anchors.fill: parent
                                spacing: 1
                                Repeater {
                                    model: ["Error Pos", "Ether Cat", "IO Modules"]
                                    Rectangle {
                                        Layout.preferredWidth: 90
                                        Layout.fillHeight: true
                                        color: footerStack.currentIndex === index ? panelBg : "transparent"
                                        border.color: borderColor; border.width: 1
                                        Rectangle { visible: footerStack.currentIndex === index; height: 2; width: parent.width; anchors.top: parent.top; color: primaryColor }
                                        Text { text: modelData; anchors.centerIn: parent; color: footerStack.currentIndex === index ? primaryColor : textSec; font.bold: footerStack.currentIndex === index; font.pixelSize: 12 }
                                        MouseArea { anchors.fill: parent; onClicked: footerStack.currentIndex = index }
                                    }
                                }
                                Item { Layout.fillWidth: true }
                            }
                        }

                        // 2. Footer Content Area
                        StackLayout {
                            id: footerStack
                            currentIndex: 0
                            Layout.fillWidth: true
                            Layout.fillHeight: true


                            // --- TAB 1: Error pos ---
                            Rectangle {
                                color: "#f4f4f4" // Light grey background like the screenshot
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                GridLayout {
                                    anchors.fill: parent
                                    anchors.margins: 10
                                    columns: 7 // Based on the 7 vertical sections in your image
                                    columnSpacing: 15
                                    rowSpacing: 2

                                    // Column 1: Cartesian Start (X-S to c-S)
                                    ColumnLayout {
                                        ErrorField { label: "X-S" }
                                        ErrorField { label: "Y-S" }
                                        ErrorField { label: "Z-S" }
                                        ErrorField { label: "a-S" }
                                        ErrorField { label: "b-S" }
                                        ErrorField { label: "c-S" }
                                    }

                                    // Column 2: Joint Start (J1-S to J6-S)
                                    ColumnLayout {
                                        ErrorField { label: "J1-S" }
                                        ErrorField { label: "J2-S" }
                                        ErrorField { label: "J3-S" }
                                        ErrorField { label: "J4-S" }
                                        ErrorField { label: "J5-S" }
                                        ErrorField { label: "J6-S" }
                                    }

                                    // Column 3: Cartesian End (X-E to c-E)
                                    ColumnLayout {
                                        ErrorField { label: "X-E" }
                                        ErrorField { label: "Y-E" }
                                        ErrorField { label: "Z-E" }
                                        ErrorField { label: "a-E" }
                                        ErrorField { label: "b-E" }
                                        ErrorField { label: "c-E" }
                                    }

                                    // Column 4: Joint End (J1-E to J6-E)
                                    ColumnLayout {
                                        ErrorField { label: "J1-E" }
                                        ErrorField { label: "J2-E" }
                                        ErrorField { label: "J3-E" }
                                        ErrorField { label: "J4-E" }
                                        ErrorField { label: "J5-E" }
                                        ErrorField { label: "J6-E" }
                                    }

                                    // Column 5: Cartesian Error (X-Er to c-Er)
                                    ColumnLayout {
                                        ErrorField { label: "X-Er" }
                                        ErrorField { label: "Y-Er" }
                                        ErrorField { label: "Z-Er" }
                                        ErrorField { label: "a-Er" }
                                        ErrorField { label: "b-Er" }
                                        ErrorField { label: "c-Er" }
                                    }

                                    // Column 6: Joint Error (J1-Er to J6-Er)
                                    ColumnLayout {
                                        ErrorField { label: "J1-Er" }
                                        ErrorField { label: "J2-Er" }
                                        ErrorField { label: "J3-Er" }
                                        ErrorField { label: "J4-Er" }
                                        ErrorField { label: "J5-Er" }
                                        ErrorField { label: "J6-Er" }
                                    }

                                    // Column 7: Special/Info Fields
                                    ColumnLayout {
                                        ErrorField { label: "Sp In" }
                                        ErrorField { label: "fun" }
                                        ErrorField { label: "Num" }
                                        ErrorField { label: "Dist" }
                                        ErrorField { label: "ms" }
                                        ErrorField { label: "Trj" }
                                    }
                                }
                            }

                            // --- TAB 2: Ether Cat (Rectangle 2) ---
                            Rectangle {
                                color: "#f4f4f4" // Light industrial grey background
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                // Reusable component for the label + input pair
                                component DebugField : RowLayout {
                                    property string lblText: ""
                                    property string valText: "0"
                                    spacing: 8
                                    Text {
                                        text: lblText
                                        font.bold: true
                                        font.pixelSize: 13
                                        color: "#333333"
                                        Layout.preferredWidth: 80 // Adjust based on longest label
                                    }
                                    TextField {
                                        text: valText
                                        Layout.preferredWidth: 60
                                        Layout.preferredHeight: 24
                                        font.pixelSize: 12
                                        verticalAlignment: TextInput.AlignVCenter
                                        background: Rectangle {
                                            border.color: "#bcbcbc"
                                            border.width: 1
                                            radius: 2
                                        }
                                    }
                                }

                                ScrollView {
                                    anchors.fill: parent
                                    anchors.margins: 15
                                    clip: true

                                    GridLayout {
                                        width: parent.width
                                        columns: 4 // Four distinct groups of data
                                        columnSpacing: 25
                                        rowSpacing: 2

                                        // Group 1: State
                                        ColumnLayout {
                                            spacing: 2
                                            Repeater {
                                                model: 7
                                                DebugField { lblText: "state " + (index + 1) }
                                            }
                                        }

                                        // Group 2: AI_state
                                        ColumnLayout {
                                            spacing: 2
                                            Repeater {
                                                model: 7
                                                DebugField { lblText: "AI_state " + (index + 1) }
                                            }
                                        }

                                        // Group 3: Status
                                        ColumnLayout {
                                            spacing: 2
                                            Repeater {
                                                model: 7
                                                DebugField { lblText: "status " + (index + 1) }
                                            }
                                        }

                                        // Group 4: et_error
                                        ColumnLayout {
                                            spacing: 2
                                            Repeater {
                                                model: 7
                                                DebugField { lblText: "et_error " + (index + 1) }
                                            }
                                        }
                                    }
                                }
                            }

                            // --- TAB 3: IO Modules / IO View (Rectangle 3) ---
                            Rectangle {
                                color: "#f8f8f8" // Light background matching the screenshot
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                // Reusable component for an IO indicator (Label + Status Box)
                                component Indicator : Column {
                                    property string labelText: ""
                                    property bool isActive: true // Toggle this to change color
                                    spacing: 5
                                    width: 40

                                    Text {
                                        text: labelText
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.pixelSize: 13
                                        color: "#333"
                                    }

                                    Rectangle {
                                        width: 18
                                        height: 18
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        color: isActive ? "#008000" : "#444" // Green if active, dark grey if off
                                        border.color: "#222"
                                        border.width: 1
                                    }
                                }

                                ColumnLayout {
                                    anchors.centerIn: parent
                                    spacing: 20

                                    // Top Row: Digital Inputs (Di1 - Di16)
                                    RowLayout {
                                        spacing: 12
                                        Repeater {
                                            model: 16
                                            Indicator {
                                                labelText: "Di" + (index + 1)
                                                isActive: true // Link to your backend signal here
                                            }
                                        }
                                    }

                                    // Bottom Row: Digital Outputs (Do1 - Do16)
                                    RowLayout {
                                        spacing: 12
                                        Repeater {
                                            model: 16
                                            Indicator {
                                                labelText: "Do" + (index + 1)
                                                isActive: true // Link to your backend signal here
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // --------------------------------------------------------
            // B. BOTTOM ROW (Height: 60%)
            // --------------------------------------------------------
            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: rightPanel.height * 0.6 // Fixed 60% ratio
                spacing: 10

                // --- 1. PANELCARD (Top Table) ---
                PanelCard {
                    Layout.fillWidth: true
                    // FIXED: Use relative calculation from ROOT ID to prevent recursion
                    Layout.preferredHeight: rightPanel.height * 0.6 * 0.35
                    clip: true

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 0

                        // 1. Footer Tab Bar (Middle)
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 28
                            color: "#1e1e2d"

                            RowLayout {
                                anchors.fill: parent
                                spacing: 1
                                Repeater {
                                    model: ["Encoder Offset", "Settings View", "Data Variable","Axis Limit","Mech Settings","Display Settings"]
                                    Rectangle {
                                        Layout.preferredWidth: 90
                                        Layout.fillHeight: true
                                        color: middleStack.currentIndex === index ? panelBg : "transparent"
                                        border.color: borderColor
                                        border.width: 1
                                        Rectangle { visible: middleStack.currentIndex === index; height: 2; width: parent.width; anchors.top: parent.top; color: primaryColor }
                                        Text { text: modelData; anchors.centerIn: parent; color: middleStack.currentIndex === index ? primaryColor : textSec; font.bold: middleStack.currentIndex === index; font.pixelSize: 11 }
                                        MouseArea { anchors.fill: parent; onClicked: middleStack.currentIndex = index }
                                    }
                                }
                                Item { Layout.fillWidth: true }
                            }
                        }

                        // 2. Content Area (Middle)
                        StackLayout {
                            id: middleStack
                            currentIndex: 0
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            // --- TAB 1: Encoder Offset ---
                            Rectangle {
                                color: "#b0b0b0" // Darker grey background to match the screenshot
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                // Internal helper for this specific tab's style
                                component EncoderField : RowLayout {
                                    property string lbl: ""
                                    property bool isButton: false
                                    spacing: 5

                                    Text {
                                        text: lbl
                                        font.bold: true
                                        font.pixelSize: 13
                                        color: "#000000"
                                        Layout.preferredWidth: 120 // Wider for "Encoder Offset" text
                                    }

                                    TextField {
                                        visible: !isButton
                                        Layout.preferredWidth: 100
                                        Layout.preferredHeight: 28
                                        background: Rectangle { border.color: "#999"; radius: 2 }
                                    }

                                    // Handles the "J-Zero" column which looks like buttons/labels in a box
                                    Rectangle {
                                        visible: isButton
                                        Layout.preferredWidth: 80
                                        Layout.preferredHeight: 28
                                        color: "#ffffff"
                                        border.color: "#999"
                                        radius: 2
                                        Text {
                                            text: lbl.split("-")[0].trim() + " - Zero"
                                            anchors.centerIn: parent
                                            font.bold: true
                                            font.pixelSize: 12
                                        }
                                    }
                                }

                                ScrollView {
                                    anchors.fill: parent
                                    anchors.margins: 20
                                    clip: true

                                    GridLayout {
                                        columns: 4 // Pos, Offset, Zero Button, and the final Input column
                                        columnSpacing: 30
                                        rowSpacing: 5

                                        // Column 1: Encoder Pos
                                        ColumnLayout {
                                            spacing: 4
                                            Repeater {
                                                model: 6
                                                EncoderField { lbl: "J" + (index + 1) + "-Encoder Pos" }
                                            }
                                        }

                                        // Column 2: Encoder Offset
                                        ColumnLayout {
                                            spacing: 4
                                            Repeater {
                                                model: 6
                                                EncoderField { lbl: "J" + (index + 1) + "-Encoder Offset" }
                                            }
                                        }

                                        // Column 3: Zero Buttons
                                        ColumnLayout {
                                            spacing: 4
                                            Repeater {
                                                model: 6
                                                EncoderField { lbl: "J" + (index + 1); isButton: true }
                                            }
                                        }

                                        // Column 4: Final Value Inputs
                                        ColumnLayout {
                                            spacing: 4
                                            Repeater {
                                                model: 6
                                                TextField {
                                                    Layout.preferredWidth: 100
                                                    Layout.preferredHeight: 28
                                                    background: Rectangle { border.color: "#999"; radius: 2 }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            // --- TAB 2: Settings View ---

                            Rectangle {
                                color: "#f5f5f5"
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                // *** SETTING FIELD COMPONENT (UPDATED for Tab 2) ***
                                    component SettingField : RowLayout {
                                        property string lbl: ""
                                        property string val: "0"
                                        property bool highlighted: false
                                        spacing: 10

                                        Text {
                                            text: lbl
                                            font.bold: true
                                            font.pixelSize: 13
                                            color: "#333333"
                                            horizontalAlignment: Text.AlignRight
                                            Layout.preferredWidth: 80
                                        }

                                        TextField {
                                            id: settingTf
                                            text: val
                                            Layout.preferredWidth: 70
                                            Layout.preferredHeight: 28
                                            font.pixelSize: 14
                                            font.bold: true

                                            background: Rectangle {
                                                color: highlighted ? "#00ff00" : "white"
                                                border.color: "#999999"
                                                border.width: 1
                                            }

                                            // --- KEYPAD INTEGRATION ---
                                            readOnly: true
                                            MouseArea {
                                                anchors.fill: parent
                                                onClicked: appWindow.showKeypad(settingTf)
                                            }
                                        }
                                    }

                                // Main Container
                                ColumnLayout {
                                    anchors.centerIn: parent
                                    spacing: 30

                                    // Row containing the two columns
                                    RowLayout {
                                        spacing: 50 // Space between the left and right groups

                                        // Left Column (First 3)
                                        ColumnLayout {
                                            spacing: 8
                                            SettingField { lbl: "Ace_tm %"; val: "50"; highlighted: true }
                                            SettingField { lbl: "Dec_tm %"; val: "50" }
                                            SettingField { lbl: "Ace sp %"; val: "100" }
                                        }

                                        // Right Column (Last 3)
                                        ColumnLayout {
                                            spacing: 8
                                            SettingField { lbl: "Dec sp %"; val: "100" }
                                            SettingField { lbl: "Init_vel %"; val: "0" }
                                            SettingField { lbl: "end_vel %"; val: "0" }
                                        }
                                    }

                                    // Action Button centered under the columns
                                    Button {
                                        text: "Ok"
                                        Layout.alignment: Qt.AlignHCenter
                                        Layout.preferredWidth: 120
                                        Layout.preferredHeight: 40

                                        contentItem: Text {
                                            text: parent.text
                                            font.bold: true
                                            font.pixelSize: 16
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }

                                        background: Rectangle {
                                            color: parent.pressed ? "#d0d0d0" : "#efefef"
                                            border.color: "#999999"
                                            border.width: 1
                                            radius: 4
                                        }
                                    }
                                }
                            }

                            // --- TAB 3: Data Variables---
                            Rectangle {
                                color: "#f8f8f8"
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                RowLayout {
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.margins: 20
                                    spacing: 40

                                    // Output Section
                                    ColumnLayout {
                                        spacing: 10
                                        Text { text: "Output"; font.pixelSize: 14 }
                                        RowLayout {
                                            ComboBox {
                                                model: ["Vr_1", "Vr_2", "Vr_3"]
                                                Layout.preferredWidth: 80
                                            }
                                            TextField {
                                                text: "0"
                                                Layout.preferredWidth: 60
                                                background: Rectangle { border.color: "#ccc"; border.width: 1 }
                                            }
                                        }
                                    }

                                    // Input Section
                                    ColumnLayout {
                                        spacing: 10
                                        Text { text: "Input"; font.pixelSize: 14 }
                                        RowLayout {
                                            ComboBox {
                                                model: ["Vr_1", "Vr_2", "Vr_3"]
                                                Layout.preferredWidth: 80
                                            }
                                            TextField {
                                                text: ""
                                                Layout.preferredWidth: 60
                                                background: Rectangle { border.color: "#ccc"; border.width: 1 }
                                            }
                                        }
                                    }

                                    // Inst Number Section
                                    RowLayout {
                                        Layout.alignment: Qt.AlignBottom
                                        spacing: 10
                                        Text { text: "Inst Number"; font.pixelSize: 14 }
                                        TextField {
                                            text: ""
                                            Layout.preferredWidth: 80
                                            background: Rectangle { border.color: "#ccc"; border.width: 1 }
                                        }
                                    }
                                }
                            }

                            // --- TAB 4 :Axis Limit  ---
                            Rectangle {
                                color: "#bcbcbc" // Grey background from final image
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 10
                                    spacing: 20

                                    // Top Row: Outputs and Analogs
                                    RowLayout {
                                        spacing: 10
                                        Text { text: "digital out"; font.bold: true }
                                        TextField { Layout.preferredWidth: 80; Layout.preferredHeight: 25 }

                                        Text { text: "Aanalog"; font.bold: true }
                                        TextField { Layout.preferredWidth: 80; Layout.preferredHeight: 25 }

                                        Text { text: "Aanalog"; font.bold: true }
                                        TextField { Layout.preferredWidth: 80; Layout.preferredHeight: 25 }

                                        // Small status boxes on the right
                                        RowLayout {
                                            spacing: 2
                                            Repeater {
                                                model: ["DI", "DI_Sta", "DO", "Do_Sta", "rem_h", "rem_l"]
                                                Button {
                                                    text: modelData
                                                    Layout.preferredWidth: 55
                                                    Layout.preferredHeight: 25
                                                    font.pixelSize: 10
                                                }
                                            }
                                        }
                                    }

                                    // Bottom Row: Digital Input Buttons
                                    RowLayout {
                                        spacing: 15
                                        Text { text: "digital Input"; font.bold: true; Layout.preferredWidth: 100 }

                                        Repeater {
                                            model: ["High_1", "low_1", "High_2", "low_2", "test_1"]
                                            Button {
                                                text: modelData
                                                Layout.preferredWidth: 90
                                                Layout.preferredHeight: 35
                                                background: Rectangle {
                                                    color: "white"
                                                    border.color: "#999"
                                                    radius: 2
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            // --- TAB 5: Mech Setting (Fixed Version) ---
                            Rectangle {
                                color: "#efebe7"
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 10
                                    spacing: 15

                                    // 1. Labels
                                    ColumnLayout {
                                        Layout.alignment: Qt.AlignTop
                                        spacing: 5
                                        Text { text: "Dh-nal"; font.bold: true; font.pixelSize: 16 }
                                        Repeater {
                                            model: ["l1 l+-7", "l3 l+:8", "l4 l+:8", "l6 l+:5", "l7 l5", "l5 <"]
                                            Text { text: modelData; font.pixelSize: 14; Layout.preferredHeight: 25 }
                                        }
                                    }

                                    // 2. Data Columns
                                    Repeater {
                                        id: columnRepeater
                                        model: [
                                            { title: "Encod", w: 70 },
                                            { title: "Gear R", w: 70 },
                                            { title: "couple", w: 70 },
                                            { title: "joint min", w: 85 },
                                            { title: "joint max", w: 85 }
                                        ]

                                        delegate: ColumnLayout {
                                            Layout.alignment: Qt.AlignTop
                                            spacing: 2

                                            // Use 'modelData' from the 'delegate' scope safely
                                            readonly property real colWidth: modelData.w

                                            Rectangle {
                                                Layout.preferredWidth: colWidth
                                                Layout.preferredHeight: 25
                                                color: "transparent"
                                                border.color: "black"
                                                Text { text: modelData.title; anchors.centerIn: parent; font.bold: true }
                                            }

                                            Repeater {
                                                model: 6
                                                TextField {
                                                    // We use the property 'colWidth' from the parent ColumnLayout
                                                    // to avoid 'undefined' errors from nested modelData
                                                    Layout.preferredWidth: colWidth
                                                    Layout.preferredHeight: 25
                                                    background: Rectangle { border.color: "#999"; border.width: 1 }
                                                }
                                            }
                                        }
                                    }

                                    // ... (Rest of your buttons)
                                }
                            }


                            // --- TAB: View Selection ---
                            Rectangle {
                                color: "#efebe7" // Light industrial beige-grey
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                ColumnLayout {
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.margins: 20
                                    spacing: 0 // Buttons are stacked without gaps like the image

                                    Repeater {
                                        model: ["Front", "Back", "Left", "Right", "Top", "Bottom", "Default"]

                                        Button {
                                            id: viewButton
                                            text: modelData
                                            Layout.preferredWidth: 100
                                            Layout.preferredHeight: 30

                                            // Custom styling to match the sharp, stacked look
                                            background: Rectangle {
                                                color: viewButton.pressed ? "#d0d0d0" : "#ffffff"
                                                border.color: "#999999"
                                                border.width: 1
                                                // Only apply rounded corners to the very top and bottom buttons
                                                radius: (index === 0) ? 4 : (index === 6) ? 4 : 0
                                            }

                                            contentItem: Text {
                                                text: viewButton.text
                                                font.bold: true
                                                font.pixelSize: 14
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                                color: "#000000"
                                            }

                                            onClicked: {
                                                console.log("View switched to: " + modelData)
                                                // Add your camera logic here
                                            }
                                        }
                                    }
                                }
                            }


                        }
                    }
                }

                // --- 2. MIDDLE ACTION BUTTONS (2 Rows x 7 Columns) ---
                GridLayout {
                    Layout.fillWidth: true
                    // FIXED: Use relative calculation from ROOT ID to prevent recursion
                    Layout.preferredHeight: rightPanel.height * 0.6 * 0.15
                    columns: 7
                    rowSpacing: 8
                    columnSpacing: 8
                    uniformCellWidths: true

                    // --- ROW 1 ---
                    // 1. Inst (Blue)
                    ActionBtn {
                        text: "Inst"
                        baseColor: btnBlue
                        pathData: icons.document
                        onClicked: instPopup.open()
                        Popup {
                            id: instPopup
                            y: parent.height + 5; x: 0; width: 150; padding: 5
                            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
                            background: Rectangle { color: panelBg; border.color: borderColor; radius: 6 }
                            contentItem: ColumnLayout {
                                spacing: 5
                                ActionBtn { text: "Insert Inst"; baseColor: btnBlue; pathData: icons.document; Layout.preferredHeight: 35; onClicked: { console.log("Insert Inst"); instPopup.close() } }
                                ActionBtn { text: "Modify Inst"; baseColor: btnBlue; pathData: icons.document; Layout.preferredHeight: 35; onClicked: { console.log("Modify Inst"); instPopup.close() } }
                                ActionBtn { text: "Delete Inst"; baseColor: "#FF5252"; pathData: icons.exit; Layout.preferredHeight: 35; onClicked: { console.log("Delete Inst"); instPopup.close() } }
                            }
                        }
                    }
                    // 2. Run Inst (Green)
                    ActionBtn { text: "Run Inst"; baseColor: btnGreen; pathData: icons.play; onClicked: console.log("Run Inst") }
                    // 3. TP (Purple)
                    ActionBtn {
                        text: "TP"
                        baseColor: btnPurple
                        pathData: icons.target
                        onClicked: tpPopup.open()
                        Popup {
                            id: tpPopup
                            y: parent.height + 5; x: 0; width: 150; padding: 5
                            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
                            background: Rectangle { color: panelBg; border.color: borderColor; radius: 6 }
                            contentItem: ColumnLayout {
                                spacing: 5
                                ActionBtn { text: "Insert TP"; baseColor: btnPurple; pathData: icons.target; Layout.preferredHeight: 35; onClicked: { console.log("Insert TP"); tpPopup.close() } }
                                ActionBtn { text: "Modify TP"; baseColor: btnPurple; pathData: icons.target; Layout.preferredHeight: 35; onClicked: { console.log("Modify TP"); tpPopup.close() } }
                                ActionBtn { text: "Delete TP"; baseColor: "#FF5252"; pathData: icons.exit; Layout.preferredHeight: 35; onClicked: { console.log("Delete TP"); tpPopup.close() } }
                            }
                        }
                    }
                    // 4. Run TP (Green)
                    ActionBtn { text: "Run TP"; baseColor: btnGreen; pathData: icons.play; onClicked: console.log("Run TP") }
                    // 5. TP Mode (Purple)
                    ActionBtn {
                        text: "TP Mode"
                        baseColor: btnPurple
                        pathData: icons.settings
                        onClicked: tpMode.open()
                        Popup {
                            id: tpMode
                            y: parent.height + 5; x: 0; width: 150; padding: 5
                            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
                            background: Rectangle { color: panelBg; border.color: borderColor; radius: 6 }
                            contentItem: ColumnLayout {
                                spacing: 5
                                ActionBtn { text: "TP 1"; baseColor: btnPurple; Layout.preferredHeight: 35; onClicked: { tpMode.close() } }
                                ActionBtn { text: "TP 2"; baseColor: btnPurple; Layout.preferredHeight: 35; onClicked: { tpMode.close() } }
                            }
                        }
                    }
                    // 6. Op Pg Label (Slate)
                    ActionBtn { text: "Op Pg"; baseColor: btnSlate; pathData: icons.page }
                    // 7. Input
                    GridInput { placeholderText: "0" }

                    // --- ROW 2 ---
                    // 1. Ip Pg (Slate)
                    ActionBtn { text: "Ip Pg"; baseColor: btnSlate; pathData: icons.page }
                    // 2. Input
                    GridInput { placeholderText: "0" }
                    // 3. Tnp (Slate)
                    ActionBtn { text: "Tnp"; baseColor: btnSlate; pathData: icons.tag }
                    // 4. Input
                    GridInput { placeholderText: "0" }
                    // 5. Com (Slate)
                    ActionBtn { text: "Com"; baseColor: btnSlate; pathData: icons.network }
                    // 6. Input
                    GridInput { placeholderText: "0" }
                    // 7. Calc Traj (Teal)
                    ActionBtn { text: "Calc Traj"; baseColor: btnTeal; pathData: icons.calculator; onClicked: console.log("Calc Trajectory") }
                }

                // --- 3. PANELCARD (Bottom Table) ---
                PanelCard {
                    Layout.fillWidth: true
                    // FIXED: Use relative calculation from ROOT ID to prevent recursion
                    Layout.preferredHeight: rightPanel.height * 0.6 * 0.32
                    clip: true

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 0

                        // 1. Footer Tab Bar
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 28
                            color: "#1e1e2d"

                            RowLayout {
                                anchors.fill: parent
                                spacing: 1
                                Repeater {
                                    model: ["Inst", "Debug", "Jog Deg"]
                                    Rectangle {
                                        Layout.preferredWidth: 90
                                        Layout.fillHeight: true
                                        color: bottomStack.currentIndex === index ? panelBg : "transparent"
                                        border.color: borderColor
                                        border.width: 1
                                        Rectangle { visible: bottomStack.currentIndex === index; height: 2; width: parent.width; anchors.top: parent.top; color: primaryColor }
                                        Text { text: modelData; anchors.centerIn: parent; color: bottomStack.currentIndex === index ? primaryColor : textSec; font.bold: bottomStack.currentIndex === index; font.pixelSize: 11 }
                                        MouseArea { anchors.fill: parent; onClicked: bottomStack.currentIndex = index }
                                    }
                                }
                                Item { Layout.fillWidth: true }
                            }
                        }

                        // 2. Content
                        StackLayout {
                            id: bottomStack
                            currentIndex: 0
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            // Tab 1
                            Rectangle {
                                color: "transparent"
                                ScrollView {
                                    anchors.fill: parent; clip: true
                                    ScrollBar.horizontal.policy: ScrollBar.AlwaysOn
                                    ScrollBar.vertical.policy: ScrollBar.AlwaysOn
                                    Column {
                                        Row {
                                            FooterCell { txt: "Sl No"; w: 50; header: true }
                                            FooterCell { txt: "Inst"; w: 60; header: true }
                                            FooterCell { txt: "Name"; w: 80; header: true }
                                            FooterCell { txt: "Value_1"; w: 80; header: true }
                                            FooterCell { txt: "Deg_1"; w: 60; header: true }
                                            FooterCell { txt: "Name"; w: 80; header: true }
                                            FooterCell { txt: "Value_2"; w: 80; header: true }
                                            FooterCell { txt: "Deg_2"; w: 60; header: true }
                                            FooterCell { txt: "Inst"; w: 60; header: true }
                                            FooterCell { txt: "Name"; w: 80; header: true }
                                            FooterCell { txt: "Value_1"; w: 80; header: true }
                                            FooterCell { txt: "Deg_1"; w: 60; header: true }
                                            FooterCell { txt: "Name"; w: 80; header: true }
                                        }
                                        Repeater {
                                            model: 3
                                            Row {
                                                FooterCell { txt: (index + 1).toString(); w: 50 }
                                                FooterCell { txt: ""; w: 60 }
                                                FooterCell { txt: ""; w: 80 }
                                                FooterCell { txt: ""; w: 80 }
                                                FooterCell { txt: ""; w: 60 }
                                                FooterCell { txt: ""; w: 80 }
                                                FooterCell { txt: ""; w: 80 }
                                                FooterCell { txt: ""; w: 60 }
                                                FooterCell { txt: ""; w: 60 }
                                                FooterCell { txt: ""; w: 80 }
                                                FooterCell { txt: ""; w: 80 }
                                                FooterCell { txt: ""; w: 60 }
                                                FooterCell { txt: ""; w: 80 }
                                            }
                                        }
                                    }
                                }
                            }
                            Rectangle { color: "transparent"; Text { text: "Debug View"; color: textSec; anchors.centerIn: parent } }
                            Rectangle { color: "transparent"; Text { text: "Jog Degrees View"; color: textSec; anchors.centerIn: parent } }
                        }
                    }
                }

                // --- 4. BOTTOM GRID (11 Columns - Matching Image) ---
                GridLayout {
                    Layout.fillWidth: true
                    // FIXED: Use relative calculation from ROOT ID to prevent recursion
                    Layout.preferredHeight: rightPanel.height * 0.6 * 0.15
                    columns: 11
                    rowSpacing: 6
                    columnSpacing: 4
                    uniformCellWidths: true

                    // --- ROW 1 ---
                    CustomComboBox { model: ["Inst","Inst","Inst","Inst","Inst","Inst"]; Layout.fillWidth: true }
                    CustomComboBox { model: ["Di-1","Di-1","Di-1","Di-1","Di-1","Di-1"]; Layout.fillWidth: true }
                    CustomComboBox { model: ["Di-2","Di-2","Di-2","Di-2","Di-2","Di-2"]; Layout.fillWidth: true }
                    ActionBtn { text: "H/L"; baseColor: btnSlate; pathData: icons.switchIcon }
                    CustomComboBox { model: ["Dig","Dig","Dig","Dig","Dig","Dig","Dig"]; Layout.fillWidth: true }
                    ActionBtn { text: "delay"; baseColor: btnSlate; pathData: icons.clock }
                    GridInput { placeholderText: "" }
                    ActionBtn { text: "go to"; baseColor: btnSlate; pathData: icons.arrow }
                    GridInput { placeholderText: "" }
                    ActionBtn { text: "loop"; baseColor: btnSlate; pathData: icons.loop }
                    GridInput { placeholderText: "" }

                    // --- ROW 2 ---
                    ActionBtn { text: "mm/s"; baseColor: btnSlate; pathData: icons.gauge }
                    GridInput { placeholderText: "" }
                    ActionBtn { text: "Radius"; baseColor: btnSlate; pathData: icons.gauge }
                    GridInput { placeholderText: "" }
                    CustomComboBox { model: ["Vr_1","Vr_1","Vr_1","Vr_1","Vr_1","Vr_1","Vr_1"]; Layout.fillWidth: true }
                    GridInput { placeholderText: "" }
                    CustomComboBox { model: ["Vr_2","Vr_2","Vr_2","Vr_2","Vr_2","Vr_2","Vr_2"]; Layout.fillWidth: true }
                    ActionBtn { text: "AN ip"; baseColor: btnSlate; pathData: icons.network }
                    GridInput { placeholderText: "" }
                    ActionBtn { text: "AN op"; baseColor: btnSlate; pathData: icons.network }
                    GridInput { placeholderText: "" }
                }
            }
        }
    }

    // --- HELPER COMPONENTS ---
    component PanelCard: Rectangle { color: panelBg; radius: 8; border.color: borderColor; border.width: 1 }

    component FooterCell: Rectangle {
        property string txt: ""
        property int w: 200
        property bool header: false
        width: w; height: 30
        color: header ? "#32324A" : "transparent"
        border.color: borderColor
        Text {
            text: parent.txt
            anchors.centerIn: parent
            color: parent.header ? textSec : textMain
            font.bold: parent.header
            font.pixelSize: 12
        }
    }

    // *** ACTION BUTTON ***
    // FIXED: Added ID 'btnRoot' to resolve ReferenceError/TypeError
    component ActionBtn: Button {
        id: btnRoot
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredHeight: 35
        property color baseColor: primaryColor // Default to Primary Blue
        property string pathData: "" // Path data for icon

        background: Rectangle {
            color: btnRoot.pressed ? Qt.darker(btnRoot.baseColor, 1.2) : (btnRoot.baseColor === primaryColor ? primaryColor : btnRoot.baseColor)
            radius: 4
            border.color: Qt.lighter(btnRoot.color, 1.2)
            border.width: 1
        }
        contentItem: RowLayout {
            spacing: 4
            // Icon
            Shape {
                visible: btnRoot.pathData !== ""
                Layout.preferredWidth: 14
                Layout.preferredHeight: 14
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                ShapePath {
                    strokeWidth: 0
                    fillColor: "white"
                    PathSvg { path: btnRoot.pathData }
                }
                // Scale normalization if needed (assumes 24x24 icons)
                scale: 14/24
                transformOrigin: Item.Center
            }
            // Text
            Text {
                text: btnRoot.text
                color: "white"
                font.bold: true
                font.pixelSize: 16 // Smaller font to fit grid
                fontSizeMode: Text.Fit
                style: Text.Outline
                styleColor: "#80000000"
                minimumPixelSize: 8
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                Layout.fillWidth: true
            }
        }
    }

    // *** GRID INPUT (UPDATED) ***
        component GridInput: TextField {
            id: gridInputRoot
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 35
            background: Rectangle {
                color: inputBg
                border.color: borderColor
                radius: 4
            }
            color: "white"
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            leftPadding: 4; rightPadding: 4

            // --- KEYPAD INTEGRATION ---
            readOnly: true // Prevent physical keyboard popping up on mobile/touch
            MouseArea {
                anchors.fill: parent
                onClicked: appWindow.showKeypad(gridInputRoot)
            }
        }

    // *** JOG BUTTON ***
    component JogBtn: Button {
        id: jogBtnControl
        Layout.fillWidth: true
        Layout.fillHeight: true
        background: Rectangle {
            color: jogBtnControl.pressed ? "#f5f5f5" : "#ffffff"
            radius: 4
            border.color: "#3f3f5f"
            border.width: 1
        }
        contentItem: Text {
            text: jogBtnControl.text
            color: text.indexOf("-") != -1 ? "#FF5252" : (text.indexOf("+") != -1 ? "#3cb371" : "#FFFFFF")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            fontSizeMode: Text.Fit
            minimumPixelSize: 10
            font.pixelSize: 25
            rightPadding: 4
            leftPadding: 4
            style: Text.Outline
            styleColor: "#80000000"
        }
    }

    // *** STYLIZED COMBO BOX ***
    component CustomComboBox: ComboBox {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredHeight: 35
        model: ["Option"]
        delegate: ItemDelegate {
            width: parent.width
            contentItem: Text {
                text: modelData
                color: "black"
                font.pixelSize: 12
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
            }
            background: Rectangle { color: highlighted ? "#40C4FF" : "#ffffff" }
        }
        background: Rectangle {
            color: "#ffffff"
            border.color: "#3B3B50"
            radius: 4
        }
        contentItem: Text {
            text: parent.displayText
            color: "black"
            verticalAlignment: Text.AlignVCenter
            leftPadding: 8
            font.pixelSize: 12
            elide: Text.ElideRight
        }
    }

    // *** STYLIZED TEXT FIELD (UPDATED) ***
        component CustomTextField: TextField {
            id: customFieldRoot
            Layout.preferredHeight: 30
            background: Rectangle {
                color: "#ffffff"
                border.color: "#3B3B50"
                radius: 4
            }
            color: "black"
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 18
            leftPadding: 10

            // --- KEYPAD INTEGRATION ---
            readOnly: true
            MouseArea {
                anchors.fill: parent
                onClicked: appWindow.showKeypad(customFieldRoot)
            }
        }

    // *** ERROR FIELD COMPONENT (UPDATED) ***
        component ErrorField : RowLayout {
            property string label: ""
            property string value: "0"
            spacing: 5
            Layout.fillWidth: true

            Text {
                text: label
                color: "black"
                font.pixelSize: 12
                Layout.preferredWidth: 35
            }
            TextField {
                id: errorTf
                text: value
                Layout.fillWidth: true
                Layout.preferredHeight: 25
                color: "black"
                background: Rectangle {
                    border.color: "#999"
                    border.width: 1
                }

                // --- KEYPAD INTEGRATION ---
                readOnly: true
                MouseArea {
                    anchors.fill: parent
                    onClicked: appWindow.showKeypad(errorTf)
                }
            }
        }
}
