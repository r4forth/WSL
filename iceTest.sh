#!/bin/bash
# FigTaiwan iceStorm 開發小組
# 適用於: Ubuntu Desktop / WSL Ubuntu 
# ICEStorm 官方文件網址 http://www.clifford.at/icestorm/
# 安裝指令參考: 
# 
# Version 0.1:	2019.10.17
#   01. 安裝 C、NodeJS、PeForth、R、Python3
#   02. 
# 
# ============================================================================
# 更新套件
sudo apt-get update
sudo apt-get upgrade -y
# =============================================================================
# 安裝必要套件
sudo apt-get install -y vim git key-mon kazam 
sudo apt autoremove -y
# 設定 vim 套件管理系統
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# 複製 vimrc 到家目錄
# 請記得修改路徑 "/mnt/c/Users/使用者名稱/Desktop/WSL/"
# 此行僅限 WSL 環境使用，複製 vim 設定檔到家目錄
# cp /mnt/c/Users/$USER/Desktop/WSL/vimrc ~/.vimrc
# =============================================================================
# 安裝中文輸入法與中文字型
# 處理繪圖、報告產出無法正常顯示中文之問題
# =============================================================================
# Ubuntu 16.04 內建輸入法為 fcitx，如用繁體中文安裝，即有相關中文輸入法功能，只是需要新增對照表。
# 安裝 新酷音對照表
sudo apt-get install -y fcitx-chewing
# 文泉驛微米黑
sudo apt-get install -y ttf-wqy-microhei
# 文泉驛正黑
sudo apt-get install -y ttf-wqy-zenhei
# 文泉驛點陣宋體 X11
sudo apt-get install -y xfonts-wqy
# 教育部標準楷書
sudo apt-get install -y fonts-moe-standard-kai
# 教育部標準宋體
sudo apt-get install -y fonts-moe-standard-song
# 文鼎楷書體 Unicode
sudo apt-get install -y fonts-arphic-ukai
# 文鼎明體 Unicode
sudo apt-get install -y fonts-arphic-uming
# =============================================================================
# 安裝 ICEStorm
# https://omn0mn0m.github.io/blog/howto-icestorm-installation/
# =============================================================================
# 安裝必要元件
sudo apt-get install build-essential clang cmake bison flex libreadline-dev \
                     gawk tcl-dev libffi-dev git mercurial graphviz   \
                     xdot pkg-config python python3 libftdi-dev \
                     qt5-default python3-dev libboost-all-dev
# Installing Icestorm Tools
git clone https://github.com/cliffordwolf/icestorm.git icestorm
cd icestorm
make -j$(nproc)
sudo make install
# Installing Yosys
git clone https://github.com/cliffordwolf/yosys.git yosys
cd yosys
make -j$(nproc)
sudo make install
# Installing NextPNR
# Eigen3
sudo apt-get install libeigen3-dev
git clone https://github.com/YosysHQ/nextpnr nextpnr
cd nextpnr
cmake -DARCH=ice40 -DCMAKE_INSTALL_PREFIX=/usr/local .
make -j$(nproc)
sudo make install
