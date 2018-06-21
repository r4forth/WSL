#!/bin/bash
# 適用於: OSX High Sierra
# Version 0.1:	2018.06.15
#   01. 安裝 Homebrew 套件管理系統
#   02. 安裝 Jupyter Notebook 生態環境
#   03. 預計支援 Python3, nodejs, R, C, PeForth
# =============================================================================
# 安裝 Xcode Command Line Tools
# 這是讓您不需要安裝整個 XCode 環境的基礎開發程式包
# =============================================================================
xcode-select --install
# =============================================================================
# 安裝 Homebrew 套件管理系統
# 參考連結: https://brew.sh/index_zh-tw
# homebrew 支援的軟體安裝: https://formulae.brew.sh/formula/
# =============================================================================
# 
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install -y wget
brew install -y vim git
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/r4forth/WSL.git
cp ~/WSL/vimrc ~/.vimrc

# =============================================================================
# 安裝 Jupyter Notebook 生態環境
# 使用套件管理系統: Miniconda
# 參考連結: https://conda.io/miniconda.html
# =============================================================================
# 安裝 Miniconda
# 64 位元版本
wget https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
bash ~/Miniconda3-latest-MacOSX-x86_64.sh -b -p $HOME/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -b -p $HOME/miniconda
# 移動安裝檔案
mkdir ~/Desktop/WSL
mv Miniconda3-latest-MacOSX-x86_64.sh  ~/Desktop/WSL/Miniconda3-latest-Linux-x86_64.sh
# 新增環境變數路徑，OSX 要先新增 .bash_profile 檔案
touch ~/.bash_profile
# OSX 要修正指令
echo "export PATH=$HOME/miniconda/bin:$PATH" >> ~/.bash_profile
source ~/.bash_profile

# 更新 pip
pip install --upgrade pip

# 安裝 jupyter notebook
conda install jupyter -y

# =============================================================================
# 支援 nodejs 核心
# 參考連結: https://github.com/n-riesco/ijavascript
# =============================================================================
# 使用 miniconda 方式安裝
conda install nodejs -y
npm install -g ijavascript
ijsinstall

# =============================================================================
# 支援 c 核心
# 參考連結: https://github.com/brendan-rius/jupyter-c-kernel
# =============================================================================
pip install jupyter-c-kernel
sudo ~/miniconda/bin/install_c_kernel

# =============================================================================
# 支援 PeForth 核心
# 參考連結: https://github.com/hcchengithub/peforth
# =============================================================================
# 安裝 PeForth(2018.06.12 PeForth 1.16 版)
pip install peforth

# 建立目錄
mkdir ~/miniconda/share/jupyter/kernels/peforth
# 改寫成 OSX 可使用的版本
cp ~/WSL/PeForth/kernel.json ~/miniconda/share/jupyter/kernels/peforth
# 修正 ~ 變成 . 
sed -i -e '4s/~/./' ~/miniconda/share/jupyter/kernels/peforth/kernel.json

# =============================================================================
# 支援 R 核心
# 參考連結: https://irkernel.github.io/
# =============================================================================
# 安裝 R 環境
brew install R

# 待確認
# brew install openssl@1.1
# sudo chown -R $(whoami) $(brew --prefix)/*
# brew install -y pkg-config

# echo "export PATH=/usr/local/Cellar/openssl/1.0.2o_1/bin:$PATH" >> ~/.bash_profile
# source ~/.bash_profile

# 命令列環境執行 R 指令
# 進入到 R 環境
# R> install.packages("openssl", repos="https://cloud.r-project.org/")
sudo R -e 'install.packages(c("httr"),repos="https://cloud.r-project.org/")'
sudo R -e 'install.packages(c("crayon", "pbdZMQ", "devtools"),repos="https://cloud.r-project.org/")'
sudo R -e 'devtools::install_github(paste0("IRkernel/", c("repr", "IRdisplay", "IRkernel")))'
# 進入到 R 環境
# R> IRkernel::installspec()
# 執行完後，執行 q(save="yes") 離開 R 軟體

# 重啟伺服器。
# sudo reboot
