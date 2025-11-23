# Detect Ubuntu major version
if [ -f /etc/os-release ]; then
    . /etc/os-release
    UBUNTU_MAJOR="${VERSION_ID%%.*}"  # extract major version
else
    UBUNTU_MAJOR="22"  # default fallback
fi

# Map Ubuntu major version to ROS distro
case "$UBUNTU_MAJOR" in
    "22") ROS_DISTRO=humble ;;
    "23") ROS_DISTRO=iron ;;
    "24") ROS_DISTRO=jazzy ;;
    "25") ROS_DISTRO=kilted ;;
    *) ROS_DISTRO=humble ;;  # fallback
esac

# Path to ROS setup
ROS_SETUP="/opt/ros/$ROS_DISTRO/setup.zsh"

# Set sr alias if the setup file exists
if [ -f "$ROS_SETUP" ]; then
    alias sr="source $ROS_SETUP"
fi

# ROS env variables
export ROS_DOMAIN_ID=5
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

if command -v register-python-argcomplete >/dev/null 2>&1; then
    eval "$(register-python-argcomplete ros2)"
    eval "$(register-python-argcomplete colcon)"
fi
export ISAAC_ROS_WS="${ISAAC_ROS_WS:-${HOME}/workspaces/isaac_ros-dev/}"
