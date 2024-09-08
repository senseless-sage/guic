FROM archlinux-gui-container

RUN echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

RUN pacman --noconfirm --needed -Syyu \
    lib32-vulkan-radeon lib32-vulkan-icd-loader lib32-libva lib32-libvdpau \
    lib32-mesa lib32-vulkan-mesa-layers lib32-libva-mesa-driver lib32-mesa-vdpau \
    lib32-pipewire lib32-openal lib32-gst-plugins-base lib32-gst-plugins-good \
    wine wine-mono winetricks zenity dolphin-emu xorg-server-xvfb \
    && pacman -Sc --noconfirm

USER $USER

ENV WINEARCH=win32 \
    WINEPREFIX=/home/$USER/.wine \
    WINEDLLOVERRIDES="d3d8,d3d9,d3d10core,d3d11,dxgi=n,b"
    
RUN xvfb-run sh -c 'wine wineboot && wine winecfg -v win7 && winetricks -q --force xact vcrun2010 dxvk'
