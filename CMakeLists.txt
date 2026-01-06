cmake_minimum_required(VERSION 3.16)
project(appsampleUI VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Quick3D)
qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appsampleUI main.cpp)

qt_add_qml_module(appsampleUI
    URI sampleUI
    VERSION 1.0
    QML_FILES
        Main.qml
        LeftPanel.qml
        RightPanel.qml
        PanelCard.qml
        StatusButton.qml
        ActionButton.qml
        AxisControl.qml
        ValueBox.qml
        MiniInput.qml
        CameraController.qml
        GridEnvironment.qml
        RobotArm.qml
)

# Using "assets" as the second argument adds :/assets/ to the path
qt_add_resources(appsampleUI "assets"
    FILES
        meshes/link0.mesh
        meshes/link1.mesh
        meshes/link2.mesh
        meshes/link3.mesh
        meshes/link4.mesh
        meshes/link5.mesh
)

target_link_libraries(appsampleUI PRIVATE Qt6::Quick Qt6::Quick3D)
