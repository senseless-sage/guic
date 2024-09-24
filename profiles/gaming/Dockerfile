FROM archlinux-gui-container

RUN echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

RUN pacman --noconfirm --needed -Syyu \
    lib32-vulkan-radeon lib32-vulkan-icd-loader lib32-libva lib32-libvdpau \
    lib32-mesa lib32-vulkan-mesa-layers lib32-libva-mesa-driver lib32-mesa-vdpau \
    lib32-pipewire lib32-openal lib32-gst-plugins-base lib32-gst-plugins-good \
    wine wine-mono winetricks zenity dolphin-emu qt6-wayland xorg-server-xvfb \
    && pacman -Sc --noconfirm

USER $USER

ENV WINEARCH=win32 \
    WINEPREFIX=/home/$USER/.wine \
    WINEDLLOVERRIDES="xaudio2_6,xaudio2_7,x3daudio1_7,xapofx1_5,xactengine3_7,msvcp100,msvcr100,vcomp100,atl100,d3d8,d3d9,d3d10core,d3d11,dxgi,d3dcompiler_43,d3dcompiler_47,d3dx9_43=n,b"
    
RUN xvfb-run sh -c 'wine wineboot && wine winecfg -v win7 && winetricks -q -f xact vcrun2010 dxvk'
