#!/bin/fish

function xdg-open
    set -l target $argv[1]

    set -l user_mimeapps_list $HOME/.config/mimeapps.list
    set -l system_mimeapps_list /usr/share/applications/mimeinfo.cache

    set -l user_app_dir $HOME/.local/share/applications
    set -l system_app_dir /usr/share/applications

    set -l mime_type

    if string match -rq '^[a-zA-Z][a-zA-Z0-9+.-]*://' -- $target
        set -l parts (string split -m1 '://' $target)
        set -l scheme $parts[1]
        set mime_type x-scheme-handler/$scheme
    else
        set -l file (realpath $target 2>/dev/null)

        if test $status -ne 0
            echo "xdg-open: file not found: $target" >&2
            return 1
        end

        set target $file
        set mime_type (file -b --mime-type $target)
    end

    set -l default_app (grep -m1 ^$mime_type= $user_mimeapps_list 2>/dev/null | cut -d= -f2 | cut -d';' -f1)

    if test -z $default_app
        set default_app (grep -m1 ^$mime_type= $system_mimeapps_list 2>/dev/null | cut -d= -f2 | cut -d';' -f1)
    end

    if test -z $default_app
        echo "xdg-open: no handler for $mime_type" >&2
        return 1
    end

    set -l desktop_file

    if test -f $user_app_dir/$default_app
        set desktop_file $user_app_dir/$default_app
    else if test -f $system_app_dir/$default_app
        set desktop_file $system_app_dir/$default_app
    else
        echo "xdg-open: desktop file not found: $default_app" >&2
        return 1
    end

    set -l exec_line (grep -m1 '^Exec=' $desktop_file | sed 's/^Exec=//')

    if test -z $exec_line
        echo "xdg-open: invalid desktop file, no Exec line: $desktop_file" >&2
        return 1
    end

    set exec_line (string replace -ra '%[fFuUdDnNickvm]' '' -- $exec_line)
    set exec_line (string trim -- $exec_line)

    set -l exec_args (string split ' ' -- $exec_line)

    if grep -qs '^Terminal=true' "$desktop_file"
        nohup setsid $TERMINAL -e $exec_args "$target" </dev/null >/dev/null 2>&1 &
    else
        nohup setsid $exec_args "$target" </dev/null >/dev/null 2>&1 &
    end

    return 0
end

xdg-open $argv
