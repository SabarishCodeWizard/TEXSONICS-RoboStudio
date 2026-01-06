import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick3D
import QtQuick3D.Helpers
import QtQuick.Window

ColumnLayout {
    spacing: 12

    // --- 1. Header Card ---
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

    // --- 2. 3D Viewport Card (UPDATED) ---
    PanelCard {
        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true
        color: "#ffffff"

        // THE 3D SCENE
        View3D {
            id: view3d
            anchors.fill: parent

            // 1. Environment Setup
            environment: SceneEnvironment {
                clearColor: "#eef4fb"
                backgroundMode: SceneEnvironment.Color
                antialiasingMode: SceneEnvironment.MSAA
                antialiasingQuality: SceneEnvironment.High
            }

            // 2. CAMERA RIG (Center & Orbit Logic)
            // 'camOrigin' acts as the pivot point. We move THIS node to pan.
            Node {
                id: camOrigin
                position: Qt.vector3d(0, 200, 0) // Look at the robot's center (approx height)

                PerspectiveCamera {
                    id: mainCamera
                    // Z Position = Initial Zoom level
                    position: Qt.vector3d(0, 0, 2000)
                    eulerRotation.x: -15
                    clipNear: 10
                    clipFar: 10000

                    // Zoom Constraints
                    onZChanged: {
                        if (z < 200) z = 200;
                        if (z > 5000) z = 5000;
                    }
                }
            }

            // 3. Controller (Handles Rotation & Zoom)
            OrbitCameraController {
                id: orbitController
                anchors.fill: parent
                origin: camOrigin
                camera: mainCamera
                xSpeed: 0.5
                ySpeed: 0.5
            }

            // 4. Panning Logic (Middle Mouse Button)
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.MiddleButton
                property point lastPos: Qt.point(0, 0)

                onPressed: (mouse) => lastPos = Qt.point(mouse.x, mouse.y)

                onPositionChanged: (mouse) => {
                    if (pressedButtons & Qt.MiddleButton) {
                        var deltaX = mouse.x - lastPos.x
                        var deltaY = mouse.y - lastPos.y

                        // Adjust pan speed based on zoom distance
                        var factor = mainCamera.z / 1000.0

                        // Calculate movement relative to camera view
                        var moveVec = mainCamera.mapDirectionToScene(Qt.vector3d(-deltaX * factor, deltaY * factor, 0))

                        // Move the pivot point (camOrigin)
                        camOrigin.position = camOrigin.position.plus(moveVec)

                        lastPos = Qt.point(mouse.x, mouse.y)
                    }
                }
            }

            // 5. Lighting
            DirectionalLight {
                eulerRotation.x: -30
                eulerRotation.y: -30
                castsShadow: true
                brightness: 1.5
                shadowFactor: 50
            }

            PointLight {
                position: Qt.vector3d(0, 500, 0)
                brightness: 0.5
            }

            // 6. Scene Content
            Node {
                // Ensure GridEnvironment and RobotArm are imported or defined in your project
                GridEnvironment {
                    id: gridEnv
                }

                RobotArm {
                    id: robotArm
                    // Ensure the robot is at 0,0,0
                    position: Qt.vector3d(0, 0, 0)
                }
            }
        }

        // --- OVERLAYS ---

        // View Label
        Rectangle {
            anchors.left: parent.left; anchors.top: parent.top
            anchors.margins: 10
            color: "#AA1E1E2E"
            radius: 4
            width: 100; height: 24
            border.color: borderColor

            RowLayout {
                anchors.centerIn: parent
                spacing: 4
                Text { text: "●"; color: successColor; font.pixelSize: 10 }
                Text { text: "Live View"; font.pixelSize: 11; font.bold: true; color: successColor }
            }
        }

        // Reset View Button
        Rectangle {
            anchors.right: parent.right; anchors.top: parent.top
            anchors.margins: 10
            color: "#AA1E1E2E"
            radius: 4
            width: 30; height: 24
            border.color: borderColor

            Text {
                text: "⟲"
                anchors.centerIn: parent
                color: textMain
                font.pixelSize: 14
            }
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    // RESET LOGIC
                    // 1. Reset Pivot to center
                    camOrigin.position = Qt.vector3d(0, 200, 0)
                    camOrigin.eulerRotation = Qt.vector3d(0, 0, 0)
                    // 2. Reset Camera Zoom
                    mainCamera.position = Qt.vector3d(0, 0, 2000)
                    mainCamera.eulerRotation = Qt.vector3d(-15, 0, 0)
                }
            }
        }
    }

    // --- 3. Bottom Operation Controls ---
    PanelCard {
        Layout.fillWidth: true
        Layout.preferredHeight: 200 // Slightly increased to accommodate all rows comfortably
        color: "#181825" // Matching your dark theme

        GridLayout {
            anchors.fill: parent
            anchors.margins: 10
            columns: 6
            rowSpacing: 8
            columnSpacing: 6

            // --- ROW 1 ---
            StatusButton { text: "Sim"; baseColor: "#2e7d32"; Layout.fillWidth: true } // successColor
            StatusButton { text: "Real"; baseColor: "#546E7A"; Layout.fillWidth: true }
            ActionButton { text: "On_Off"; Layout.fillWidth: true }
            ActionButton { text: "Error clr"; Layout.fillWidth: true }
            ActionButton { text: "Mark Clr"; Layout.fillWidth: true }
            StatusButton { text: "Home"; baseColor: "#2e7d32"; Layout.fillWidth: true }

            // --- ROW 2 ---

            StatusButton { text: "Pause_Run"; baseColor: warningColor; Layout.fillWidth: true }
            StatusButton { text: "start_stop"; baseColor: "#d32f2f"; Layout.fillWidth: true } // dangerColor
            StatusButton { text: "Exit"; baseColor: "#f44336"; Layout.fillWidth: true }
            ActionButton { text: "Close"; Layout.fillWidth: true }

            // Speed op pair
            ActionButton { text: "speed op"; Layout.fillWidth: true }
            TextField {
                text: "0.005"
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                horizontalAlignment: Text.AlignHCenter
                color: "#ffffff"
                background: Rectangle { color: "#11111b"; border.color: "#3f3f5f"; radius: 3 }
            }

            // --- ROW 3 ---
            // Error Status Bar
            Rectangle {
                Layout.columnSpan: 2
                Layout.fillWidth: true
                Layout.preferredHeight: 32
                color: "#ff0000" // Red background from image
                radius: 2
                Text {
                    text: "No error"
                    anchors.centerIn: parent
                    color: "white"
                    font.bold: true
                }
            }
            ActionButton { text: "Add tool"; Layout.fillWidth: true }
            ActionButton { text: "Tool ip"; Layout.fillWidth: true }
            TextField {
                placeholderText: ""
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                background: Rectangle { color: "#ffffff"; border.color: "black"; radius: 2 }
            }
            StatusButton { text: "Eth rst"; baseColor: "#1b5e20"; Layout.fillWidth: true }

            // --- ROW 4 (The missing row from your code) ---
            // Coordinate display field
            TextField {
                text: "0,00,00,00,00,00,0"
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                color: "black"
                background: Rectangle { color: "#ffffff"; border.color: "black"; radius: 2 }
            }

            ActionButton { text: "Tp file"; Layout.fillWidth: true }

            TextField {
                text: "ppp"
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                color: "black"
                background: Rectangle { color: "#ffffff"; border.color: "black"; radius: 2 }
            }

            ActionButton { text: "Pg file"; Layout.fillWidth: true }

            // Empty placeholder field at the end of the row
            TextField {
                Layout.columnSpan: 2
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                background: Rectangle { color: "#ffffff"; border.color: "black"; radius: 2 }
            }
        }
    }
}
