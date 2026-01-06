import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

ApplicationWindow {
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

    // --- MAIN LAYOUT ---
    RowLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 12

        // 1. Left Panel (Reduced size)
        LeftPanel {
            // CHANGED: Reduced from 0.45 to 0.35 to give RightPanel more room
            Layout.preferredWidth: parent.width * 0.25
            Layout.fillHeight: true
        }

        // 2. Right Panel (Expands to fill remaining space)
        RightPanel {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
