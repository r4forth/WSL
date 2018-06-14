#!/bin/bash
# FigTaiwan PeForth 與 ReForth 開發環境
# 適用於: Ubuntu Server / WSL Ubuntu 
# Version 0.1:	2018.06.09
#   01. 安裝 C、NodeJS、PeForth、R、Python3
# Version 0.2:  2018.06.14
#   01. 安裝 RStudioServer 
#   02. 安裝 Tex 環境支援 PDF 文件產出    
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
# 複製 vimrc 到家目錄
# 請記得修改路徑 "/mnt/c/Users/使用者名稱/Desktop/WSL/"
# 此行僅限 WSL 環境使用，複製 vim 設定檔到家目錄
cp /mnt/c/Users/$USER/Desktop/WSL/vimrc ~/.vimrc

# =============================================================================
# 使用 Github 上的 WSL 目錄下 ubuntu1604Install.sh 安裝
# 專案網址: https://github.com/r4forth/WSL.git
# ============================================================================= 
# git clone https://github.com/r4forth/WSL.git
# source ~/WSL/ubuntu1604Install.sh

# =============================================================================
# 處理 WSL 預設 OpenSSH Server 設定問題
# Ubuntu 環境請直接使用 sudo apt-get install openssh-server 安裝服務即可
# =============================================================================
# 設定 SSH 設定
sudo sed -i -e '16s/yes/no/' /etc/ssh/sshd_config
sudo sed -i -e '28s/prohibit-password/no/' /etc/ssh/sshd_config
sudo sed -i -e '52s/no/yes/' /etc/ssh/sshd_config
# 請記得替換使用者名稱 daniel
sudo sed -i -e '$ a\AllowUsers daniel' /etc/ssh/sshd_config	
# 重啟 SH 伺服器。重啟前請記得關閉 Win10 的 SSH Server Broker Services 服務
# 避免使用 SSH 登入時，還又改 port
# Solve :Could not load host key: /etc/ssh/ssh_host_rsa_key
# 重新產出
sudo dpkg-reconfigure openssh-server 
sudo service ssh  --full-restart

# =============================================================================
# 安裝中文字型
# 處理繪圖、報告產出無法正常顯示中文之問題
# =============================================================================
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
# 安裝處理 Jupyter Notebook 環境
# 使用套件管理系統: Miniconda
# =============================================================================
# 安裝 Miniconda
# 64 位元版本
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
# 32 位元版本
# wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86.sh
bash ~/Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda
# 移動安裝檔案
mv Miniconda3-latest-Linux-x86_64.sh /mnt/c/Users/$USER/Desktop/WSL/Miniconda3-latest-Linux-x86_64.sh
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
sed -i '174s/#//' ~/.jupyter/jupyter_notebook_config.py
sed -i '174s/localhost/*/' ~/.jupyter/jupyter_notebook_config.py
sed -i '220s/#//' ~/.jupyter/jupyter_notebook_config.py
sed -i '220s/True/False/' ~/.jupyter/jupyter_notebook_config.py
sed -i '229s/#//' ~/.jupyter/jupyter_notebook_config.py

# =============================================================================
# 安裝 Jupyter notebook 各種程式語言支援核心
# 參考連結: https://github.com/jupyter/jupyter/wiki/Jupyter-kernels
# =============================================================================
# 2018.06.08 感謝社團法人台灣符式推廣協會陳爽先生與陳厚成先生、先後移植 JeForth 與
# PeForth 至 Jupyter Notebook 環境，讓我們可以自由地進行程式語言教學。

# 預計支援的程式語言核心有:
# 01. python3
# 02. nodejs
# 03. c
# 04. PeForth
# 05. R
# 06. Julia
# 待續...

# =============================================================================
# 安裝 Python3
# 使用 miniconda 環境，避免使用 anaconda 安裝包，軟體容量過大
# 參考連結: https://conda.io/miniconda.html
# 本範例已經使用 miniconda 環境處理
# =============================================================================

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
sudo /home/daniel/miniconda/bin/install_c_kernel

# =============================================================================
# 支援 PeForth 核心
# 參考連結: https://github.com/hcchengithub/peforth
# =============================================================================
# 安裝 PeForth(2018.06.12 PeForth 1.16 版)
pip install peforth

# 建立目錄
mkdir ~/miniconda/share/jupyter/kernels/peforth
# 複製設定檔到 Kernel 目錄
cp /mnt/c/Users/$USER/Desktop/WSL/PeForth/kernel.json ~/miniconda/share/jupyter/kernels/peforth

# =============================================================================
# 支援 R 核心
# 參考連結: https://irkernel.github.io/
# =============================================================================
# 安裝 R 環境
# 加入套件來源
sudo sed -i '$ a\# R Repo' /etc/apt/sources.list
sudo sed -i '$ a\deb http://cran.csie.ntu.edu.tw/bin/linux/ubuntu xenial/' /etc/apt/sources.list
# 加入公鑰
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
# 更新系統與安裝 R 環境
sudo apt-get update
sudo apt-get install -y r-base libcurl4-openssl-dev libxml2-dev
sudo apt-get autoremove

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
# 啟用各種系統指令說明
# 
# =============================================================================
# 啟動 Jupyter Notebook
# 啟動前請記得用 Putty 啟動一個連線，用這個連線執行這樣才能複製登錄的連結
#  http://localhost:8888/?token=5ef6ce3de54bb434d95124475f8aee046cda24f0d9d87f26
# 
# jupyter notebook

# 啟動 R 服務
# 啟用服務器
# Service rstudio-server restart
# 登入測試方式 http://localhost:8787



# =============================================================================
# 安裝其他應用軟體
# 
# =============================================================================
# 安裝 RStudio Server
sudo apt-get -y install gdebi-core 
wget https://download2.rstudio.org/rstudio-server-1.1.453-amd64.deb
sudo gdebi -n rstudio-server-1.1.453-amd64.deb
# 搬移檔案
mv rstudio-server-1.1.453-amd64.deb /mnt/c/Users/$USER/Desktop/WSL/rstudio-server-1.1.453-amd64.deb
# 啟用服務器
# Service rstudio-server restart
# 登入測試方式 http://localhost:8787

# =============================================================================
# nbconvert : Convert Notebooks to other formats
# 參考連結: https://nbconvert.readthedocs.io/en/latest/index.html
# =============================================================================
# 安裝 nbconvert 系統
conda install nbconvert
# 安裝 Pandoc 系統
sudo apt-get install -y pandoc 
# 安裝 TeX 系統
# Linux: TeX Live / OSX: MacTeX / Windows: MikTex
# 裝完約為 1.3GB，請視狀況決定是否安裝
sudo apt-get install -y texlive-xetex





# =============================================================================
# 安裝 R 語言課程範例: Learning R Programming
# 參考連結: https://github.com/PacktPublishing/Learning-R-Programming
# =============================================================================
git clone https://github.com/PacktPublishing/Learning-R-Programming.git




# =============================================================================
# 套件範例: 海龜繪圖
# 參考連結: https://irkernel.github.io/
# =============================================================================
pip install mobilechelonian




# 重啟伺服器。
# sudo reboot