source $app_dir/profiles/base/debian/options.fish

set options $options[1..-2] \
    --name dev-container \
    --net=host \
    -e SHELL \
    -e TERM \
    -e TERMINAL \
    -e PAGER \
    -e EDITOR \
    -v $HOME/dev:$HOME/dev \
    dev-container
