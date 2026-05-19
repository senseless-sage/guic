set options \
    --userns=keep-id \
    --device /dev/dri \
    --shm-size=2gb \
    -e LANGUAGE \
    -e LANG \
    -e DISPLAY \
    -e WAYLAND_DISPLAY \
    -v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0:ro \
    -v $HOME/.Xauthority:$HOME/.Xauthority:ro \
    -v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:ro \
    -v $XDG_RUNTIME_DIR/pipewire-0:$XDG_RUNTIME_DIR/pipewire-0:ro \
    debian-gui-container
