import QtQuick
import QtQuick3D
import QtQuick3D.Helpers

Node {
    id: envRoot

    // --- CONFIGURATION ---
    property int roomSize: 2000
    property int step: 100
    property int cornerX: -roomSize / 2
    property int cornerZ: -roomSize / 2

    property color floorColor: "#f2f8f4"   // Green-inspired
    property color backColor:  "#eef4fb"   // Blue-inspired
    property color sideColor:  "#fff6e5"   // Yellow-inspired

    // --- MATERIALS ---
    DefaultMaterial {
        id: gridMat
        diffuseColor: "#aaaaaa" // Darker grid lines for contrast
        lighting: DefaultMaterial.NoLighting
        lineWidth: 1.0
    }

    // Materials for the solid filled areas with slight transparency
    DefaultMaterial {
        id: floorFillMat;
        diffuseColor: floorColor;
        lighting: DefaultMaterial.NoLighting;
        opacity: 0.8;
        cullMode: DefaultMaterial.NoCulling
    }
    DefaultMaterial {
        id: backFillMat;
        diffuseColor: backColor;
        lighting: DefaultMaterial.NoLighting;
        opacity: 0.8;
        cullMode: DefaultMaterial.NoCulling
    }
    DefaultMaterial {
        id: sideFillMat;
        diffuseColor: sideColor;
        lighting: DefaultMaterial.NoLighting;
        opacity: 0.8;
        cullMode: DefaultMaterial.NoCulling
    }

    // =========================================================
    // 1. THE THREE PLANES (Floor, Back, Side) - LIGHT FILL
    // =========================================================

    // FLOOR PLANE (X-Z)
    Model {
        geometry: PlaneGeometry {
            width: envRoot.roomSize
            height: envRoot.roomSize
        }
        materials: [floorFillMat]
        eulerRotation.x: -90
        position: Qt.vector3d(0, 0, 0)

        Model {
            geometry: GridGeometry {
                horizontalLines: (envRoot.roomSize / envRoot.step) + 1
                verticalLines: (envRoot.roomSize / envRoot.step) + 1
                horizontalStep: envRoot.step
                verticalStep: envRoot.step
            }
            materials: [gridMat]
            position: Qt.vector3d(0, 0, 0.5) // Offset to prevent flickering
        }
    }

    // BACK PLANE (X-Y)
    Model {
        geometry: PlaneGeometry {
            width: envRoot.roomSize
            height: envRoot.roomSize
        }
        materials: [backFillMat]
        position: Qt.vector3d(0, envRoot.roomSize / 2, envRoot.cornerZ)

        Model {
            geometry: GridGeometry {
                horizontalLines: (envRoot.roomSize / envRoot.step) + 1
                verticalLines: (envRoot.roomSize / envRoot.step) + 1
                horizontalStep: envRoot.step
                verticalStep: envRoot.step
            }
            materials: [gridMat]
            position: Qt.vector3d(0, 0, 0.5)
        }
    }

    // SIDE PLANE (Y-Z)
    Model {
        geometry: PlaneGeometry {
            width: envRoot.roomSize
            height: envRoot.roomSize
        }
        materials: [sideFillMat]
        eulerRotation.y: 90
        position: Qt.vector3d(envRoot.cornerX, envRoot.roomSize / 2, 0)

        Model {
            geometry: GridGeometry {
                horizontalLines: (envRoot.roomSize / envRoot.step) + 1
                verticalLines: (envRoot.roomSize / envRoot.step) + 1
                horizontalStep: envRoot.step
                verticalStep: envRoot.step
            }
            materials: [gridMat]
            position: Qt.vector3d(0, 0, 0.5)
        }
    }

    // =========================================================
    // 2. TEXT LABEL DELEGATE (Remains same for clarity)
    // =========================================================

    Component {
        id: labelDelegate
        Node {
            property alias text: txt.text
            property alias textColor: txt.color
            property alias fontSize: txt.font.pixelSize
            Model {
                source: "#Rectangle"
                scale: Qt.vector3d(0.8, 0.4, 1)
                materials: [
                    DefaultMaterial {
                        diffuseMap: Texture {
                            sourceItem: Item {
                                width: 256; height: 128
                                Text {
                                    id: txt
                                    anchors.centerIn: parent
                                    font.pixelSize: 80
                                    font.bold: true
                                }
                            }
                        }
                    }
                ]
            }
        }
    }

    // =========================================================
    // 3. AXIS LABELS
    // =========================================================

    Repeater3D {
        model: (envRoot.roomSize / envRoot.step) + 1
        delegate: Loader3D {
            readonly property int val: -envRoot.cornerX - (index * envRoot.step)
            position: Qt.vector3d(-envRoot.cornerX + 80, 40, envRoot.cornerX + (index * envRoot.step))
            rotation: Qt.vector3d(0, 90, 0)
            sourceComponent: labelDelegate
            onLoaded: {
                item.text = val;
                item.textColor = "#008800" // Darker green for visibility on light BG
            }
        }
    }

    Repeater3D {
        model: (envRoot.roomSize / envRoot.step) + 1
        delegate: Loader3D {
            readonly property int val: envRoot.cornerX + (index * envRoot.step)
            position: Qt.vector3d(val, 40, -envRoot.cornerZ + 80)
            sourceComponent: labelDelegate
            onLoaded: { item.text = val; item.textColor = "#cc0000" } // Darker red
        }
    }

    Repeater3D {
        model: (envRoot.roomSize / envRoot.step) + 1
        delegate: Loader3D {
            readonly property int val: index * envRoot.step
            position: Qt.vector3d(-envRoot.cornerX + 80, val, envRoot.cornerZ)
            sourceComponent: labelDelegate
            visible: val >= 0
            onLoaded: { item.text = val; item.textColor = "#0000cc" } // Darker blue
        }
    }

    // =========================================================
    // 4. AXIS MARKERS
    // =========================================================

    Loader3D {
        position: Qt.vector3d(-envRoot.cornerX + 150, 60, 0)
        rotation: Qt.vector3d(0, 90, 0)
        sourceComponent: labelDelegate
        onLoaded: { item.text = "Y"; item.textColor = "#008800"; item.fontSize = 120 }
    }

    Loader3D {
        position: Qt.vector3d(0, 60, -envRoot.cornerZ + 150)
        sourceComponent: labelDelegate
        onLoaded: { item.text = "X"; item.textColor = "#cc0000"; item.fontSize = 120 }
    }

    Loader3D {
        position: Qt.vector3d(-envRoot.cornerX + 150, envRoot.roomSize / 2, envRoot.cornerZ)
        sourceComponent: labelDelegate
        onLoaded: { item.text = "Z"; item.textColor = "#0000cc"; item.fontSize = 120 }
    }
}
