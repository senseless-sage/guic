source $app_dir/profiles/base/archlinux/options.fish

set options $options[1..-2] \
    --name gaming-container \
    --net=none \
    --device /dev/input \
    -v $HOME/games:$HOME/games \
    gaming-container