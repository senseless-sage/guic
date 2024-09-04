set dev_profile_apps_dir (dirname (realpath (status --current-filename)))

ln -sf $dev_profile_apps_dir/*.desktop $HOME/.local/share/applications/
