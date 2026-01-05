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
                color: "#ffffff" // Even darker for viewport

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
                            border.color: "#000000" // White lines, low opacity
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

                    ActionButton { text: "On_Off"; Layout.fillWidth: true }
                    ActionButton { text: "Error Clr"; Layout.fillWidth: true }
                    ActionButton { text: "Mark Clr"; Layout.fillWidth: true }
                    StatusButton { text: "Home"; baseColor: primaryColor; Layout.fillWidth: true }

                    StatusButton { text: "Pause_Run"; baseColor: warningColor; Layout.fillWidth: true }
                    StatusButton { text: "Start_Stop"; baseColor: dangerColor; Layout.fillWidth: true }
                    StatusButton { text: "Exit"; baseColor: "#78909c"; Layout.fillWidth: true }
                    ActionButton { text: "Close"; Layout.fillWidth: true }

                    // Speed Control
                    RowLayout {
                        Layout.columnSpan: 2
                        spacing: 5
                        Text { text: "Speed:"; font.pixelSize: 11; color: textSec }
                        TextField {
                            text: "";
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

                GridLayout {
                    anchors.centerIn: parent
                    columns: 7 // Arranges inputs into rows of 7
                    rowSpacing: 8
                    columnSpacing: 10

                    // Reusable MiniInput Component
                    component MiniInput: Row {
                        property string label: ""
                        property string val: ""
                        spacing: 2
                        Rectangle {
                            width: 28; height: 24
                            color: "#2F2F40"
                            radius: 2
                            border.color: borderColor
                            Text {
                                text: parent.label !== undefined ? parent.label : ""
                                anchors.centerIn: parent
                                font.pixelSize: 10
                                font.bold: true
                                color: "#FFFFFF" // White text for label
                            }
                        }
                        TextField {
                            text: parent.val !== undefined ? parent.val : ""
                            width: 48
                            height: 24
                            color: textMain
                            background: Rectangle { color: inputBg; border.color: borderColor; radius: 2 }
                            font.pixelSize: 11
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

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

                            // === INDEX 0: PROGRAM VIEW (The Two Tables) ===
                            RowLayout {
                                spacing: 10

                                // Helper Component for Table Cells
                                component TableCell: Rectangle {
                                    property string textVal: ""
                                    property int cellWidth: 80
                                    property bool isHeader: false
                                    property bool isSelected: false // To mimic the blue selection in screenshot

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
                                    Layout.preferredWidth: 450 // Adjust based on preference
                                    clip: true

                                    ScrollView {
                                        anchors.fill: parent
                                        clip: true
                                        ScrollBar.horizontal.policy: ScrollBar.AlwaysOn
                                        ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                                        Column {
                                            // 1. Header Row
                                            Row {
                                                TableCell { textVal: "Name"; cellWidth: 80; isHeader: true }
                                                TableCell { textVal: "Value"; cellWidth: 140; isHeader: true }
                                                TableCell { textVal: "Deg"; cellWidth: 60; isHeader: true }
                                                TableCell { textVal: "Tools"; cellWidth: 60; isHeader: true }
                                                TableCell { textVal: "Frames"; cellWidth: 60; isHeader: true }
                                            }

                                            // 2. Data Rows (15 Dummy Rows)
                                            Repeater {
                                                model: 15
                                                Row {
                                                    // Mimic the "Selected" cell logic on row 1 like the screenshot
                                                    property bool isRow1: index === 0

                                                    TableCell { textVal: "usr_fr_" + index; cellWidth: 80 }
                                                    TableCell { textVal: "x=749.99..."; cellWidth: 140; isSelected: isRow1 } // Blue Highlight
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
                                            // 1. Header Row
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

                                            // 2. Data Rows (15 Dummy Rows)
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

                            // === INDEX 1: ERROR POS VIEW (Placeholder) ===
                            Rectangle {
                                color: "transparent"
                                Text {
                                    text: "Error Position View (Under Construction)"
                                    color: textSec
                                    anchors.centerIn: parent
                                    font.pixelSize: 16
                                }
                            }

                            // === INDEX 2+: Placeholders for other tabs ===
                            Repeater {
                                model: 5 // Remaining tabs
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
            // Footer Input
            PanelCard {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                color: "#181825"

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
