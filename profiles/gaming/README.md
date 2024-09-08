# archlinux-wine-gaming-container

Setup for playing directx games in podman with wine and dxvk.

## Getting started
```sh
$ guic build base/archlinux
$ guic build gaming
$ guic create gaming
$ podman start -ai gaming-container
$ wine game.exe
```

## Notes
- FPS counter: DXVK_HUD=1 or WINEDEBUG=-all,+fps
- maybe needed winetricks depenendcies: dotnet452, msxml6, faudio, glut, mfc100, gfw, msasn1, winhttp
- maybe needed os dependencies: winbind, samba
- LIBGL_DEBUG=verbose glxinfo | grep libgl
- xdpyinfo | g -C 20 dri
- glxinfo | grep -i "vendor\|rendering"
- https://linuxreviews.org/Intel_Iris
- https://holarse.de/news/wine_proton_dxvk_vkd3d_vkd3d_proton_runtime_container_bitte_was_wir_bringen_etwas_licht_ins
- https://wiki.archlinux.org/title/AMDGPU
- https://github.com/iXit/wine-nine-standalone
    - The DRI3 backend is the preferred one and has the lowest CPU and memory overhead.
- https://archive.fosdem.org/2015/schedule/event/d3d9/attachments/slides/722/export/events/attachments/d3d9/slides/722/GalliumNineStatus.pdf
- https://wiki.archlinux.org/title/Hardware_video_acceleration#ATI/AMD
- https://www.google.com/search?client=firefox-b-d&q=amdgpu%3A+os_same_file_description+couldn%27t+determine+if+two+DRM+fds+reference+the+same+file+description
