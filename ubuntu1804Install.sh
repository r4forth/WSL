#!/bin/bash
# FigTaiwan PeForth 開發環境
# 適用於: EZGO14 Kubuntu
# Version 0.1:	2018.07.18
#   01. 使用 Miniconda 來管理 Jupyter 環境 
#   02. 安裝 C、NodeJS、PeForth、R、Python3
# 備註:
# EZGO14 需要安裝 net-tools openssh-server 才能遠端管理
# =============================================================================
# 更新套件
sudo apt-get update
sudo apt-get upgrade -y
# =============================================================================
# 安裝必要套件
sudo apt-get install -y vim git
sudo apt autoremove -y
# 設定 vim 套件管理系統
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# 載入 myBionic 專案，裡面有常用的設定檔與資料檔 
git clone https://github.com/r4forth/myBionic.git
# 複製 vimrc，讓 vim 使用比較便利
cp ~/myBionic/vimrc ~/.vimrc

# =============================================================================
# 部份 Boadcom 無線網卡可能會無法使用，請執行
# =============================================================================
# sudo apt-get update 
# sudo apt-get install firmware-b43-installer 
# sudo apt-get remove bcmwl-kernel-source
# =============================================================================

# =============================================================================
# 安裝 gforth 環境
# 1. Ubuntu 套件庫預設 gforth 版本
# 2. snap 第三方維護版本
# =============================================================================
# 1. gforth 0.7.3
sudo apt install -y gforth
# 2. gforth 0.7.9
sudo apt install -y snapd
sudo snap install gforth-mtrute --edge
# 執行路徑在 /snap/bin/gforth-mtrute.gforth
# =============================================================================
# 安裝 Arduino 環境
# 1. Ubuntu 套件庫預設太舊
# 2. 到官網下載，2019/07/04 Arduino IDE 1.8.9 版
# daniel@t420s:/opt$ sudo find / -name Arduino
# /home/daniel/Arduino
# /opt/arduino-1.8.5/libraries/TFT/examples/Arduino
# =============================================================================



# =============================================================================
# 安裝 R 語言環境
# =============================================================================
# 安裝 R 環境
# 如果是用 mini.iso 安裝系統，需要額外安裝 gnupg 套件
sudo apt-get install -y gnupg
# 加入公鑰
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
# 加入套件來源
# 如果是用 mini.iso 安裝系統，需要額外安裝其他套件才能支援 add-apt-repository 
sudo apt -y install software-properties-common dirmngr apt-transport-https lsb-release ca-certificates
# 加入 R 套件庫，選用元智大學
sudo add-apt-repository 'deb https://ftp.yzu.edu.tw/CRAN/bin/linux/ubuntu bionic-cran35/'
# 更新系統與安裝 R 環境
sudo apt-get update
sudo apt-get install -y r-base libcurl4-openssl-dev libxml2-dev
sudo apt-get autoremove -y
# 安裝 RStudio IDE 環境
sudo apt-get install gdebi-core
wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.2.1335-amd64.deb
sudo gdebi rstudio-server-1.2.1335-amd64.deb
# =============================================================================
# 安裝 C 語言開發環境與 The Art and Science of C 範例程式庫
# https://www.stickmind.com/code-c/01-development-tools/
# 教科書附件下載連結
# 公用函式庫: https://www.ime.usp.br/~pf/Roberts/C-library/unix-xwindows/cslib.shar
# 範例程式碼: https://www.ime.usp.br/~pf/Roberts/C-library/programs/archive/programs.shar
# =============================================================================
sudo apt-get install -y build-essential
# 安裝 csh 與 X11 開發工具
sudo apt install -y csh libx11-dev
# 下載範例程式庫
cd ~
cp ~/myBionic/cslib.shar cslib.shar
sh cslib.shar
cd cslib
cp ~/myBionic/programs.shar programs.shar
make 
# 新增環境變數路徑
sed -i '$ a\export PATH="$HOME/cslib:$PATH"' ~/.bashrc
source ~/.bashrc
sh programs.shar
cd ~
# =============================================================================
# 安裝處理 Jupyter Notebook 環境
# 使用套件管理系統: Miniconda
# =============================================================================
# 安裝 Miniconda
# 64 位元版本
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash ~/Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda
# 新增環境變數路徑
sed -i '$ a\export PATH="$HOME/miniconda/bin:$PATH"' ~/.bashrc
# 環境變數啟用
source ~/.bashrc
# 更新 pip
pip install --upgrade pip
# 安裝 jupyter notebook
conda install jupyter -y
# 修改設定檔，允許遠端登入
# 產生 Jupyter notebook 設定檔
jupyter notebook --generate-config
# 2019.02.12 修正
# 允許本機以外的 IP 連入
sed -i '204s/#//' ~/.jupyter/jupyter_notebook_config.py
sed -i '204s/localhost/0.0.0.0/' ~/.jupyter/jupyter_notebook_config.py
# 不直接開啟瀏覽器
sed -i '267s/#//' ~/.jupyter/jupyter_notebook_config.py
sed -i '267s/True/False/' ~/.jupyter/jupyter_notebook_config.py
# 不使用密碼，可直接使用
sed -i '340s/#//' ~/.jupyter/jupyter_notebook_config.py
sed -i '340s/<generated>//' ~/.jupyter/jupyter_notebook_config.py

