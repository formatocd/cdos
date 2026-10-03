#!/usr/bin/env python3
"""
CDOS Welcome - Pantalla de bienvenida de CDOS.

Fase 2.3a: detección de idioma del sistema y paso a QML como
variable global 'appLanguage'.
"""

import configparser
import os
import sys
from pathlib import Path

from PySide6.QtCore import QObject, QUrl, Slot
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine


def detect_language() -> str:
    """Detecta el idioma del sistema desde $LANG.

    Devuelve el código ISO 639-1 de dos letras (es, en, fr, de).
    Si no se puede determinar, devuelve 'en'.
    """
    lang = (
        os.environ.get("LANG")
        or os.environ.get("LC_ALL")
        or os.environ.get("LC_MESSAGES")
    )
    if not lang:
        return "en"
    return lang[:2].lower()


def detect_live() -> bool:
    """Detecta si estamos en una sesión Live de CDOS.

    live-boot monta el sistema de archivos en /run/live (o /lib/live
    en versiones antiguas). En una instalación en disco, esos
    directorios no existen.
    """
    return (
        os.path.isdir("/run/live")
        or os.path.isdir("/lib/live/mount")
    )


# Ruta al archivo de configuración del welcome.
# KDE lo lee para decidir si lanzar el welcome al iniciar sesión:
#   X-KDE-autostart-condition=cdos-welcome:rc:Autostart:true
CONFIG_DIR = Path.home() / ".config"
CONFIG_FILE = CONFIG_DIR / "cdos-welcomerc"


class Preferences(QObject):
    """Preferencias del usuario para el welcome.

    Expuesta a QML como context property 'prefs'. QML puede:
      - Leer el estado: prefs.autostartEnabled()
      - Cambiarlo: prefs.setAutostart(true/false)
    """

    @Slot(result=bool)
    def autostartEnabled(self) -> bool:
        """Lee el estado del autostart. Por defecto True si no hay archivo."""
        if not CONFIG_FILE.exists():
            return True
        config = configparser.ConfigParser()
        config.read(CONFIG_FILE)
        if "rc" not in config or "Autostart" not in config["rc"]:
            return True
        return config["rc"].getboolean("Autostart")

    @Slot(bool)
    def setAutostart(self, value: bool) -> None:
        """Escribe el estado del autostart en el archivo de config."""
        CONFIG_DIR.mkdir(parents=True, exist_ok=True)
        config = configparser.ConfigParser()
        if CONFIG_FILE.exists():
            config.read(CONFIG_FILE)
        if "rc" not in config:
            config["rc"] = {}
        config["rc"]["Autostart"] = "true" if value else "false"
        with CONFIG_FILE.open("w") as f:
            config.write(f)


def main() -> int:
    # Directorio donde está este script (y el QML en ui/)
    base_dir = Path(__file__).resolve().parent
    qml_file = base_dir / "ui" / "Main.qml"

    if not qml_file.exists():
        print(f"ERROR: no se encuentra {qml_file}", file=sys.stderr)
        return 1

    # Aplicación Qt
    app = QGuiApplication(sys.argv)
    app.setApplicationName("CDOS Welcome")
    app.setApplicationVersion("0.5.0")

    # Motor QML
    engine = QQmlApplicationEngine()

    # Detectar idioma y pasarlo a QML como variable global
    language = detect_language()
    engine.rootContext().setContextProperty("appLanguage", language)
    is_live = detect_live()
    engine.rootContext().setContextProperty("isLive", is_live)
    prefs = Preferences()
    engine.rootContext().setContextProperty("prefs", prefs)

    engine.load(QUrl.fromLocalFile(str(qml_file)))

    if not engine.rootObjects():
        print("ERROR: el QML no se ha cargado correctamente", file=sys.stderr)
        return 1

    return app.exec()


if __name__ == "__main__":
    sys.exit(main())
