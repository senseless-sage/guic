function guic -a cmd profile name -d 'Create and manage containers, which support running GUI apps.'
    set app_dir (dirname (realpath (status --current-filename)))

    [ -z "$cmd" ] || [ "$cmd" = -h ] && help_page && return

    if [ -z "$profile" -o ! -d "$app_dir/profiles/$profile" ]
        echo "Profile not found: $profile."
        return 1
    end

    if [ "$cmd" = build ]
        build $app_dir $profile
        return
    end

    if [ "$cmd" = create ]
        create $app_dir $profile $name
        return
    end
end

function build -a app_dir profile
    fish "$app_dir/profiles/$profile/build.fish"
end

function create -a app_dir profile name
    source "$app_dir/profiles/$profile/options.fish"

    if [ -n "$name" ]
        set options $options[1..-2] --name $name $options[-1]
    end

    podman create $options
end

function help_page
    set -l bold (tput bold)
    set -l normal (tput sgr0)

    echo -e {$bold}NAME{$normal}\n\tGui container
    echo -e \n{$bold}SYNOPSIS{$normal}\n\tguic CMD PROFILE [NAME]
    echo -e \n{$bold}DESCRIPTION{$normal}\n\tCreate and manage containers, which support running GUI apps.

    echo -e \n{$bold}OPTIONS{$normal}
    echo -e \t-h
    echo -e \t\tDisplay this help page.

    echo -e \n{$bold}CMD{$normal}
    echo -e \tbuild
    echo -e \t\tBuilds the container image for the PROFILE.
    echo -e \tcreate
    echo -e \t\tCreates the container for the PROFILE with the NAME.

    echo -e \n{$bold}PROFILES{$normal}
    echo -e \tProfiles define the container image and create / run options.

    echo -e \n{$bold}AUTHOR{$normal}
    echo -e \tSenseless Sage
end
