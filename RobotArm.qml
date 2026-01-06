import QtQuick
import QtQuick3D

Node {
    id: root
    property var controller
    property real s: 1000.0
    eulerRotation.x: -90

    // --- JOINT MATERIALS ---
    PrincipledMaterial { id: matL0; baseColor: "#dcdcdc"; metalness: 0.6; roughness: 0.3 }
    PrincipledMaterial { id: matL1; baseColor: "#ff4500"; metalness: 0.5; roughness: 0.25 }
    PrincipledMaterial { id: matL2; baseColor: "#ff4500"; metalness: 0.5; roughness: 0.25 }
    PrincipledMaterial { id: matL3; baseColor: "#ff4500"; metalness: 0.5; roughness: 0.25 }
    PrincipledMaterial { id: matL4; baseColor: "#ff4500"; metalness: 0.5; roughness: 0.25 }
    PrincipledMaterial { id: matL5; baseColor: "#ff4500"; metalness: 0.5; roughness: 0.25 }

    // --------------------------------------------------
    // SIMPLE DEBUG POINT (REUSABLE COMPONENT)
    // --------------------------------------------------
    component DebugPoint : Model {
        source: "#Sphere"   // You can change to "#Sphere"
        scale: Qt.vector3d(0.01, 0.01, 0.01)
        materials: [
            PrincipledMaterial {
                baseColor: "red"
                lighting: PrincipledMaterial.NoLighting
            }
        ]
    }

    // --------------------------------------------------
    // BASE DEBUG POINT
    // --------------------------------------------------
    DebugPoint { id: basePoint }

    // --------------------------------------------------
    // LINK 0 (BASE)
    // --------------------------------------------------
    Model {
        source: "qrc:/meshes/link0.mesh"
        materials: [matL0]
        scale: Qt.vector3d(s, s, s)
    }

    // --------------------------------------------------
    // JOINT 1
    // --------------------------------------------------
    Node {
        id: j1Node
        eulerRotation.z: controller ? controller.j1 : 0
        Behavior on eulerRotation.z { NumberAnimation { duration: 180 } }

        Model {
            source: "qrc:/meshes/link1.mesh"
            materials: [matL1]
            scale: Qt.vector3d(s, s, s)
        }

        // --------------------------------------------------
        // JOINT 2
        // --------------------------------------------------
        Node {
            id: j2Node
            position: Qt.vector3d(0.150 * s, 0, 0.462 * s)
            eulerRotation.y: controller ? controller.j2 : 0
            Behavior on eulerRotation.y { NumberAnimation { duration: 180 } }

            Model {
                source: "qrc:/meshes/link2.mesh"
                materials: [matL2]
                scale: Qt.vector3d(s, s, s)
                position: Qt.vector3d(-0.150 * s, 0, -0.462 * s)
            }

            // --------------------------------------------------
            // JOINT 3
            // --------------------------------------------------
            Node {
                id: j3Node
                position: Qt.vector3d(0, 0, 0.600 * s)
                eulerRotation.y: controller ? controller.j3 : 0
                Behavior on eulerRotation.y { NumberAnimation { duration: 180 } }

                Model {
                    source: "qrc:/meshes/link3.mesh"
                    materials: [matL3]
                    scale: Qt.vector3d(s, s, s)
                    position: Qt.vector3d(-0.150 * s, 0, -1.062 * s)
                }

                // --------------------------------------------------
                // JOINT 4
                // --------------------------------------------------
                Node {
                    id: j4Node
                    position: Qt.vector3d(0, 0, 0.190 * s)
                    eulerRotation.x: controller ? controller.j4 : 0
                    Behavior on eulerRotation.x { NumberAnimation { duration: 180 } }

                    Model {
                        source: "qrc:/meshes/link4.mesh"
                        materials: [matL4]
                        scale: Qt.vector3d(s, s, s)
                        position: Qt.vector3d(-0.150 * s, 0, -1.252 * s)
                    }

                    // --------------------------------------------------
                    // JOINT 5
                    // --------------------------------------------------
                    Node {
                        id: j5Node
                        position: Qt.vector3d(0.687 * s, 0, 0)
                        eulerRotation.y: controller ? controller.j5 : 0
                        Behavior on eulerRotation.y { NumberAnimation { duration: 180 } }

                        Model {
                            source: "qrc:/meshes/link5.mesh"
                            materials: [matL5]
                            scale: Qt.vector3d(s, s, s)
                            position: Qt.vector3d(-0.837 * s, 0, -1.252 * s)
                        }

                        // --------------------------------------------------
                        // JOINT 6
                        // --------------------------------------------------
                        Node {
                            id: j6Node
                            position: Qt.vector3d(0.101 * s, 0, 0)
                            eulerRotation.x: controller ? controller.j6 : 0
                            Behavior on eulerRotation.x { NumberAnimation { duration: 180 } }

                            // -----------------------------
                            // TOOL CENTER POINT (DEBUG)
                            // -----------------------------
                            DebugPoint { id: tipPoint }

                            // Optional visible flange
                            Model {
                                source: "#Cube"
                                scale: Qt.vector3d(0.02, 0.02, 0.02)
                                materials: [
                                    PrincipledMaterial {
                                        baseColor: "#c0392b"
                                    }
                                ]
                            }
                        }
                    }
                }
            }
        }
    }
}
