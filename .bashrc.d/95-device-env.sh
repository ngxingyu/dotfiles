# Device-specific environment (CUDA_HOME, DATA_VOLUME, GZ_*, HF_HOME/
# TORCH_HOME/etc cache dirs, ...) lives in a single gitignored, per-machine
# file at the repo root: ~/.dotfiles/device-env.local.sh -- not here.
#
# These values (an exact CUDA point version, a specific mount path) are
# true on one specific box and would silently point at the wrong thing
# anywhere else, so there's deliberately no shared/tracked copy and no
# defaults are guessed here. Populate device-env.local.sh directly on
# machines that need it.
DEVICE_ENV_FILE="$HOME/.dotfiles/device-env.local.sh"
if [ -f "$DEVICE_ENV_FILE" ]; then
  . "$DEVICE_ENV_FILE"
elif command -v nvidia-smi >/dev/null 2>&1; then
  echo "warning: NVIDIA GPU detected but no $DEVICE_ENV_FILE -- device-specific env (CUDA_HOME, DATA_VOLUME, etc.) is unset on this machine" >&2
fi
