podman build -t debian-gui-container --build-arg USERNAME=$USER --build-arg LOCAL_TIME=(readlink /etc/localtime) (dirname (realpath (status --current-filename)))