# =============================================================================
# 安裝 Jupyter notebook 各種程式語言支援核心
# 參考連結: https://github.com/jupyter/jupyter/wiki/Jupyter-kernels
# =============================================================================
# 2018.06.08 感謝社團法人臺灣符式推廣協會陳爽先生與陳厚成先生、先後移植 JeForth 與
# PeForth 至 Jupyter Notebook 環境，讓我們可以自由地進行程式語言教學。
# =============================================================================
# 支援 nodejs 核心
# 參考連結: https://github.com/n-riesco/ijavascript
# =============================================================================
# 使用 miniconda 方式安裝
# 缺開發工具時需要手動安裝 build-essential
# sudo apt install -y build-essential
# 問題待解
conda install nodejs -y
npm install -g ijavascript
ijsinstall

# =============================================================================
# 支援 c 核心
# 參考連結: https://github.com/brendan-rius/jupyter-c-kernel
# =============================================================================
pip install --upgrade pip
pip install jupyter-c-kernel
sudo /home/daniel/miniconda/bin/install_c_kernel

# =============================================================================
# 支援 PeForth 核心
# 參考連結: https://github.com/hcchengithub/peforth
# =============================================================================
# 安裝 PeForth(2019.07.03 PeForth 1.23 版)
pip install peforth

# 建立目錄
mkdir ~/miniconda/share/jupyter/kernels/peforth
# 改寫成使用 Github 專案的版本
# 2019.02.20 修正設定
cp ~/myBionic/kernel.json ~/miniconda/share/jupyter/kernels/peforth
sed -i '4s/3.6/3.7/' ~/miniconda/share/jupyter/kernels/peforth/kernel.json
sed -i '4s/~/./' ~/miniconda/share/jupyter/kernels/peforth/kernel.json
# 異常，待處理

# =============================================================================
# 支援 R 核心
# 參考連結: https://irkernel.github.io/
# =============================================================================
# 安裝 jupyter notebook R Kernel
sudo apt-get install -y build-essential libcurl4-gnutls-dev libssl-dev
sudo apt-get install -y libzmq3-dev
# 命令列環境執行 R 指令
sudo R -e 'install.packages(c("crayon", "pbdZMQ", "devtools"))'
sudo R -e 'devtools::install_github(paste0("IRkernel/", c("repr", "IRdisplay", "IRkernel")))'
# 進入到 R 環境
# R> IRkernel::installspec()
# 執行完後，執行 q(save="yes") 離開 R 軟體

# =============================================================================
# 支援 ESP8266 核心
# 參考連結: https://github.com/goatchurchprime/jupyter_micropython_kernel
# =============================================================================
git clone https://github.com/goatchurchprime/jupyter_micropython_kernel.git
pip install -e jupyter_micropython_kernel
# 安裝 ESP8266 核心
python -m jupyter_micropython_kernel.install
# 設定使用者有權限直接處理 serial port
# 待續    
