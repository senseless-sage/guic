set options \
    --userns=keep-id \
    --device /dev/dri \
    --shm-size=2gb \
    -e LANGUAGE \
    -e LANG \
    -e DISPLAY \
    -e WAYLAND_DISPLAY \
    -e QT_QPA_PLATFORM=wayland \
    -e XDG_RUNTIME_DIR \
    -v /etc/localtime:/etc/localtime:ro \
    -v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0:ro \
    -v $HOME/.Xauthority:$HOME/.Xauthority:ro \
    -v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:ro \
    -v $XDG_RUNTIME_DIR/pipewire-0:$XDG_RUNTIME_DIR/pipewire-0:ro \
    debian-gui-container
