set dev_profile_systemd_dir (dirname (realpath (status --current-filename)))

mkdir -p $HOME/.config/systemd/user

ln -sf $dev_profile_systemd_dir/dev-container.service $HOME/.config/systemd/user/
ln -sf $dev_profile_systemd_dir/dev-container-updater.service $HOME/.config/systemd/user/
ln -sf $dev_profile_systemd_dir/dev-container-updater.timer $HOME/.config/systemd/user/

systemctl --user enable $HOME/.config/systemd/user/dev-container.service
systemctl --user enable $HOME/.config/systemd/user/dev-container-updater.timer
