#!/bin/bash
curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o /tmp/nvim-nightly;
chmod +x /tmp/nvim-nightly;
sudo mv /tmp/nvim-nightly /usr/local/bin;
sudo ln -s /usr/local/bin/nvim-nightly /usr/local/bin/nvim;

