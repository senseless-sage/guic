set -l app_dir (dirname (realpath (status --current-filename)))
set -l commands build create

complete -c guic -f

complete -c guic -n "not __fish_seen_subcommand_from $commands" -a build \
    -d "Builds the container image for the PROFILE."

complete -c guic -n "not __fish_seen_subcommand_from $commands" -a create \
    -d "Creates the container for the PROFILE with the NAME."

complete -c guic -n "__fish_seen_subcommand_from build" \
    -a "(fd -t f build.fish $app_dir | sed -n 's|.*/guic/profiles/\(.*\)/build.fish|\1|p')"

complete -c guic -n "__fish_seen_subcommand_from create" \
    -a "(fd -t f options.fish $app_dir | sed -n 's|.*/guic/profiles/\(.*\)/options.fish|\1|p')"
