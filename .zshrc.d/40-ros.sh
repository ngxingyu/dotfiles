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

# Per-project ROS_DOMAIN_ID / RMW_IMPLEMENTATION / etc. now live in each
# repo's pixi .env, not here.

autoload -U bashcompinit
bashcompinit

# Different devices ship different argcomplete entry-point names
# depending on package version -- try both rather than hardcoding one.
if command -v register-python-argcomplete3 >/dev/null 2>&1; then
    eval "$(register-python-argcomplete3 ros2)"
    eval "$(register-python-argcomplete3 colcon)"
elif command -v register-python-argcomplete >/dev/null 2>&1; then
    eval "$(register-python-argcomplete ros2)"
    eval "$(register-python-argcomplete colcon)"
fi
