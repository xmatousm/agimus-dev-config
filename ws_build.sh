#!/bin/bash
# Build workspace

# Work in the current directory
echo "Building workspace: $(pwd)"

# Source ROS base
# shellcheck source=/dev/null
source "/opt/ros/$ROS_DISTRO/setup.bash"

# Max number of CPU cores
export MAKEFLAGS="-j 4"

# Build the workspace. Merge install is required to make Python bindings work
colcon build \
       --symlink-install \
       --merge-install \
       --cmake-args \
       --no-warn-unused-cli \
       -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
       -DCMAKE_BUILD_TYPE=Release \
       -DBUILD_TESTING=OFF \
       -DBUILD_BENCHMARK=OFF \
       -DBUILD_BENCHMARKS=OFF \
       -DBUILD_EXAMPLES=OFF \
       -DINSTALL_DOCUMENTATION=OFF \
       -DBUILD_PYTHON_INTERFACE=ON \
       -DGENERATE_PYTHON_STUBS=OFF \
       -DCOAL_BACKWARD_COMPATIBILITY_WITH_HPP_FCL=ON \
       -DCOAL_HAS_QHULL=ON \
       -DBUILD_WITH_COLLISION_SUPPORT=ON \
       -DBUILD_WITH_MULTITHREADS=ON \
       "$@"
