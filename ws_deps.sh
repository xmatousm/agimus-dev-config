#!/bin/bash
# Init some dependencies
# (there is no need to run this script before ws_get)

# The directory of this script
SCRIPT="$(readlink -f "$0")"
BASE="$(dirname "$SCRIPT")"

# Work in the current directory
echo "Preparing workspace: $(pwd)"

# Init
mkdir -p src
cd src || exit 255
cd ..

ln -s "$BASE"/deps src/deps || exit 255
ls -la src/deps/ || exit 255  # verify readable permissions

# shellcheck source=/dev/null
source "/opt/ros/$ROS_DISTRO/setup.bash"

# Install all dependencies that are available as binaries
sudo apt-get update || exit 255

rosdep update --rosdistro "$ROS_DISTRO" || exit 255

rosdep install -y -i --from-paths src --rosdistro "$ROS_DISTRO" "${SKIP[@]}" || exit 255

rm -f src/deps || exit 255
