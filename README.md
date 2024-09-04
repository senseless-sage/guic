### Guic creates and manages podman containers, which support running GUI apps.

## Getting started
1. Install fish shell and podman
2. Download guic
3. Run ./guic/setup.fish

## Usage
Example for setting up a dev container and running vscode:
```sh
$ guic build dev
$ guic create dev
$ podman start -ai dev-container
$ podman exec dev-container code
```

## Profiles
Guic uses profiles, which are describing a containers state and runtime options.

A profile consists of at least the following parts:
- Dockerfile
- build.sh (builds the image based on the Dockerfile)
- options.fish (a list of podman run / create options)

The default profiles are:
- dev
- gaming
- base/debian
- base/archlinux

Guic has auto completion, so you can just TAB through your profiles.

## Auto starting the dev container
If you want your dev container to auto start on reboot, then you can run the setup script.

`$ fish ./guic/profiles/dev/autostart/setup.fish`

## Desktop environment integration for the dev container
If you want to launch a dev container app from your hosts system app launcher, then
you can add a *XDG desktop entry* for it to the `./guic/profiles/dev/apps` dir and run the setup script.

`$ fish ./guic/profiles/dev/apps/setup.fish`

## Init system in the dev container
You should use an init system for running your apps inside the container to prevent zombie processes.
Guic's dev container uses catatonit by default.

To run a process beneath the init system do so:

`$ podman exec dev-container sh -c '(app &)'`

## Compatibility
Guic works just in environments with a running Xorg or Wayland display server. So it runs natively on Linux and could be used on Windows and MacOS with additional configuration.

## Usefull podman container options
- Add "--ipc=host" if you dont care about security and want to avoid the X shared memory crash or use ""--shm-size=2gb".
- Add "--device /dev/input" if you want to use devices like controllers etc.
- Add "--network=none" to turn network off.
- Add "-v $DIR:$DIR:O" to add volume with overlayfs.
- Add the following for sharing the host dbus session:
    - DBUS_DIR="$(echo $DBUS_SESSION_BUS_ADDRESS | cut -d '=' -f 2)"
    -   -e DBUS_SESSION_BUS_ADDRESS
    -   -v $DBUS_DIR:$DBUS_DIR:ro