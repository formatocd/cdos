// CDOS Welcome - Ventana principal
// Fase 2.2: cabecera + párrafo + tres columnas de secciones.

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 780
    height: 580
    minimumWidth: 700
    minimumHeight: 520
    title: qsTr("Welcome to CDOS")
    color: "#1a1a2e"

    // --- Componente reutilizable: botón de sección ---
    component SectionButton: Button {
        id: btn
        Layout.preferredWidth: 180
        Layout.preferredHeight: 36

        background: Rectangle {
            color: btn.hovered ? "#2a2a4e" : "#252540"
            radius: 4
            border.color: "#3a3a5e"
            border.width: 1
        }

        contentItem: Text {
            text: btn.text
            color: "#ffffff"
            font.pixelSize: 13
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    // --- Componente reutilizable: título de sección ---
    component SectionTitle: Label {
        color: "#8090a0"
        font.pixelSize: 11
        font.bold: true
        font.letterSpacing: 1.5
        Layout.alignment: Qt.AlignHCenter
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 40
        spacing: 24

        // --- Cabecera ---
        ColumnLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            spacing: 8

            Label {
                text: "Welcome to CDOS 0.5 (Trixie)"
                color: "#ffffff"
                font.pixelSize: 32
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
            }

            Label {
                text: "A work distribution for developers"
                color: "#a0a0b0"
                font.pixelSize: 16
                Layout.alignment: Qt.AlignHCenter
            }
        }

        Item { Layout.fillHeight: true }

        // --- Párrafo descriptivo ---
        Label {
            text: "Thank you for trying CDOS. This is a work distribution " +
                  "for developers based on Debian 13.\n\n" +
                  "This is the Live session: you can try the system " +
                  "without installing it on disk."
            color: "#c0c0d0"
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            Layout.maximumWidth: 600
            Layout.alignment: Qt.AlignHCenter
        }

        Item { Layout.fillHeight: true }

        // --- Tres columnas de secciones ---
        RowLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            spacing: 32

            // DOCUMENTATION
            ColumnLayout {
                spacing: 8

                SectionTitle { text: "DOCUMENTATION" }

                SectionButton { text: "Read me" }
                SectionButton { text: "Release info" }
            }

            // SUPPORT
            ColumnLayout {
                spacing: 8

                SectionTitle { text: "SUPPORT" }

                SectionButton { text: "Issues" }
            }

            // PROJECT
            ColumnLayout {
                spacing: 8

                SectionTitle { text: "PROJECT" }

                SectionButton { text: "Repository" }
                SectionButton { text: "Contributing" }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
