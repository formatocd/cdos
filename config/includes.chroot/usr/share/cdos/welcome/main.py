#!/usr/bin/env python3
"""
CDOS Welcome - Pantalla de bienvenida de CDOS.

Fase 2.3a: detección de idioma del sistema y paso a QML como
variable global 'appLanguage'.
"""

import os
import sys
from pathlib import Path

from PySide6.QtCore import QUrl
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

    engine.load(QUrl.fromLocalFile(str(qml_file)))

    if not engine.rootObjects():
        print("ERROR: el QML no se ha cargado correctamente", file=sys.stderr)
        return 1

    return app.exec()


if __name__ == "__main__":
    sys.exit(main())
