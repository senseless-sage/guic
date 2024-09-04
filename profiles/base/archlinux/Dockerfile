FROM archlinux

ARG USER

RUN pacman --noconfirm --needed -Syyu \
    libva libvdpau \
    mesa mesa-utils vulkan-mesa-layers libva-mesa-driver mesa-vdpau \
    pipewire pipewire-alsa pipewire-pulse openal gst-plugins-base gst-plugins-good \
    libx11 libxau libxdmcp libxext libxft libxcomposite libxdamage libxinerama libxss libxt libxtst libxv \
    util-linux-libs libevdev libsm zlib bzip2 gtk3 sdl2 glu freeglut freeimage freetype2 glib2 \
    ffmpeg which micro \
    && pacman -Sc --noconfirm

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen

RUN useradd -m -G storage,audio,video -s /bin/bash $USER

RUN mkdir -p /run/user/1000 && chown -R $USER:$USER /run/user/1000

ENV USER=$USER

WORKDIR /home/$USER
