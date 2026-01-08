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
            // A. TOP ROW (Height: 30%) -> Split Width 20% / 80%
            // --------------------------------------------------------
            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: parent.height * 0.4 // 30% of total height
                spacing: 15

                // --- SECTION 1: TOP-LEFT (Width: 20%) ---
                Item {
                    Layout.preferredWidth: rightPanel.width * 0.2
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    clip: true

                    // VIEW A: SPEED SETTINGS
                    ColumnLayout {
                        visible: currentTab === "Speed"
                        anchors.fill: parent
                        spacing: 5

                        Text { text: "SETTINGS"; color: "white"; font.bold: true; font.pixelSize: 14 }

                        GridLayout {
                            columns: 1
                            rowSpacing: 2
                            Layout.fillWidth: true

                            LabelBox { text: "Distance"; Layout.preferredHeight: 20 }
                            CustomComboBox { model: ["0.1", "1.0", "10", "100"]; Layout.fillWidth: true; Layout.preferredHeight: 25 }

                            LabelBox { text: "Linear Spd"; Layout.preferredHeight: 20 }
                            CustomTextField { text: "100"; Layout.fillWidth: true; Layout.preferredHeight: 25 }

                            LabelBox { text: "Frame"; Layout.preferredHeight: 20 }
                            CustomComboBox { model: ["User", "World"]; Layout.fillWidth: true; Layout.preferredHeight: 25 }
                        }
                        Item { Layout.fillHeight: true }
                    }

                    // VIEW B: JOG BUTTONS
                    ColumnLayout {
                        visible: currentTab === "Jog" || currentTab === "Move"
                        anchors.fill: parent
                        spacing: 5

                        // *** REMOVED INLINE SUB-TABS TO PREVENT OVERLAP ***
                        // Only the grid remains below

                        // Cartesian Grid
                        GridLayout {
                            visible: jogTab === "Cartesian"
                            columns: 2; rowSpacing: 2; columnSpacing: 2
                            Layout.fillWidth: true

                            Text { text: "NEG"; color: "#EF5350"; font.bold: true; font.pixelSize: 9; Layout.alignment: Qt.AlignHCenter }
                            Text { text: "POS"; color: "#00E676"; font.bold: true; font.pixelSize: 9; Layout.alignment: Qt.AlignHCenter }

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
                            columns: 2; rowSpacing: 2; columnSpacing: 2
                            Layout.fillWidth: true

                            Text { text: "NEG"; color: "#EF5350"; font.bold: true; font.pixelSize: 9; Layout.alignment: Qt.AlignHCenter }
                            Text { text: "POS"; color: "#00E676"; font.bold: true; font.pixelSize: 9; Layout.alignment: Qt.AlignHCenter }

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
                                component FooterCell: Rectangle {
                                    property string txt: ""; property int w: 80; property bool header: false
                                    width: w; height: 26; color: header ? "#32324A" : "transparent"; border.color: borderColor
                                    Text { text: parent.txt; anchors.centerIn: parent; color: parent.header ? textSec : textMain; font.bold: parent.header; font.pixelSize: 11 }
                                }
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
            // B. BOTTOM ROW (Height: 70%) -> Combined Sections 3 & 4
            // --------------------------------------------------------
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: parent.height * 0.6
                color: "#151520"
                border.color: "#3f3f5f"
                border.width: 1
                radius: 8

                Text {
                    text: "COMBINED BOTTOM SECTION (70% HEIGHT)"
                    color: "#555"
                    anchors.centerIn: parent
                    font.bold: true
                    font.pixelSize: 20
                }
            }
        }
    }

    // --- HELPER COMPONENTS ---
    component PanelCard: Rectangle { color: panelBg; radius: 8; border.color: borderColor; border.width: 1 }

    component JogBtn: Button {
        Layout.fillWidth: true
        Layout.preferredHeight: 50
        background: Rectangle { color: parent.pressed ? "#0091EA" : "#eceff1"; radius: 4 }
        contentItem: Text { text: parent.text; color: parent.pressed ? "white" : "black"; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter; font.bold: true; font.pixelSize: 20 }
    }

    component LabelBox: Rectangle {
        Layout.fillWidth: true; Layout.preferredHeight: 25; color: "transparent"
        property alias text: lbl.text
        Text { id: lbl; anchors.verticalCenter: parent.verticalCenter; anchors.left: parent.left; font.bold: true; color: "#ccc"; font.pixelSize: 12 }
    }

    component CustomComboBox: ComboBox {
        Layout.preferredHeight: 30
        model: ["Option"]; background: Rectangle { color: "#2b2b3b"; border.color: "#3f3f5f"; radius: 4 }
        contentItem: Text { text: parent.displayText; color: "white"; verticalAlignment: Text.AlignVCenter; leftPadding: 10; font.pixelSize: 12 }
    }

    component CustomTextField: TextField {
        Layout.preferredHeight: 30
        background: Rectangle { color: "#2b2b3b"; border.color: "#3f3f5f"; radius: 4 }
        color: "white"; verticalAlignment: Text.AlignVCenter; font.pixelSize: 12
    }
}
