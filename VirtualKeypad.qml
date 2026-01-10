import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Popup {
    id: keypadRoot
    width: 360
    height: 600
    modal: true
    focus: true
    anchors.centerIn: Overlay.overlay

    // --- THEME PALETTE ---
    readonly property color colBackground: "#1B1B29" // Deep Matte Navy
    readonly property color colSurface:    "#252535" // Slightly lighter for headers
    readonly property color colAccent:     "#40C4FF" // Cyan Highlight
    readonly property color colDisplay:    "#0A0A12" // Almost black for screen
    readonly property color colText:       "#FFFFFF"

    // Action Colors
    readonly property color colCrimson:    "#D32F2F"
    readonly property color colForest:     "#388E3C"
    readonly property color colSlate:      "#546E7A"

    property var targetField: null
    property string targetTitle: "NUMERIC INPUT"

    // Entry/Exit Animations
    enter: Transition { NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 150 } }
    exit: Transition { NumberAnimation { property: "opacity"; from: 1; to: 0; duration: 150 } }

    function openFor(field, title = "ENTER VALUE") {
        targetField = field
        targetTitle = title ? title.toUpperCase() : "NUMERIC INPUT"
        displayInput.text = field.text
        keypadRoot.open()
    }

    function handleInput(key) {
        if (key === "OK") {
            if (targetField) targetField.text = displayInput.text
            keypadRoot.close()
        } else if (key === "CLR") {
            displayInput.text = ""
        } else if (key === "←") {
            displayInput.text = displayInput.text.slice(0, -1)
        } else {
            if (key === "." && displayInput.text.indexOf(".") !== -1) return
            if (key === "-" && displayInput.text.length > 0) return
            displayInput.text += key
        }
    }

    // --- MAIN BACKGROUND SHADOW ---
    background: Item {
        Rectangle {
            id: mainBg
            anchors.fill: parent
            color: colBackground
            radius: 12
            border.color: Qt.lighter(colBackground, 1.5)
            border.width: 1
        }
        MultiEffect {
            source: mainBg
            anchors.fill: mainBg
            shadowEnabled: true
            shadowColor: "black"
            shadowBlur: 1.0
            shadowVerticalOffset: 12
            shadowHorizontalOffset: 0
        }
    }

    // --- CONTENT LAYOUT ---
    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // ============================================================
        // 1. WINDOW TITLE BAR
        // ============================================================
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 45
            color: colSurface
            radius: 12

            // Mask bottom corners to be square
            Rectangle { anchors.bottom: parent.bottom; width: parent.width; height: 10; color: colSurface }

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 15
                anchors.rightMargin: 10
                spacing: 10

                // Status Indicator
                Rectangle {
                    width: 8; height: 8; radius: 4; color: "#00E676"
                    MultiEffect { source: parent; anchors.fill: parent; blurEnabled: true; blur: 0.4 }
                }

                Text {
                    text: targetTitle
                    color: colAccent
                    font.pixelSize: 12
                    font.bold: true
                    font.letterSpacing: 1.5
                }

                Item { Layout.fillWidth: true } // Spacer

                // Close Button with Smooth Transition
                Button {
                    Layout.preferredWidth: 40
                    Layout.fillHeight: true
                    flat: true
                    onClicked: keypadRoot.close()

                    background: Rectangle {
                        color: parent.hovered ? colCrimson : "transparent"
                        radius: 6
                        // Smooth Color Transition
                        Behavior on color { ColorAnimation { duration: 200; easing.type: Easing.OutQuad } }
                    }
                    contentItem: Text {
                        text: "✕"
                        color: parent.hovered ? "white" : "#607D8B"
                        font.pixelSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        // Smooth Text Color Transition
                        Behavior on color { ColorAnimation { duration: 200 } }
                    }
                }
            }
        }

        // ============================================================
        // 2. DISPLAY AREA (Top)
        // ============================================================
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 110
            color: "transparent"

            Rectangle {
                anchors.fill: parent
                anchors.margins: 15
                color: colDisplay
                radius: 6
                border.color: "#303040"
                border.width: 1

                // Inner Shadow Simulation (Top Border)
                Rectangle { height: 2; width: parent.width; color: "#000000"; opacity: 0.5 }

                // Engineering Grid Overlay
                Canvas {
                    anchors.fill: parent
                    opacity: 0.08
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.strokeStyle = colAccent;
                        ctx.lineWidth = 1;
                        var step = 15;
                        for(var i=0; i<width; i+=step) { ctx.moveTo(i,0); ctx.lineTo(i,height); }
                        for(var j=0; j<height; j+=step) { ctx.moveTo(0,j); ctx.lineTo(width,j); }
                        ctx.stroke();
                    }
                }

                Text {
                    id: displayInput
                    anchors.fill: parent
                    anchors.rightMargin: 20
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    color: "white"
                    font.pixelSize: 52
                    font.family: "Monospace"
                    font.bold: true
                    text: "0"
                }
            }
        }

        // ============================================================
        // 3. NUMERIC GRID (Middle - Fills Space)
        // ============================================================
        GridLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: 15
            Layout.topMargin: 0
            Layout.bottomMargin: 10
            columns: 3
            rowSpacing: 12
            columnSpacing: 12

            // Reusable Number Button Component
            component NumBtn: Button {
                id: nBtn
                property string label: ""
                Layout.fillWidth: true
                Layout.fillHeight: true

                background: Rectangle {
                    radius: 8
                    // Vertical Gradient for 3D look
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: nBtn.pressed ? "#101015" : "#353545" }
                        GradientStop { position: 1.0; color: nBtn.pressed ? "#101015" : "#2A2A3A" }
                    }
                    border.color: nBtn.hovered ? colAccent : "transparent"
                    border.width: 1

                    // Button Shadow
                    layer.enabled: true
                    layer.effect: MultiEffect {
                        shadowEnabled: true
                        shadowColor: "black"
                        shadowVerticalOffset: 2
                        shadowBlur: 0.5
                    }
                }

                contentItem: Text {
                    text: nBtn.label
                    color: "white"
                    font.pixelSize: 28
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: handleInput(label)

                // Press Animation
                transform: Scale {
                    origin.x: nBtn.width/2; origin.y: nBtn.height/2
                    xScale: nBtn.pressed ? 0.96 : 1.0
                    yScale: nBtn.pressed ? 0.96 : 1.0
                    Behavior on xScale { NumberAnimation { duration: 50 } }
                }
            }

            // The Grid
            NumBtn { label: "7" } NumBtn { label: "8" } NumBtn { label: "9" }
            NumBtn { label: "4" } NumBtn { label: "5" } NumBtn { label: "6" }
            NumBtn { label: "1" } NumBtn { label: "2" } NumBtn { label: "3" }
            NumBtn { label: "." } NumBtn { label: "0" } NumBtn { label: "-" }
        }

        // ============================================================
        // 4. ACTION BUTTONS (Bottom - Fixed Height - EQUAL WIDTHS)
        // ============================================================
        GridLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            Layout.leftMargin: 15
            Layout.rightMargin: 15
            Layout.bottomMargin: 20

            // KEY CHANGE: Using GridLayout with uniformCellWidths forces equality
            columns: 3
            columnSpacing: 15
            uniformCellWidths: true

            // Reusable Action Button Component
            component ActionBtn: Button {
                id: aBtn
                property color baseColor: "gray"

                Layout.fillWidth: true
                Layout.fillHeight: true

                background: Rectangle {
                    radius: 8
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: aBtn.pressed ? Qt.darker(baseColor, 1.3) : Qt.lighter(baseColor, 1.2) }
                        GradientStop { position: 1.0; color: aBtn.pressed ? Qt.darker(baseColor, 1.3) : baseColor }
                    }
                    border.color: "white"
                    border.width: aBtn.hovered ? 2 : 0
                    opacity: aBtn.pressed ? 0.8 : 1.0
                }

                contentItem: Text {
                    text: aBtn.text
                    color: "white"
                    font.pixelSize: 20
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    style: Text.Outline; styleColor: "#40000000"
                }

                onClicked: handleInput(text === "←" ? "←" : text)
            }

            ActionBtn { text: "CLR"; baseColor: colCrimson; onClicked: handleInput("CLR") }
            ActionBtn { text: "←";   baseColor: colSlate;   onClicked: handleInput("←") }
            ActionBtn { text: "OK";  baseColor: colForest;  onClicked: handleInput("OK") }
        }
    }
}
