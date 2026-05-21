#!/usr/bin/env fish

set -g updates

set -g user_id 1000
set -g user_name (getent passwd $user_id | cut -d: -f1)

if test -z "$user_name"
    echo "No user found for UID $user_id"
    exit 1
end

function as_user
    runuser -u $user_name -- $argv
end

function fail
    as_user dunstify -u critical "Update Script Failed" "$argv[1]"
    exit 1
end

function add_update
    set -ga updates $argv[1]
end

function check_apt
    apt update -qq
    or fail "apt update failed"

    set -l upgrades (as_user apt list --upgradable 2>/dev/null | tail -n +2)

    if test -n "$upgrades"
        add_update apt
    end
end

function check_bun
    set -l current (as_user bun --version)
    set -l latest (as_user curl -fLsS https://registry.npmjs.org/bun/latest | jq -r .version)
    or fail "failed fetching bun version"

    if test "$current" != "$latest"
        add_update bun
    end
end

function check_go
    set -l current (as_user go version | awk '{print $3}' | string replace go "")
    set -l latest (as_user curl -fLsS https://go.dev/VERSION?m=text | head -n1 | string replace go "")
    or fail "failed fetching go version"

    if test "$current" != "$latest"
        add_update go
    end
end

function check_zed
    set -l current (as_user zed --version | awk '{print $2}')
    set -l latest (as_user curl -fLsS https://api.github.com/repos/zed-industries/zed/releases/latest | jq -r .tag_name | string trim -c v)
    or fail "failed fetching zed version"

    if test "$current" != "$latest"
        add_update zed
    end
end

function upgrade_apt
    apt update && apt upgrade -y
    or fail "apt upgrade failed"
end

function upgrade_bun
    set -l tmp (mktemp -d)

    as_user curl -fLsS https://github.com/oven-sh/bun/releases/latest/download/bun-linux-x64.zip -o $tmp/bun.zip
    or fail "failed downloading bun"

    unzip -o $tmp/bun.zip -d /tmp/
    or fail "failed extracting bun"

    cp /tmp/bun-linux-x64/bun /usr/lib/bun/
    or fail "failed installing bun"

    ln -sf /usr/lib/bun/bun /usr/bin/bun
    or fail "failed linking bun"

    rm -rf $tmp /tmp/bun-linux-x64
end

function upgrade_go
    set -l version (as_user curl -fLsS https://go.dev/VERSION?m=text | head -n1)
    or fail "failed fetching go version"

    set -l tmp (mktemp)

    as_user curl -fLsS "https://dl.google.com/go/$version.linux-amd64.tar.gz" -o $tmp
    or fail "failed downloading go"

    rm -rf /usr/local/go
    tar -xzf $tmp -C /usr/local
    or fail "failed installing go"

    rm -f $tmp
end

function upgrade_zed
    set -l tmp (mktemp)

    as_user curl -fLsS "https://cloud.zed.dev/releases/stable/latest/download?asset=zed&arch=x86_64&os=linux&source=docs" -o $tmp
    or fail "failed downloading zed"

    rm -rf /usr/lib/zed.app
    tar -xzf $tmp -C /usr/lib/
    or fail "failed installing zed"

    ln -sf /usr/lib/zed.app/bin/zed /usr/bin/zed
    or fail "failed linking zed"

    rm -f $tmp
end

check_apt
check_bun
check_go
check_zed

if test (count $updates) -eq 0
    as_user dunstify "System Up To Date" "No updates available"
    exit 0
end

set -l list (string join ", " $updates)

set -l action (as_user dunstify --action="upgrade,Upgrade" --action="dismiss,Dismiss" --urgency=normal --block "Updates Available" "Update: $list")

if test "$action" != "upgrade"
    exit 0
end

for update in $updates
    switch $update
        case apt
            upgrade_apt

        case bun
            upgrade_bun

        case go
            upgrade_go

        case zed
            upgrade_zed
    end
end

as_user dunstify "Updates Finished" "Updated: $list"
