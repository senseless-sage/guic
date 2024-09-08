source $app_dir/profiles/base/archlinux/options.fish

set options $options[1..-2] \
    -it \
    --name gaming-container \
    --net=none \
    --device /dev/input \
    -v $HOME/games:$HOME/games:O \
    gaming-container
