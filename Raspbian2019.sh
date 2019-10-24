#!/bin/bash
# 樹梅派4 教育訓練環境
# 適用於: Raspbian Buster 
# Version 0.1:	2019.10.24
#   01. 安裝 C、NodeJS、PeForth、R、Python3
# 備註：
#   01. 調整為常用軟體組合 
#   02. 測試    
# =============================================================================
# 更新套件
sudo apt-get update
sudo apt-get upgrade -y
# =============================================================================
# 安裝必要套件
sudo apt-get install -y vim git
# 讀取 ntfs 磁碟
sudo apt install -y ntfs-3g
sudo apt autoremove -y
# 設定 vim 套件管理系統
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# 載入 myBuster 專案，裡面有常用的設定檔與資料檔 
git clone https://github.com/r4forth/myBuster.git
# 複製 vimrc，讓 vim 使用比較便利
cp ~/myBuster/vimrc ~/.vimrc
# =============================================================================
# 安裝 C 語言開發環境與 The Art and Science of C 範例程式庫
# https://www.stickmind.com/code-c/01-development-tools/
# 教科書附件下載連結
# 公用函式庫: https://www.ime.usp.br/~pf/Roberts/C-library/unix-xwindows/cslib.shar
# 範例程式碼: https://www.ime.usp.br/~pf/Roberts/C-library/programs/archive/programs.shar
# =============================================================================
# 安裝基本程式開發工具
sudo apt-get install -y build-essential

# =============================================================================
# 安裝教育類軟體
# =============================================================================
# 鍵盤按鈕輔助工具
sudo apt install -y key-mon

# =============================================================================
# 安裝中文環境
# =============================================================================
# 中文輸入法
sudo apt install -y fcitx fcitx-chewing
# 常用中文字型
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
# 安裝 nodejs 環境
# =============================================================================


# =============================================================================
# 安裝 gforth 環境
# =============================================================================
