FROM debian

ARG USER

RUN apt update && apt -y install \
	mesa-utils mesa-vulkan-drivers mesa-va-drivers mesa-vdpau-drivers libgl1-mesa-dri libglx-mesa0 libegl-mesa0 libgbm1 libglapi-mesa libglu1-mesa \
    libwayland-client0 libwayland-cursor0 libwayland-egl1 libxcb1 libxkbcommon0 \
    locales gpg wget fish

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen

RUN useradd -m -G audio,video -s /usr/bin/fish $USER

RUN mkdir -p /run/user/1000 && chown -R $USER:$USER /run/user/1000

ENV USER=$USER

WORKDIR /home/$USER
