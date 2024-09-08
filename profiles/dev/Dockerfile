FROM debian-gui-container

RUN apt update && apt -y install catatonit git fd-find fzf bat ripgrep exa tree curl micro visidata python3-openpyxl lf pcmanfm

# Install vscode
RUN wget -qO - https://packages.microsoft.com/keys/microsoft.asc \
    | gpg --dearmor \
    | dd of=/usr/share/keyrings/microsoft-archive-keyring.gpg \
    && echo "deb [ signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg ] https://packages.microsoft.com/repos/vscode stable main" \
    | tee /etc/apt/sources.list.d/vscode.list \
    && apt update && apt -y install code

USER $USER

ENTRYPOINT ["/usr/bin/catatonit", "-P"]
