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
    title: root.t.windowTitle
    color: "#1a1a2e"


    // --- Diccionario de traducciones ---
    // El idioma se detecta en main.py desde $LANG y se pasa como
    // variable global 'appLanguage'.
    readonly property var translations: {
        "es": {
		"title": "Bienvenido a CDOS 0.5 (Trixie)",
		"windowTitle": "Bienvenido a CDOS",
            "subtitle": "Una distribución de trabajo para desarrolladores",
            "intro": "Gracias por probar CDOS. Es una distribución de trabajo " +
                     "para desarrolladores basada en Debian 13.\n\n" +
                     "Esta es la sesión Live: puedes probar el sistema " +
                     "sin instalarlo en el disco.",
            "docSection": "DOCUMENTACIÓN",
            "supSection": "SOPORTE",
            "projSection": "PROYECTO",
            "readme": "Léeme",
            "release": "Notas de versión",
            "issues": "Incidencias",
            "repo": "Repositorio",
            "contributing": "Contribuir"
        },
        "fr": {
		"title": "Bienvenue sur CDOS 0.5 (Trixie)",
		"windowTitle": "Bienvenue sur CDOS",
            "subtitle": "Une distribution de travail pour les développeurs",
            "intro": "Merci d'essayer CDOS. C'est une distribution de travail " +
                     "pour les développeurs basée sur Debian 13.\n\n" +
                     "Ceci est la session Live : vous pouvez essayer le système " +
                     "sans l'installer sur le disque.",
            "docSection": "DOCUMENTATION",
            "supSection": "SUPPORT",
            "projSection": "PROJET",
            "readme": "Lisez-moi",
            "release": "Notes de version",
            "issues": "Problèmes",
            "repo": "Dépôt",
            "contributing": "Contribuer"
        },
        "de": {
		"title": "Willkommen bei CDOS 0.5 (Trixie)",
		"windowTitle": "Willkommen bei CDOS",
            "subtitle": "Eine Arbeitsdistribution für Entwickler",
            "intro": "Danke, dass Sie CDOS ausprobieren. Es ist eine Arbeitsdistribution " +
                     "für Entwickler, basierend auf Debian 13.\n\n" +
                     "Dies ist die Live-Sitzung: Sie können das System testen, " +
                     "ohne es auf der Festplatte zu installieren.",
            "docSection": "DOKUMENTATION",
            "supSection": "SUPPORT",
            "projSection": "PROJEKT",
            "readme": "Liesmich",
            "release": "Versionshinweise",
            "issues": "Probleme",
            "repo": "Repository",
            "contributing": "Mitwirken"
        },
        "en": {
		"title": "Welcome to CDOS 0.5 (Trixie)",
		"windowTitle": "Welcome to CDOS",
            "subtitle": "A work distribution for developers",
            "intro": "Thank you for trying CDOS. This is a work distribution " +
                     "for developers based on Debian 13.\n\n" +
                     "This is the Live session: you can try the system " +
                     "without installing it on disk.",
            "docSection": "DOCUMENTATION",
            "supSection": "SUPPORT",
            "projSection": "PROJECT",
            "readme": "Read me",
            "release": "Release info",
            "issues": "Issues",
            "repo": "Repository",
            "contributing": "Contributing"
        }
    }

    // Atajo al diccionario del idioma actual (con fallback a inglés)
    readonly property var t: translations[appLanguage] || translations["en"]

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
                text: root.t.title
                color: "#ffffff"
                font.pixelSize: 32
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
            }

            Label {
                text: root.t.subtitle
                color: "#a0a0b0"
                font.pixelSize: 16
                Layout.alignment: Qt.AlignHCenter
            }
        }

        Item { Layout.fillHeight: true }

        // --- Párrafo descriptivo ---
        Label {
            text: root.t.intro
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

                SectionTitle { text: root.t.docSection }

                SectionButton { text: root.t.readme }
                SectionButton { text: root.t.release }
            }

            // SUPPORT
            ColumnLayout {
                spacing: 8

                SectionTitle { text: root.t.supSection }

                SectionButton { text: root.t.issues }
            }

            // PROJECT
            ColumnLayout {
                spacing: 8

                SectionTitle { text: root.t.projSection }

                SectionButton { text: root.t.repo }
                SectionButton { text: root.t.contributing }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
