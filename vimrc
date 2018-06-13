" ===================================================================
" Vundle 套件管理系統設定與初始化
" ===================================================================
set nocompatible                       " 必要設定
filetype off                           " 必要設定
set rtp+=~/.vim/bundle/Vundle.vim      " 設定套件安裝路徑
call vundle#begin()                    " 開始管理套件
Plugin 'VundleVim/Vundle.vim'          " Vundle Base 套件
" 個人使用的套件放這裡 Start
Plugin 'mattn/emmet-vim'               " emmet 套件
" 個人使用的套件放這裡 End
call vundle#end()                      " 結束套件管理
filetype plugin on                     " 必要設定 
filetype plugin indent on              " 必要設定
" ===================================================================
" 編輯環境設定
" ===================================================================
" ==========
" 配色設定
" ==========
syntax enable                           " 開啟語法顏色支援
set background=dark                     " 設定背景為深色
colorscheme torte                       " 內建配色                   
" colorscheme solarized                 " 需安裝 solarized 
" ==========
" 基本設定
" ========== 
set number                              " 顯示行號
set cmdheight=2                         " 設定狀態列行數
set textwidth=80                        " 每頁最大文字長度
set wrapmargin=80                       " 設定折行長度
set paste                               " 防止剪貼時位置不正確
set ruler                               " 狀態列顯示狀態
set showcmd                             " 在狀態列顯示目前執行指令
set showmode                            " 顯示目前模式
set history=50                          " 命令歷史紀錄檔紀錄長度
set autochdir                           " 自動切換成當前目錄
set t_Co=256                            " 設定終端機顏色為256色
" ==========
" 游標控制
" ==========
set cursorline                         " 高亮度顯示當前列
set cursorcolumn                        " 高亮度顯示當前行
" ==========
" 縮排設定
" ========== 
set autoindent                          " 設定自動縮排
set cindent                             " 設定 C/C++ 縮排
set smartindent                         " 設定智慧型縮排
set expandtab                           " 使用空白來取代 tab
set tabstop=2                           " 自訂縮排長度
set shiftwidth=2                        " 設定移動整行一次移動的寬度
set wrap
" ==========
" 關鍵字搜尋
" ==========
set ignorecase                          " 搜尋時不分大小寫 
set incsearch                           " 加強型搜尋功能
set hlsearch                            " 高亮度顯示搜尋關鍵字

" ============
" 設定鍵盤對應
" ============
" 使用 F2 開啟/關閉行號
nnoremap <F2> :set nonumber!<CR>       
" 使用 tab 鍵來啟動 emmet 自動補齊功能
let g:user_emmet_expandabbr_key='<Tab>'
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
" 這是寫入檔案時置放 EOL(end of line) 的形式
set ffs=unix,dos ff=unix