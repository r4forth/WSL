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
# 2018.06.08 感謝社團法人台灣符式推廣協會陳爽先生與陳厚成先生、先後移植 JeForth 與
# PeForth 至 Jupyter Notebook 環境，讓我們可以自由地進行程式語言教學。
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
pip install --upgrade pip
pip install jupyter-c-kernel
sudo /home/daniel/miniconda/bin/install_c_kernel

# =============================================================================
# 支援 PeForth 核心
# 參考連結: https://github.com/hcchengithub/peforth
# =============================================================================
# 安裝 PeForth(2018.07.19 PeForth 1.21 版)
pip install peforth

# 建立目錄
mkdir ~/miniconda/share/jupyter/kernels/peforth
# 改寫成使用 Github 專案的版本
cp ~/myBionic/PeForth/kernel.json ~/miniconda/share/jupyter/kernels/peforth
sed -i '4s/3.6/3.7/' ~/miniconda/share/jupyter/kernels/peforth/kernel.json
sed -i '4s/~/./' ~/miniconda/share/jupyter/kernels/peforth/kernel.json
# =============================================================================
# 支援 R 核心
# 參考連結: https://irkernel.github.io/
# =============================================================================
# 安裝 R 環境
# 加入公鑰
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
# 加入套件來源
sudo add-apt-repository 'deb https://ftp.yzu.edu.tw/CRAN/bin/linux/ubuntu bionic-cran35/'
# 更新系統與安裝 R 環境
sudo apt-get update
sudo apt-get install -y r-base libcurl4-openssl-dev libxml2-dev
sudo apt-get autoremove -y

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
