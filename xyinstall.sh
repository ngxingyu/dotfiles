#!/bin/bash
echo "Installing requirements"
sudo apt-get install clang
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo apt install cargo
cargo install --git https://github.com/latex-lsp/texlab.git
wget https://golang.org/dl/go1.14.6.linux-amd64.tar.gz
sudo tar -xvf 1.14.6.linux-amd64.tar.gz
sudo mv go /usr/local
sudo npm install -g vscode-css-languageserver-bin
sudo npm i -g bash-language-server
sudo apt-get install clangd-9
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-9 100

git config --global credential.helper cache #use ssh instead
git config --global credential.helper 'cache --timeout=3600' #use ssh instead

sudo apt-get install libgtest-dev
cd /usr/src/gtest
sudo cmake CMakeLists.txt
sudo make
 
# copy or symlink libgtest.a and libgtest_main.a to your /usr/lib folder
sudo cp *.a /usr/lib

