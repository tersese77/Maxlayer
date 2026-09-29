#!/bin/bash
set -e

DISPLAY_NUM="${DISPLAY_NUM:-1}"
DISPLAY=":${DISPLAY_NUM}"
VNC_PORT=$((5900 + DISPLAY_NUM))
WIDTH="${WIDTH:-1280}"
HEIGHT="${HEIGHT:-720}"
DEPTH="${DEPTH:-24}"

export DISPLAY

echo "=========================================="
echo " Maxlayer Ubuntu Desktop"
echo " Display : ${DISPLAY}"
echo " VNC     : ${VNC_PORT}"
echo " Web     : 80"
echo "=========================================="

# Clean stale VNC/X11 state from previous container runs.
rm -f "/tmp/.X${DISPLAY_NUM}-lock" "/tmp/.X11-unix/X${DISPLAY_NUM}" 2>/dev/null || true
rm -f "/home/ubuntu/.vnc/"*.pid "/home/ubuntu/.vnc/"*.log 2>/dev/null || true

# Start TigerVNC as the unprivileged desktop user.
su - ubuntu -c "vncserver ${DISPLAY} \
    -geometry ${WIDTH}x${HEIGHT} \
    -depth ${DEPTH} \
    -localhost no \
    -SecurityTypes None"

# Give VNC a moment to initialize.
sleep 2

echo "Desktop started."
echo "Open: http://<MAXLAYER-APP-HOST>/vnc.html"

# Keep the container attached to the web server on port 80.
exec websockify --web=/usr/share/novnc 0.0.0.0:80 127.0.0.1:${VNC_PORT}
