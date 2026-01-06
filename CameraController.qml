import QtQuick
import QtQuick3D

QtObject {
    id: controller

    property View3D view3d
    property Camera camera
    property vector3d defaultPosition: Qt.vector3d(500, 300, 500)
    property vector3d defaultRotation: Qt.vector3d(-30, 45, 0)

    function resetView() {
        if (camera) {
            camera.position = defaultPosition
            camera.eulerRotation = defaultRotation
        }
    }

    function lookAt(target) {
        if (camera && target) {
            // Simple look-at implementation
            var direction = target.minus(camera.position).normalized()
            camera.lookAt(target)
        }
    }

    function setTopView() {
        camera.position = Qt.vector3d(0, 1000, 0)
        camera.eulerRotation = Qt.vector3d(-90, 0, 0)
    }

    function setFrontView() {
        camera.position = Qt.vector3d(0, 300, 1000)
        camera.eulerRotation = Qt.vector3d(0, 0, 0)
    }

    function setSideView() {
        camera.position = Qt.vector3d(1000, 300, 0)
        camera.eulerRotation = Qt.vector3d(0, -90, 0)
    }
}
