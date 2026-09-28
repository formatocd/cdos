// CDOS Welcome - Ventana principal
// Fase 1: esqueleto mínimo para verificar la cadena PySide6 + QML.

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 700
    height: 450
    title: qsTr("Welcome to CDOS")
    color: "#1a1a2e"

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20

        Label {
            text: qsTr("Welcome to CDOS")
            color: "#ffffff"
            font.pixelSize: 32
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
        }

        Label {
            text: qsTr("A work distribution for developers")
            color: "#a0a0b0"
            font.pixelSize: 16
            Layout.alignment: Qt.AlignHCenter
        }

        Label {
            text: qsTr("Fase 1: cadena PySide6 + QML verificada")
            color: "#003366"
            font.pixelSize: 12
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
