import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

ApplicationWindow {
    id: appWindow // <--- ADD THIS ID
    visible: true
    width: 1400
    height: 900
    title: "Robot Control Interface - TEXSONICS"
    color: "#1E1E2E"

    // --- GLOBAL THEME PROPERTIES ---
    property color primaryColor: "#40C4FF"
    property color accentColor: "#69F0AE"
    property color dangerColor: "#FF5252"
    property color successColor: "#00E676"
    property color warningColor: "#FFAB40"

    property color textMain: "#FFFFFF"
    property color textSec: "#B0BEC5"
    property color textDark: "#1E1E2E"

    property color panelBg: "#27273A"
    property color inputBg: "#151520"
    property color borderColor: "#3B3B50"
    property color hoverColor: "#32324A"

    property string fontFamily: "Segoe UI"

    // --- GLOBAL FUNCTION TO OPEN KEYPAD ---
    function showKeypad(targetTextField) {
        globalKeypad.x = (appWindow.width - globalKeypad.width) / 2
        globalKeypad.y = (appWindow.height - globalKeypad.height) / 2
        globalKeypad.openFor(targetTextField)
    }

    // --- KEYPAD INSTANCE ---
    VirtualKeypad {
        id: globalKeypad
    }

    // --- MAIN LAYOUT ---
    RowLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 12

        // 1. Left Panel
        LeftPanel {
            Layout.preferredWidth: parent.width * 0.5
            Layout.fillHeight: true
            currentCoordinateSystem: rightPanelControl.jogTab
        }

        // 2. Right Panel
        RightPanel {
            id: rightPanelControl
            Layout.preferredWidth: parent.width * 0.5
            Layout.fillHeight: true
        }
    }
}
