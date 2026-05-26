#!/bin/bash
# Get all dependencies for Agimus demos

# The directory of this script
SCRIPT="$(readlink -f "$0")"
BASE="$(dirname "$SCRIPT")"

# Work in the current directory
echo "Preparing workspace: $(pwd)"

# Init
mkdir -p src
cd src || exit 255
cd ..

git config --global advice.detachedHead false

# Get base repositories
vcs import --recursive src < "$BASE/ws.repos" || exit 255

# Dependencies for Franka robots - not needed

# Dependencies for KUKA robots
vcs import --recursive src  < src/agimus-demos-kuka/kuka.repos || exit 255

# Dependencies for optimal control - prebuilt

# Agimus-specific dependencies
vcs import --recursive src < src/agimus-demos/agimus_dev.repos || exit 255

# shellcheck source=/dev/null
source "/opt/ros/$ROS_DISTRO/setup.bash"

# Install all dependencies that are available as binaries
sudo apt-get update || exit 255

rosdep update --rosdistro "$ROS_DISTRO" || exit 255

rosdep install -y -i --from-paths src --rosdistro $ROS_DISTRO || exit 255
