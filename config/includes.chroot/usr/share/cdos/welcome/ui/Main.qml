// CDOS Welcome - Ventana principal
// Fase 2.1: cabecera con título, subtítulo y texto descriptivo.

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 700
    height: 500
    minimumWidth: 600
    minimumHeight: 450
    title: qsTr("Welcome to CDOS")
    color: "#1a1a2e"

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

        // --- Espacio flexible antes del párrafo ---
        Item {
            Layout.fillHeight: true
        }

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
            Layout.maximumWidth: 520
            Layout.alignment: Qt.AlignHCenter
        }

        // --- Espacio flexible después del párrafo ---
        Item {
            Layout.fillHeight: true
        }
    }
}
