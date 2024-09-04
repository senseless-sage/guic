FROM archlinux-gui-container

RUN echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

RUN pacman --noconfirm --needed -Syyu \
    lib32-vulkan-radeon lib32-vulkan-icd-loader lib32-libva lib32-libvdpau \
    lib32-mesa lib32-vulkan-mesa-layers lib32-libva-mesa-driver lib32-mesa-vdpau \
    lib32-pipewire lib32-openal lib32-gst-plugins-base lib32-gst-plugins-good \
    wine winetricks zenity \
    && pacman -Sc --noconfirm

USER $USER
