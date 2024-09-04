set dev_profile_autostart_dir (dirname (realpath (status --current-filename)))

ln -sf $dev_profile_autostart_dir/dev-container.service $HOME/.config/systemd/user/

systemctl --user enable $HOME/.config/systemd/user/dev-container.service
