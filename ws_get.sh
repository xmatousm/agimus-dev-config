#!/bin/bash
# Get all dependencies for Agimus demos

# Work in the directory of this script, prepare directories
cd "$(dirname "$0")" || exit 255
mkdir -p src
cd src || exit 255
cd ..

git config --global advice.detachedHead false

# Get base repositories
vcs import --recursive src < ws.repos || exit 255

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
