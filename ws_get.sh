#!/bin/bash
# Get all dependencies for Agimus demos

# The directory of this script
SCRIPT="$(readlink -f "$0")"
BASE="$(dirname "$SCRIPT")"

# Work in the current directory
echo "Preparing workspace: $(pwd)"

ERR=

# Init
mkdir -p src
cd src || exit 255
cd ..

git config --global advice.detachedHead false

# Get base repositories
vcs import --recursive src < "$BASE/ws.repos" || ERR=1

# Dependencies for Franka robots - not needed
# The agimus-demos packages has some franka dependencies; we need only the
# ROS-generic parts of the package, not the franka stuff, so skip it
SKIP=()
SKIP+=(--skip-keys franka_description)
SKIP+=(--skip-keys franka_gripper)
SKIP+=(--skip-keys franka_hardware)
SKIP+=(--skip-keys franka_ign_ros2_control)
SKIP+=(--skip-keys franka_robot_state_broadcaster)
SKIP+=(--skip-keys gripper_controllers)
SKIP+=(--skip-keys net_ft_description)
SKIP+=(--skip-keys net_ft_diagnostic_broadcaster)
SKIP+=(--skip-keys net_ft_driver)
SKIP+=(--skip-keys franka_example_controllers)

# Dependencies for KUKA robots
vcs import --recursive src  < src/agimus-demos-kuka/kuka.repos || ERR=1

# Dependencies for optimal control - prebuilt

# Agimus-specific dependencies
vcs import --recursive src < src/agimus-demos/agimus_dev.repos || ERR=1
vcs import --recursive src < src/agimus-demos-kuka/agimus.repos || ERR=1

# shellcheck source=/dev/null
source "/opt/ros/$ROS_DISTRO/setup.bash"

# update rosdep for ppython3-pypylon
sudo mkdir -p /etc/ros/rosdep/custom_rules
sudo cp src/vcs_agimus/agimus_cardboard/rosdep/pypylon.yaml /etc/ros/rosdep/custom_rules/pypylon.yaml || exit 255
sudo cp src/vcs_agimus/agimus_cardboard/rosdep/20-pypylon.list /etc/ros/rosdep/sources.list.d/20-pypylon.list || exit 255
sudo chmod a+rx /etc/ros/rosdep/custom_rules/pypylon.yaml /etc/ros/rosdep/sources.list.d/20-pypylon.list || exit 255


# Install all dependencies that are available as binaries
sudo apt-get update || exit 255

rosdep update --rosdistro "$ROS_DISTRO" || exit 255

rosdep install -y -i --from-paths src --rosdistro $ROS_DISTRO "${SKIP[@]}" || exit 255

if [ -n "$ERR" ]; then
    echo 
    echo "ERROR: Some errors in vcs, check above!"
    echo
    exit 255
fi
