// CDOS Welcome - Ventana principal
// Fase 3.2: enlaces en botones + sección INSTALLATION con detección live.

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
    readonly property var translations: {
        "es": {
            "title": "Bienvenido a CDOS 0.5.3 (Trixie)",
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
            "contributing": "Contribuir",
            "installSection": "INSTALACIÓN",
            "launchInstaller": "Lanzar instalador",
	    "comingSoon": "El instalador de CDOS estará disponible en una versión próxima.",
            "launchAtStart": "Iniciar al arrancar"
        },
        "fr": {
            "title": "Bienvenue sur CDOS 0.5.3 (Trixie)",
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
            "contributing": "Contribuer",
            "installSection": "INSTALLATION",
            "launchInstaller": "Lancer l'installateur",
	    "comingSoon": "L'installateur CDOS sera disponible dans une prochaine version.",
	    "launchAtStart": "Lancer au démarrage"
        },
        "de": {
            "title": "Willkommen bei CDOS 0.5.3 (Trixie)",
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
            "contributing": "Mitwirken",
            "installSection": "INSTALLATION",
            "launchInstaller": "Installer starten",
	    "comingSoon": "Der CDOS-Installer wird in einer zukünftigen Version verfügbar sein.",
	    "launchAtStart": "Beim Start ausführen"
        },
        "en": {
            "title": "Welcome to CDOS 0.5.3 (Trixie)",
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
            "contributing": "Contributing",
            "installSection": "INSTALLATION",
            "launchInstaller": "Launch installer",
	    "comingSoon": "The CDOS installer will be available in a future version.",
	    "launchAtStart": "Launch at start"
        }
    }

    readonly property var t: translations[appLanguage] || translations["en"]

    // --- Componente reutilizable: botón de sección ---
    component SectionButton: Button {
        id: btn
        property string url: ""
        Layout.preferredWidth: 180
        Layout.preferredHeight: 36

        onClicked: Qt.openUrlExternally(url)

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

                SectionButton {
                    text: root.t.readme
                    url: "https://github.com/formatocd/cdos/blob/main/README.md"
                }
                SectionButton {
                    text: root.t.release
                    url: "https://github.com/formatocd/cdos/tags"
                }
            }

            // SUPPORT
            ColumnLayout {
                spacing: 8

                SectionTitle { text: root.t.supSection }

                SectionButton {
                    text: root.t.issues
                    url: "https://github.com/formatocd/cdos/issues"
                }
            }

            // PROJECT
            ColumnLayout {
                spacing: 8

                SectionTitle { text: root.t.projSection }

                SectionButton {
                    text: root.t.repo
                    url: "https://github.com/formatocd/cdos"
                }
                SectionButton {
                    text: root.t.contributing
                    url: "https://github.com/formatocd/cdos/blob/main/CONTRIBUTING.md"
                }
            }
        }

        Item { Layout.fillHeight: true }

        // --- Sección INSTALLATION (solo visible en live) ---
        ColumnLayout {
            visible: isLive
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            spacing: 8

            SectionTitle { text: root.t.installSection }

            SectionButton {
                text: root.t.launchInstaller
                Layout.alignment: Qt.AlignHCenter
                onClicked: installerDialog.open()
            }
        }

	Item { Layout.fillHeight: true }

	// --- Pie: toggle de autostart ---
        RowLayout {
            Layout.fillWidth: true
            Layout.topMargin: 8
            spacing: 12

            Item { Layout.fillWidth: true }  // empuja el contenido a la derecha

            Label {
                text: root.t.launchAtStart
                color: "#c0c0d0"
                font.pixelSize: 13
            }

            Switch {
                id: autostartSwitch
                checked: prefs.autostartEnabled()
                onToggled: prefs.setAutostart(checked)
            }
        }
    }

    // --- Diálogo informativo del instalador ---
    Dialog {
        id: installerDialog
        title: root.t.launchInstaller
        modal: true
        anchors.centerIn: parent
        standardButtons: Dialog.Ok

        Label {
            text: root.t.comingSoon
            color: "#202030"
            wrapMode: Text.WordWrap
        }
    }
}
