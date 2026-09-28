#!/usr/bin/env python3
"""
CDOS Welcome - Pantalla de bienvenida de CDOS.

Esqueleto mínimo de la Fase 1: verifica que PySide6 carga QML
correctamente. La lógica de negocio (botones, enlaces, configuración)
se añade en las siguientes fases.
"""

import sys
from pathlib import Path

from PySide6.QtCore import QUrl
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine


def main() -> int:
    # Directorio donde está este script (y el QML en ui/)
    base_dir = Path(__file__).resolve().parent
    qml_file = base_dir / "ui" / "Main.qml"

    if not qml_file.exists():
        print(f"ERROR: no se encuentra {qml_file}", file=sys.stderr)
        return 1

    # Aplicación Qt (necesaria para cargar QML)
    app = QGuiApplication(sys.argv)
    app.setApplicationName("CDOS Welcome")
    app.setApplicationVersion("0.5.0")

    # Motor QML
    engine = QQmlApplicationEngine()
    engine.load(QUrl.fromLocalFile(str(qml_file)))

    # Si el QML no se ha cargado, engine.rootObjects() estará vacío
    if not engine.rootObjects():
        print("ERROR: el QML no se ha cargado correctamente", file=sys.stderr)
        return 1

    return app.exec()


if __name__ == "__main__":
    sys.exit(main())
