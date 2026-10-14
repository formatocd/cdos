# ==============================================================================
# CDOS Linux - Developer Edition
# ==============================================================================

# Incluimos la base oficial del Spin de KDE de Fedora
%include fedora-kickstarts/fedora-live-kde.ks

# Paquetería específica para CDOS
%packages --ignoremissing
# --- Paridad y Entornos RHEL ---
podman
podman-compose
buildah
skopeo
distrobox
ansible-core
rsync
openssh-clients

# --- Toolchains (Java OpenJDK LTS y Compiladores) ---
java-25-openjdk-devel
@development-tools
cmake
ninja-build
clang
git
curl
wget
jq
htop
tmux
tree

# --- Dependencias de desarrollo gráfico / Flutter ---
mesa-libGLU
libsecret-devel
libX11-devel

# Limpieza: quitamos suites de ofimática o clientes innecesarios
-kmail
-korganizer
-kontact
%end

# Personalización post-instalación de CDOS
%post
# 1. Branding de CDOS en el sistema
cat > /etc/os-release << 'OS_EOF'
NAME="CDOS Linux"
ID=cdos
ID_LIKE="fedora"
VERSION="1.0 (Developer Edition)"
VERSION_ID="1.0"
PRETTY_NAME="CDOS Linux 1.0 (Developer Edition)"
ANSI_COLOR="0;34"
DEFAULT_HOSTNAME="cdos-workstation"
OS_EOF

echo "cdos-workstation" > /etc/hostname

# 2. Configurar script de inicialización del entorno RHEL UBI
cat > /usr/local/bin/cdos-init-rhel-env << 'RHEL_EOF'
#!/bin/bash
echo "=== [CDOS] Inicializando entorno de compilación RHEL 9 UBI ==="
distrobox create --name rhel9-builder --image registry.access.redhat.com/ubi9/ubi:latest --yes
echo "=== [CDOS] Entorno listo. Accede con: distrobox enter rhel9-builder ==="
RHEL_EOF
chmod +x /usr/local/bin/cdos-init-rhel-env

# 3. Acceso directo en el menú de aplicaciones de KDE para el entorno RHEL
cat > /usr/share/applications/cdos-rhel-builder.desktop << 'DESK_EOF'
[Desktop Entry]
Name=CDOS RHEL 9 Builder
Comment=Entorno de desarrollo y compilación binaria compatible con RHEL 9
Exec=konsole -e bash -c "distrobox enter rhel9-builder || /usr/local/bin/cdos-init-rhel-env && distrobox enter rhel9-builder"
Icon=utilities-terminal
Terminal=false
Type=Application
Categories=Development;
DESK_EOF

%end
