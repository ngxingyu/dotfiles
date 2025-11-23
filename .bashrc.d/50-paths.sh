export PATH=$PATH:~/.local/bin:/opt/TurboVNC/bin
export PATH=/usr/local/cuda-12.8/bin:/usr/src/tensorrt/bin/:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-12.8/lib64:$LD_LIBRARY_PATH
export CMAKE_PREFIX_PATH=/opt/openrobots:$CMAKE_PREFIX_PATH
export GZ_SIM_PHYSICS_ENGINE_PATH=/usr/lib/x86_64-linux-gnu/gz-sim-8/plugins
export GZ_VERSION=harmonic

#export WEIGHTS_PATH="/home/xingyu/weights"
export CUDA_HOME="/usr/local/cuda-12.8/"

: "${DATA_VOLUME:=/mnt/bags}"
export RATTLER_CACHE_DIR=$DATA_VOLUME/.cache/rattler/cache
export UV_CACHE_DIR=$DATA_VOLUME/.cache/uv/cache
export HF_HOME="$DATA_VOLUME/.cache/huggingface"
export TORCH_HOME="$DATA_VOLUME/.cache/torch"
export PATH="${HOME}/.pixi/bin:$PATH"
export EDITOR=nvim
