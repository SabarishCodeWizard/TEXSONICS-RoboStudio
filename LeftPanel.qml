import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick3D
import QtQuick3D.Helpers
import QtQuick.Window
import QtQuick.Shapes

ColumnLayout {
    id: mainLayout
    spacing: 12

    // --- STATE MANAGEMENT ---
    property int viewMode: 0
    property int row1Height: 80
    property int row2Height: 80
    property int row3Height: 80

    // Property bound from Main.qml
    property string currentCoordinateSystem: "Cartesian"

    // --- 1. Header Card ---
    PanelCard {
        id: headerCard
        Layout.fillWidth: true
        height: 60
        visible: mainLayout.viewMode !== 2

        RowLayout {
            anchors.fill: parent
            anchors.margins: 15
            spacing: 10

            Text {
                id: mainLogo
                text: "TEXSONICS"
                color: "#0091EA"
                font.bold: true
                font.letterSpacing: 2
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width * 0.4
                fontSizeMode: Text.VerticalFit
                minimumPointSize: 12
                font.pointSize: 28
                verticalAlignment: Text.AlignVCenter
            }

            Item { Layout.fillWidth: true }

            Text {
                id: versionText
                text: "ROBOT CONTROLLER V1.0"
                color: "#FFFFFF"
                opacity: 0.8
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width * 0.3
                fontSizeMode: Text.HorizontalFit
                minimumPointSize: 8
                font.pointSize: 15
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

    // --- 2. 3D Viewport Card ---
    PanelCard {
        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true
        color: "#ffffff"

        // --- REUSABLE HUD VALUE COMPONENT ---
        component HudValue: ColumnLayout {
            spacing: 2
            property alias label: lbl.text
            property alias value: val.text
            property color valColor: "white"
            property int labelSize: 10
            property int valueSize: 16

            Text {
                id: lbl
                color: "#aaa"
                font.pixelSize: labelSize
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
            }
            Text {
                id: val
                color: parent.valColor
                font.pixelSize: valueSize
                font.family: "Monospace"
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
            }
        }

        View3D {
            id: view3d
            anchors.fill: parent
            environment: SceneEnvironment {
                clearColor: "#eef4fb"
                backgroundMode: SceneEnvironment.Color
                antialiasingMode: SceneEnvironment.MSAA
                antialiasingQuality: SceneEnvironment.High
            }
            Node {
                id: camOrigin
                position: Qt.vector3d(0, 200, 0)
                PerspectiveCamera {
                    id: mainCamera
                    position: Qt.vector3d(0, 0, 2000)
                    eulerRotation.x: -15
                    clipNear: 10
                    clipFar: 10000
                    onZChanged: {
                        if (z < 200) z = 200;
                        if (z > 5000) z = 5000;
                    }
                }
            }
            OrbitCameraController {
                id: orbitController
                anchors.fill: parent
                origin: camOrigin
                camera: mainCamera
                xSpeed: 0.5
                ySpeed: 0.5
            }
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.MiddleButton
                property point lastPos: Qt.point(0, 0)
                onPressed: (mouse) => lastPos = Qt.point(mouse.x, mouse.y)
                onPositionChanged: (mouse) => {
                    if (pressedButtons & Qt.MiddleButton) {
                        var deltaX = mouse.x - lastPos.x
                        var deltaY = mouse.y - lastPos.y
                        var factor = mainCamera.z / 1000.0
                        var moveVec = mainCamera.mapDirectionToScene(Qt.vector3d(-deltaX * factor, deltaY * factor, 0))
                        camOrigin.position = camOrigin.position.plus(moveVec)
                        lastPos = Qt.point(mouse.x, mouse.y)
                    }
                }
            }
            DirectionalLight { eulerRotation.x: -30; eulerRotation.y: -30; castsShadow: true; brightness: 1.5; shadowFactor: 50 }
            PointLight { position: Qt.vector3d(0, 500, 0); brightness: 0.5 }
            Node {
                GridEnvironment { id: gridEnv }
                // RobotArm { id: robotArm; position: Qt.vector3d(0, 0, 0) }
            }
        }

        // --- RIGHT SIDE VERTICAL HUD (JOINTS) ---
        Rectangle {
            id: rightSideHud
            visible: currentCoordinateSystem === "Joints"

            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 80

            color: "#CC1E1E2E" // Semi-transparent dark
            border.color: "#3f3f5f"
            border.width: 0 // We usually just want a left border

            // Left Border Line
            Rectangle {
                width: 1; height: parent.height;
                anchors.left: parent.left;
                color: "#3f3f5f"
            }

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 25

                Text {
                    text: "JOINTS"
                    color: "#00E676"
                    font.bold: true
                    font.pixelSize: 12
                    font.letterSpacing: 1
                    Layout.alignment: Qt.AlignHCenter
                    Layout.bottomMargin: 10
                }

                HudValue { label: "J1"; value: "2.37°"; valColor: "#00E676"; valueSize: 14 }
                HudValue { label: "J2"; value: "8.80°"; valColor: "#00E676"; valueSize: 14 }
                HudValue { label: "J3"; value: "53.3°"; valColor: "#00E676"; valueSize: 14 }
                HudValue { label: "J4"; value: "-5.8°"; valColor: "#00E676"; valueSize: 14 }
                HudValue { label: "J5"; value: "7.93°"; valColor: "#00E676"; valueSize: 14 }
                HudValue { label: "J6"; value: "8.06°"; valColor: "#00E676"; valueSize: 14 }
            }
        }

        // --- BOTTOM HUD (CARTESIAN ONLY) ---
        Rectangle {
            id: bottomHud
            visible: currentCoordinateSystem === "Cartesian"

            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: 60

            color: "#CC1E1E2E"
            border.width: 0 // Just top border usually

            // Top Border Line
            Rectangle {
                height: 1; width: parent.width;
                anchors.top: parent.top;
                color: "#3f3f5f"
            }

            RowLayout {
                anchors.centerIn: parent
                spacing: 40


                Text {
                    text: "Cartesian"
                    color: "#00E676"
                    font.bold: true
                    font.pixelSize: 12
                    font.letterSpacing: 1
                    Layout.alignment: Qt.AlignHCenter
                    Layout.bottomMargin: 10
                }

                HudValue { label: "X (mm)"; value: "7.5592"; valColor: "#40C4FF" }
                HudValue { label: "Y (mm)"; value: "-0.0101"; valColor: "#40C4FF" }
                HudValue { label: "Z (mm)"; value: "4.3751"; valColor: "#40C4FF" }

                Rectangle { width: 1; height: 30; color: "#555" } // Separator

                HudValue { label: "Rx (°)"; value: "0.00" }
                HudValue { label: "Ry (°)"; value: "0.00" }
                HudValue { label: "Rz (°)"; value: "0.00" }
            }
        }

        // --- HAMBURGER MENU ---
        Rectangle {
            anchors.left: parent.left; anchors.top: parent.top
            anchors.margins: 10
            color: "#AA1E1E2E"; radius: 4
            width: 140; height: 32; border.color: "#3f3f5f"

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 8; anchors.rightMargin: 8
                spacing: 10

                Item {
                    Layout.preferredWidth: 20; Layout.preferredHeight: 20
                    Shape {
                        anchors.centerIn: parent
                        width: 16; height: 12
                        ShapePath {
                            strokeWidth: 2; strokeColor: ratioMenuPopup.opened ? "#40C4FF" : "#FFFFFF"
                            capStyle: ShapePath.RoundCap
                            startX: 0; startY: 1; PathLine { x: 16; y: 1 }
                            PathMove { x: 0; y: 6 } PathLine { x: 16; y: 6 }
                            PathMove { x: 0; y: 11 } PathLine { x: 16; y: 11 }
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: ratioMenuPopup.open()
                    }
                    Popup {
                        id: ratioMenuPopup
                        y: parent.height + 10; x: 0
                        width: 180; height: 140; padding: 1
                        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
                        background: Rectangle { color: "#27273A"; border.color: "#40C4FF"; border.width: 1; radius: 4 }
                        ColumnLayout {
                            anchors.fill: parent; spacing: 0
                            component RadioMenuItem: Rectangle {
                                Layout.fillWidth: true; Layout.fillHeight: true
                                color: itemMa.containsMouse ? "#32324A" : "transparent"
                                property string label: ""; property bool isActive: false; property var clickAction
                                RowLayout {
                                    anchors.fill: parent; anchors.leftMargin: 15; spacing: 10
                                    Rectangle { width: 12; height: 12; radius: 6; border.color: isActive ? "#00E676" : "#B0BEC5"; border.width: 2; color: "transparent"; Rectangle { anchors.centerIn: parent; width: 6; height: 6; radius: 3; color: "#00E676"; visible: isActive } }
                                    Text { text: label; color: isActive ? "#FFFFFF" : "#B0BEC5"; font.pixelSize: 13; font.bold: isActive }
                                }
                                MouseArea { id: itemMa; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: clickAction() }
                            }
                            Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 30; color: "#1E1E2E"; Text { anchors.centerIn: parent; text: "SCREEN RATIO"; color: "#40C4FF"; font.pixelSize: 10; font.bold: true; font.letterSpacing: 1 } }
                            RadioMenuItem { label: "Standard View"; isActive: mainLayout.viewMode === 0; clickAction: () => { mainLayout.viewMode = 0; ratioMenuPopup.close() } }
                            RadioMenuItem { label: "Expand Vertical"; isActive: mainLayout.viewMode === 1; clickAction: () => { mainLayout.viewMode = 1; ratioMenuPopup.close() } }
                            RadioMenuItem { label: "Full Screen"; isActive: mainLayout.viewMode === 2; clickAction: () => { mainLayout.viewMode = 2; ratioMenuPopup.close() } }
                        }
                    }
                }
                Rectangle { Layout.preferredWidth: 1; Layout.fillHeight: true; Layout.topMargin: 4; Layout.bottomMargin: 4; color: "#3f3f5f" }
                RowLayout {
                    spacing: 4
                    Text { text: "●"; color: "#00E676"; font.pixelSize: 10 }
                    Text { text: "3D View"; font.pixelSize: 11; font.bold: true; color: "#00E676" }
                }
            }
        }

        // Reset Camera Overlay
        Rectangle {
            anchors.right: parent.right; anchors.top: parent.top
            anchors.margins: 10
            color: "#AA1E1E2E"; radius: 4
            width: 30; height: 24; border.color: "#3f3f5f"
            Text { text: "⟲"; anchors.centerIn: parent; color: "#ffffff"; font.pixelSize: 14 }
            MouseArea {
                anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                onClicked: {
                    camOrigin.position = Qt.vector3d(0, 200, 0)
                    camOrigin.eulerRotation = Qt.vector3d(0, 0, 0)
                    mainCamera.position = Qt.vector3d(0, 0, 2000)
                    mainCamera.eulerRotation = Qt.vector3d(-15, 0, 0)
                }
            }
        }
    }

    // --- 3. Bottom Operation Controls ---
    PanelCard {
        id: bottomControls
        Layout.fillWidth: true
        Layout.preferredHeight: 340
        color: "#1e1e2e"
        visible: mainLayout.viewMode === 0
        IconPaths { id: icons }
        GridLayout {
            anchors.fill: parent; anchors.margins: 15; columns: 6; rowSpacing: 12; columnSpacing: 12; uniformCellWidths: true
            VectorButton { id: onOffBtn; Layout.fillWidth: true; Layout.preferredHeight: row1Height; property bool isOn: false; label: isOn ? "On" : "Off"; pathData: isOn ? icons.toggleOn : icons.toggleOff; baseColor: isOn ? "#76ff03" : "#546E7A"; onClicked: isOn = !isOn }
            VectorButton { Layout.fillWidth: true; Layout.preferredHeight: row1Height; pathData: icons.home; baseColor: "#0091EA"; label: "Home" }
            VectorButton { id: runBtn; Layout.fillWidth: true; Layout.preferredHeight: row1Height; property bool isRunning: false; label: isRunning ? "Pause" : "Run"; pathData: isRunning ? icons.pause : icons.play; baseColor: isRunning ? "#FF9800" : "#00b341"; onClicked: isRunning = !isRunning }
            VectorButton { id: startStopBtn; Layout.fillWidth: true; Layout.preferredHeight: row1Height; property bool isStarted: false; label: isStarted ? "Stop" : "Start"; pathData: icons.power; baseColor: isStarted ? "#D50000" : "#455A64"; onClicked: isStarted = !isStarted }
            VectorButton { Layout.fillWidth: true; Layout.preferredHeight: row1Height; pathData: icons.exit; baseColor: "#FF3D00"; label: "Exit" }
            VectorButton {
                id: modeBtn; Layout.fillWidth: true; Layout.preferredHeight: row1Height; property string currentMode: "Sim"; label: "M: " + currentMode; pathData: currentMode === "Sim" ? icons.simEye : icons.robot; baseColor: currentMode === "Sim" ? "#2E7D32" : "#607D8B"; onClicked: selectionPopup.open()
                Popup {
                    id: selectionPopup
                    y: parent.height + 5; x: (parent.width - width) / 2; width: parent.width * 2; padding: 10
                    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
                    background: Rectangle { color: "#1e1e2e"; border.color: "#3f3f5f"; radius: 8 }
                    contentItem: RowLayout {
                        spacing: 10
                        VectorButton { label: "Sim"; pathData: icons.simEye; baseColor: "#2E7D32"; Layout.preferredHeight: 80; Layout.fillHeight: false; onClicked: { modeBtn.currentMode = "Sim"; selectionPopup.close(); } }
                        VectorButton { label: "Real"; pathData: icons.robot; baseColor: "#607D8B"; Layout.preferredHeight: 80; Layout.fillHeight: false; onClicked: { modeBtn.currentMode = "Real"; selectionPopup.close(); } }
                    }
                }
            }
            VectorButton {
                id: filesBtn; Layout.fillWidth: true; Layout.preferredHeight: row2Height; property int activeIndex: 0; property string lastAction: "None"; property bool showingActions: false; property string selectedCategory: ""; label: "Files"; pathData: icons.files; baseColor: "#673AB7"; onClicked: { showingActions = false; filesPopup.open(); }
                Popup {
                    id: filesPopup
                    y: -height - 10; width: 220; height: 280; padding: 10
                    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
                    background: Rectangle { color: "#1e1e2e"; border.color: "#3f3f5f"; radius: 8 }
                    contentItem: Item {
                        ColumnLayout {
                            anchors.fill: parent; visible: !filesBtn.showingActions; spacing: 5
                            Text { Layout.alignment: Qt.AlignHCenter; text: "SELECT TYPE"; color: "#B0BEC5"; font.bold: true; font.pixelSize: 12 }
                            ScrollView {
                                Layout.fillWidth: true; Layout.fillHeight: true; clip: true; contentWidth: availableWidth
                                ColumnLayout {
                                    anchors.fill: parent; width: parent.width; spacing: 8
                                    VectorButton { label: "PR Files"; baseColor: "#0091EA"; Layout.preferredHeight: 50; Layout.fillWidth: true; Layout.fillHeight: false; onClicked: { filesBtn.selectedCategory = "PR"; filesBtn.activeIndex = 0; filesBtn.showingActions = true } }
                                    VectorButton { label: "TR Files"; baseColor: "#673AB7"; Layout.preferredHeight: 50; Layout.fillWidth: true; Layout.fillHeight: false; onClicked: { filesBtn.selectedCategory = "TR"; filesBtn.activeIndex = 1; filesBtn.showingActions = true } }
                                    VectorButton { label: "TP Files"; baseColor: "#00796B"; Layout.preferredHeight: 50; Layout.fillWidth: true; Layout.fillHeight: false; onClicked: { filesBtn.selectedCategory = "TP"; filesBtn.activeIndex = 2; filesBtn.showingActions = true } }
                                    Item { Layout.fillHeight: true }
                                }
                            }
                        }
                        ColumnLayout {
                            anchors.fill: parent; visible: filesBtn.showingActions; spacing: 10
                            RowLayout {
                                Text { text: filesBtn.selectedCategory + " ACTIONS"; color: "white"; font.bold: true; font.pixelSize: 12 }
                                Item { Layout.fillWidth: true }
                                Button { text: "Back"; flat: true; onClicked: filesBtn.showingActions = false; contentItem: Text { text: parent.text; color: "white"; font.bold: true; font.pixelSize: 16 } background: null }
                            }
                            VectorButton { label: "New " + filesBtn.selectedCategory; baseColor: "#0091EA"; Layout.fillWidth: true; Layout.preferredHeight: 50; Layout.fillHeight: false; onClicked: { filesBtn.lastAction = "New Created"; filesPopup.close(); } }
                            VectorButton { label: "Open " + filesBtn.selectedCategory; baseColor: "#0091EA"; Layout.fillWidth: true; Layout.preferredHeight: 50; Layout.fillHeight: false; onClicked: { filesBtn.lastAction = "Opened"; filesPopup.close(); } }
                            Item { Layout.fillHeight: true }
                        }
                    }
                }
            }
            TextField { id: prField; Layout.fillWidth: true; Layout.preferredHeight: row2Height; placeholderText: "PR: None"; text: filesBtn.activeIndex === 0 ? filesBtn.lastAction : ""; horizontalAlignment: Text.AlignLeft; leftPadding: 10; font.pixelSize: 14; color: "white"; readOnly: true; background: Rectangle { color: "#11111b"; border.color: filesBtn.activeIndex === 0 ? "#0091EA" : "#3f3f5f"; border.width: filesBtn.activeIndex === 0 ? 2 : 1; radius: 6 } }
            TextField { id: trField; Layout.fillWidth: true; Layout.preferredHeight: row2Height; placeholderText: "TR: None"; text: filesBtn.activeIndex === 1 ? filesBtn.lastAction : ""; horizontalAlignment: Text.AlignLeft; leftPadding: 10; font.pixelSize: 14; color: "white"; readOnly: true; background: Rectangle { color: "#11111b"; border.color: filesBtn.activeIndex === 1 ? "#673AB7" : "#3f3f5f"; border.width: filesBtn.activeIndex === 1 ? 2 : 1; radius: 6 } }
            TextField { id: tpField; Layout.fillWidth: true; Layout.preferredHeight: row2Height; placeholderText: "TP: None"; text: filesBtn.activeIndex === 2 ? filesBtn.lastAction : ""; horizontalAlignment: Text.AlignLeft; leftPadding: 10; font.pixelSize: 14; color: "white"; readOnly: true; background: Rectangle { color: "#11111b"; border.color: filesBtn.activeIndex === 2 ? "#00796B" : "#3f3f5f"; border.width: filesBtn.activeIndex === 2 ? 2 : 1; radius: 6 } }
            VectorButton {
                Layout.fillWidth: true; Layout.preferredHeight: row3Height; label: "Add Tool"; pathData: "M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z"; baseColor: "#00E676"
                onClicked: { if(toolNameInput.text !== "") { console.log("Added Tool: " + toolNameInput.text); toolNameInput.text = ""; } }
            }
            TextField { id: toolNameInput; Layout.fillWidth: true; Layout.preferredHeight: row3Height; placeholderText: "Tool Name..."; horizontalAlignment: Text.AlignLeft; leftPadding: 10; font.pixelSize: 14; color: "white"; background: Rectangle { color: "#11111b"; border.color: "#3f3f5f"; radius: 6 } }
            TextField { id: errorDisplayField; Layout.fillWidth: true; Layout.preferredHeight: row3Height; Layout.columnSpan: 2; text: "No Active Errors"; readOnly: true; horizontalAlignment: Text.AlignLeft; leftPadding: 10; font.pixelSize: 14; font.bold: true; color: "#FF5252"; background: Rectangle { color: "#2b1313"; border.color: "#B71C1C"; radius: 6 } }
            VectorButton { id: errClearBtn; Layout.fillWidth: true; Layout.preferredHeight: row2Height; label: "Error_C"; pathData: "M16,9v10H8V9h8m-1.5-6h-5l-1,1H5v2h14V4h-3.5l-1-1z M18,7H6v12c0,1.1,0.9,2,2,2h8c1.1,0,2-0.9,2-2V7z"; baseColor: "#EF5350"; onClicked: console.log("Error Cleared") }
            VectorButton { id: markClearBtn; Layout.fillWidth: true; Layout.preferredHeight: row2Height; label: "Mark_C"; pathData: "M19,6.41L17.59,5,12,10.59,6.41,5,5,6.41,10.59,12,5,17.59,6.41,19,12,13.41,17.59,19,19,17.59,13.41,12z"; baseColor: "#FFA726"; onClicked: console.log("Mark Cleared") }
            VectorButton { Layout.fillWidth: true; Layout.preferredHeight: row3Height; label: "Reset"; pathData: "M17.65 6.35C16.2 4.9 14.21 4 12 4c-4.42 0-7.99 3.58-7.99 8s3.57 8 7.99 8c3.73 0 6.84-2.55 7.73-6h-2.08c-.82 2.33-3.04 4-5.65 4-3.31 0-6-2.69-6-6s2.69-6 6-6c1.66 0 3.14.69 4.22 1.78L13 11h7V4l-2.35 2.35z"; baseColor: "#FDD835"; onClicked: console.log("System Reset") }
            TextField { id: speedInput; Layout.fillWidth: true; Layout.preferredHeight: row3Height; placeholderText: "Speed %"; validator: IntValidator { bottom: 0; top: 100 } horizontalAlignment: Text.AlignCenter; font.pixelSize: 16; color: "#00E676"; background: Rectangle { color: "#11111b"; border.color: "#3f3f5f"; radius: 6 } onEditingFinished: console.log("Speed set to: " + text + "%") }
        }
    }
}
