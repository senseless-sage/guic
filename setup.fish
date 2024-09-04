set app_dir (dirname (realpath (status --current-filename)))

ln -sf $app_dir/guic.fish $HOME/.config/fish/functions/guic.fish
ln -sf $app_dir/guic-completion.fish $HOME/.config/fish/completions/guic.fish
