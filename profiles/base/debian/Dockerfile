FROM debian

ARG USERNAME
ARG LOCAL_TIME

RUN apt update && apt -y install \
    libva2 libvdpau1 libvdpau-va-gl1 \
    mesa-utils mesa-vulkan-drivers mesa-va-drivers mesa-vdpau-drivers libgl1-mesa-dri libglx-mesa0 libegl-mesa0 libgbm1 libglapi-mesa libglu1-mesa \
    pipewire pipewire-audio pipewire-alsa pipewire-pulse libopenal1 gstreamer1.0-plugins-base gstreamer1.0-plugins-base \
    libwayland-client0 libwayland-cursor0 libwayland-egl1 libxcb1 libxkbcommon0 \
    locales gpg wget fish catatonit

COPY --chmod=755 ./resources/xdg-open.fish /usr/bin/xdg-open

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen
RUN ln -sf "$LOCAL_TIME" /etc/localtime

RUN useradd -m -G audio,video -s /usr/bin/fish $USERNAME

ENV XAUTHORITY=/home/$USERNAME/.Xauthority
ENV QT_QPA_PLATFORM=wayland

ENV XDG_RUNTIME_DIR=/run/user/1000
RUN mkdir -p $XDG_RUNTIME_DIR && chown -R $USERNAME:$USERNAME $XDG_RUNTIME_DIR

ENV USER=$USERNAME
WORKDIR /home/$USERNAME
USER $USERNAME

ENTRYPOINT ["/usr/bin/catatonit", "-P"]
