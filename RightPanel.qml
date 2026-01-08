import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: rightPanel
    color: "#1e1e2e" // Dark theme background
    radius: 8

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
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                property color baseColor: "#546E7A"
                property color txtColor: "white"
                property bool isActive: false

                background: Rectangle {
                    color: parent.isActive ? Qt.lighter(parent.baseColor, 1.3) : parent.baseColor
                    radius: 6
                    border.width: parent.isActive ? 2 : 0
                    border.color: "white"
                }
                contentItem: Text {
                    text: parent.text
                    color: parent.txtColor
                    font.bold: true
                    font.capitalization: Font.AllUppercase
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 10
                    font.pixelSize: 18
                    leftPadding: 4; rightPadding: 4
                }
                onClicked: rightPanel.currentTab = text
            }

            StatusButton { text: "Speed"; baseColor: "#546E7A"; isActive: currentTab === "Speed" }

            // --- JOG BUTTON WITH POPUP ---
            StatusButton {
                text: "Jog"
                baseColor: "#0288D1"
                isActive: currentTab === "Jog"
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
                            text: "Cartesian"; Layout.fillWidth: true; Layout.preferredHeight: 40
                            background: Rectangle { color: "#0091EA"; radius: 4 }
                            contentItem: Text { text: parent.text; color: "white"; font.bold: true; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                            onClicked: { currentTab = "Jog"; jogTab = "Cartesian"; jogPopup.close() }
                        }
                        Button {
                            text: "Joints"; Layout.fillWidth: true; Layout.preferredHeight: 40
                            background: Rectangle { color: "#0091EA"; radius: 4 }
                            contentItem: Text { text: parent.text; color: "white"; font.bold: true; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                            onClicked: { currentTab = "Jog"; jogTab = "Joints"; jogPopup.close() }
                        }
                    }
                }
            }

            // --- MOVE BUTTON WITH POPUP ---
            StatusButton {
                text: "Move"
                baseColor: "#2E7D32"
                isActive: currentTab === "Move"
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
                            text: "Cartesian"; Layout.fillWidth: true; Layout.preferredHeight: 40
                            background: Rectangle { color: "#2E7D32"; radius: 4 }
                            contentItem: Text { text: parent.text; color: "white"; font.bold: true; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                            onClicked: { currentTab = "Move"; jogTab = "Cartesian"; movePopup.close() }
                        }
                        Button {
                            text: "Joints"; Layout.fillWidth: true; Layout.preferredHeight: 40
                            background: Rectangle { color: "#2E7D32"; radius: 4 }
                            contentItem: Text { text: parent.text; color: "white"; font.bold: true; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                            onClicked: { currentTab = "Move"; jogTab = "Joints"; movePopup.close() }
                        }
                    }
                }
            }

            StatusButton { text: "Auto"; baseColor: "#6A1B9A"; isActive: currentTab === "Auto" }
            StatusButton { text: "Manual"; baseColor: "#4527A0"; isActive: currentTab === "Manual" }
            StatusButton { text: "Remote"; baseColor: "#283593"; isActive: currentTab === "Remote" }
            StatusButton { text: "Emergency"; baseColor: "#C62828"; isActive: currentTab === "Emergency" }
        }

        // ============================================================
        // 2. CONTENT AREA (Split Top 30% / Bottom 70%)
        // ============================================================
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 15

            // --------------------------------------------------------
            // A. TOP ROW (Height: 40%) -> Split Width 20% / 80%
            // --------------------------------------------------------
            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: rightPanel.height * 0.4 // Fixed 30% ratio
                spacing: 15

                // --- SECTION 1: TOP-LEFT (Width: 20%) ---
                PanelCard {
                    Layout.preferredWidth: rightPanel.width * 0.2
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    clip: true
                    color: "transparent"
                    border.width: 0

                    // *** VIEW A: SPEED SETTINGS (HORIZONTAL LAYOUT) ***
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
                            // Force Vertical Scroll only
                            contentWidth: availableWidth
                            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                            ScrollBar.vertical.policy: ScrollBar.AsNeeded

                            ColumnLayout {
                                width: parent.width
                                spacing: 10

                                // 1. Distance
                                RowLayout {
                                    Layout.fillWidth: true
                                    spacing: 10
                                    Text { text: "MM"; color: textSpeed; font.bold: true; font.pixelSize: 18; Layout.preferredWidth: 60; Layout.alignment: Qt.AlignVCenter }
                                    CustomComboBox { model: ["0.1", "1.0", "10", "100"]; Layout.fillWidth: true }
                                }

                                // 2. Linear Speed
                                RowLayout {
                                    Layout.fillWidth: true
                                    spacing: 10
                                    Text { text: "MM/S"; color: textSpeed; font.bold: true; font.pixelSize: 18; Layout.preferredWidth: 60; Layout.alignment: Qt.AlignVCenter }
                                    CustomTextField { text: "100"; Layout.fillWidth: true }
                                }

                                // 3. Angle Unit
                                RowLayout {
                                    Layout.fillWidth: true
                                    spacing: 10
                                    Text { text: "Deg"; color: textSpeed; font.bold: true; font.pixelSize: 18; Layout.preferredWidth: 60; Layout.alignment: Qt.AlignVCenter }
                                    CustomComboBox { model: ["Deg", "Rad"]; Layout.fillWidth: true }
                                }

                                // 4. Angular Speed
                                RowLayout {
                                    Layout.fillWidth: true
                                    spacing: 10
                                    Text { text: "Deg/S"; color: textSpeed; font.bold: true; font.pixelSize: 18; Layout.preferredWidth: 60; Layout.alignment: Qt.AlignVCenter }
                                    CustomTextField { text: "10"; Layout.fillWidth: true }
                                }

                                // 5. Coord Frame
                                RowLayout {
                                    Layout.fillWidth: true
                                    spacing: 10
                                    Text { text: "Frame"; color: textSpeed; font.bold: true; font.pixelSize: 18; Layout.preferredWidth: 60; Layout.alignment: Qt.AlignVCenter }
                                    CustomComboBox { model: ["User", "World", "Tool"]; Layout.fillWidth: true }
                                }

                                Item { Layout.fillHeight: true } // Pusher
                            }
                        }
                    }

                    // VIEW B: JOG BUTTONS
                    ColumnLayout {
                        visible: currentTab === "Jog" || currentTab === "Move"
                        anchors.fill: parent
                        spacing: 5

                        // Cartesian Grid
                        GridLayout {
                            visible: jogTab === "Cartesian"
                            columns: 2; rowSpacing: 4; columnSpacing: 4
                            Layout.fillWidth: true
                            Layout.fillHeight: true

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
                            Layout.fillWidth: true
                            Layout.fillHeight: true

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
                                    model: ["Inst", "Debug", "Jog Deg"]
                                    Rectangle {
                                        Layout.preferredWidth: 90
                                        Layout.fillHeight: true
                                        color: footerStack.currentIndex === index ? panelBg : "transparent"
                                        border.color: borderColor
                                        border.width: 1
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

                            // --- TAB 1: INST ---
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
                                        }
                                        Repeater {
                                            model: 8
                                            Row {
                                                FooterCell { txt: (index + 1).toString(); w: 50 }
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
                            // --- TAB 2 & 3 ---
                            Rectangle { color: "transparent"; Text { text: "Debug View"; color: textSec; anchors.centerIn: parent } }
                            Rectangle { color: "transparent"; Text { text: "Jog Degrees View"; color: textSec; anchors.centerIn: parent } }
                        }
                    }
                }
            }

            // --------------------------------------------------------
            // B. BOTTOM ROW (Height: 60%) -> Panel Space Panel Space
            // --------------------------------------------------------
            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: rightPanel.height * 0.6 // Fixed 70% ratio
                spacing: 15

                // --- 1. PANELCARD (30% of this container) ---
                PanelCard {
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height * 0.45
                    clip: true

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 0

                        // 1. Footer Tab Bar (Middle)
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 30
                            color: "#1e1e2d"

                            RowLayout {
                                anchors.fill: parent
                                spacing: 1
                                Repeater {
                                    model: ["Inst", "Debug", "Jog Deg"]
                                    Rectangle {
                                        Layout.preferredWidth: 90
                                        Layout.fillHeight: true
                                        color: middleStack.currentIndex === index ? panelBg : "transparent"
                                        border.color: borderColor
                                        border.width: 1
                                        Rectangle { visible: middleStack.currentIndex === index; height: 2; width: parent.width; anchors.top: parent.top; color: primaryColor }
                                        Text { text: modelData; anchors.centerIn: parent; color: middleStack.currentIndex === index ? primaryColor : textSec; font.bold: middleStack.currentIndex === index; font.pixelSize: 12 }
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
                                        }
                                        Repeater {
                                            model: 5
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

                // --- 2. SPACE (Spacer) ---
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true // Shares remaining space
                }

                // --- 3. PANELCARD (20% of this container) ---
                PanelCard {
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height * 0.35
                    clip: true

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 0

                        // 1. Footer Tab Bar (Bottom)
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 30
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
                                        Text { text: modelData; anchors.centerIn: parent; color: bottomStack.currentIndex === index ? primaryColor : textSec; font.bold: bottomStack.currentIndex === index; font.pixelSize: 12 }
                                        MouseArea { anchors.fill: parent; onClicked: bottomStack.currentIndex = index }
                                    }
                                }
                                Item { Layout.fillWidth: true }
                            }
                        }

                        // 2. Content Area (Bottom)
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

                // --- 4. SPACE (Spacer) ---
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true // Shares remaining space
                }
            }
        }
    }

    // --- HELPER COMPONENTS ---
    component PanelCard: Rectangle { color: panelBg; radius: 8; border.color: borderColor; border.width: 1 }

    // Table Cell Component (Moved here to avoid scope issues)
    component FooterCell: Rectangle {
        property string txt: ""
        property int w: 200
        property bool header: false
        width: w; height: 80
        color: header ? "#32324A" : "transparent"
        border.color: borderColor
        Text {
            text: parent.txt
            anchors.centerIn: parent
            color: parent.header ? textSec : textMain
            font.bold: parent.header
            font.pixelSize: 16
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
            // COLOR LOGIC: Red for "-", Green for "+", White otherwise
            color: text.indexOf("-") !== -1 ? "#FF5252" : (text.indexOf("+") !== -1 ? "#3cb371" : "#FFFFFF")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            fontSizeMode: Text.Fit
            minimumPixelSize: 10
            font.pixelSize: 28
            rightPadding: 4
            leftPadding: 4
        }
    }

    // *** STYLIZED COMBO BOX ***
    component CustomComboBox: ComboBox {
        Layout.preferredHeight: 30
        model: ["Option"]

        delegate: ItemDelegate {
            width: parent.width
            contentItem: Text {
                text: modelData
                color: "black"
                font.pixelSize: 18
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
            }
            background: Rectangle { color: highlighted ? "#40C4FF" : "#ffffff" }
        }

        background: Rectangle {
            color: "#ffffff" // Light input bg
            border.color: "#3B3B50"
            radius: 4
        }
        contentItem: Text {
            text: parent.displayText
            color: "black"
            verticalAlignment: Text.AlignVCenter
            leftPadding: 10
            font.pixelSize: 18
        }
    }

    // *** STYLIZED TEXT FIELD ***
    component CustomTextField: TextField {
        Layout.preferredHeight: 30
        background: Rectangle {
            color: "#ffffff" // Light input bg
            border.color: "#3B3B50"
            radius: 4
        }
        color: "black"
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 18
        leftPadding: 10
    }
}
