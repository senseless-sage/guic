FROM debian-gui-container

USER root

COPY ./resources/debian.sources /etc/apt/sources.list.d/debian.sources

ENV DBUS_SESSION_BUS_ADDRESS=unix:path=$XDG_RUNTIME_DIR/bus
ENV GNOME_KEYRING_CONTROL=$XDG_RUNTIME_DIR/keyring
ENV SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/keyring/ssh

ENV BUN_INSTALL=/usr/lib/bun-linux-x64
ENV GOROOT=/usr/local/go
ENV GOBIN=/home/$USER/go/bin

ENV PATH="${PATH}:${BUN_INSTALL}/bin:${GOROOT}/bin:${GOBIN}"

RUN apt update && apt -y install dbus gnome-keyring xdg-desktop-portal-gtk \
    git rsync fd-find fzf bat ripgrep eza tree curl micro visidata python3-openpyxl lf pcmanfm unzip fonts-noto-color-emoji

RUN wget -O /usr/share/keyrings/dbeaver.gpg.key https://dbeaver.io/debs/dbeaver.gpg.key \
    && echo "deb [signed-by=/usr/share/keyrings/dbeaver.gpg.key] https://dbeaver.io/debs/dbeaver-ce /" \
    | tee /etc/apt/sources.list.d/dbeaver.list \
    && apt update && apt -y install dbeaver-ce

RUN curl -L "https://dl.google.com/go/$(curl -s https://go.dev/VERSION?m=text | head -n 1).linux-amd64.tar.gz" \
    | tar -xz -C /usr/local

RUN curl -L "https://github.com/oven-sh/bun/releases/latest/download/bun-linux-x64.zip" -o /bun.zip \
    && unzip /bun.zip -d /usr/lib/ \
    && rm /bun.zip \
    && ln -sf $BUN_INSTALL/bun /usr/bin/bun

RUN curl -L "https://cloud.zed.dev/releases/stable/latest/download?asset=zed&arch=x86_64&os=linux&source=docs" \
    | tar -xz -C  /usr/lib/ \
    && ln -sf /usr/lib/zed.app/bin/zed /usr/bin/zed

COPY --chmod=755 ./resources/entrypoint.sh /usr/local/bin/entrypoint.sh

USER $USER

COPY --chown=$USER:$USER ./resources/login.keyring /home/$USER/.local/share/keyrings/login.keyring
RUN echo "login" > /home/$USER/.local/share/keyrings/default

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
