# Add paths
export PATH="$PATH:$HOME/.local/bin:/opt/TurboVNC/bin:${HOME}/.pixi/bin"

# CUDA / ccache-as-gcc-wrapper: not every box has this layout (macOS never
# does, plenty of Linux boxes don't either) -- guard by actual presence, not
# by OS, so this doesn't silently point $CC/$CXX at a nonexistent binary and
# break builds.
if [ -d /usr/local/cuda/bin ]; then
  export PATH="/usr/local/cuda/bin${PATH:+:${PATH}}"
  export LD_LIBRARY_PATH="/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"
fi
if [ -d /usr/lib/ccache ]; then
  export CC="/usr/lib/ccache/gcc"
  export CXX="/usr/lib/ccache/g++"
fi
export CCACHE_DIR="$HOME/.cache/ccache/"

# pixi/rattler + uv caches: ~/.cache is a safe default anywhere. A machine
# with a bigger/faster disk to use instead overrides these in
# device-env.local.sh (95-device-env.sh loads after this file, so an
# override there always wins).
export RATTLER_CACHE_DIR="$HOME/.cache/rattler/cache"
export UV_CACHE_DIR="$HOME/.cache/uv/cache"
