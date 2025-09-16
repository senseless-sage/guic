FROM debian-gui-container

USER root

RUN apt update && apt -y install git fd-find fzf bat ripgrep eza tree curl micro visidata python3-openpyxl lf pcmanfm unzip fonts-noto-color-emoji

RUN wget -qO - https://packages.microsoft.com/keys/microsoft.asc \
    | gpg --dearmor \
    | dd of=/usr/share/keyrings/microsoft-archive-keyring.gpg \
    && echo "deb [ signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg ] https://packages.microsoft.com/repos/vscode stable main" \
    | tee /etc/apt/sources.list.d/vscode.list \
    && wget -O /usr/share/keyrings/dbeaver.gpg.key https://dbeaver.io/debs/dbeaver.gpg.key \
    && echo "deb [signed-by=/usr/share/keyrings/dbeaver.gpg.key] https://dbeaver.io/debs/dbeaver-ce /" \
    | tee /etc/apt/sources.list.d/dbeaver.list \
    && apt update && apt -y install code dbeaver-ce

RUN curl -L "https://dl.google.com/go/$(curl -s https://go.dev/VERSION?m=text | head -n 1).linux-amd64.tar.gz" | tar -xz -C /usr/local

USER $USER

RUN curl -fsSL https://bun.sh/install | bash