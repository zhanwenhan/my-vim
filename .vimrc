"""""""""""""""""""""""""""""" Usage """""""""""""""""""""""""""""""""""
"<Leader>11:更改正在编辑的文件的编码方式为utf-8,并将所有tab变为blank;
"<Leader>22:使用astyle或者autopep8进行代码格式优化;
"<Leader>33:打开关闭NERDTree;
"<Leader>44:打开关闭minibufexpl;
"<Leader>55:打开关闭indent guides;
"<Leader>00:打开YCM错误信息窗口;
"<Leader>g:转到定义或声明;
"<Leader>a :转到.h或.cpp文件;
"""""""""""""""""""""""""""""" Usage end """""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""" Vundle """"""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" vim-scripts repos
Plugin 'The-NERD-tree'
""Plugin 'TabBar'

" github repos
Plugin 'Valloric/YouCompleteMe'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'Lokaltog/vim-powerline'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'derekwyatt/vim-fswitch'
" color
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'vim-scripts/phd'

" file repos or git repos


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"""""""""""""""""""""""""""""" Vundle end """"""""""""""""""""""""""""""

"""""""""""""""""""""""""""""" default """""""""""""""""""""""""""""""""
" compatible
set nocompatible    " 不兼容旧vi版本
let mapleader=';'   " 设置前缀键为";"
"
" show
set background=dark
colorscheme molokai " desert,ron,torte 设置配色方案
set number          " 显示行号
set cul             " 光标横线
set cuc             " 光标竖线
set nowrap          " 不要换行
set mps+=<:>        " 让<>可以使用%跳转
set colorcolumn=80  " 右边界宽度
"
" tab space and indent
set expandtab       "输入tab时自动将其转化为空格
set tabstop=4       "tab距离
set shiftwidth=4    "行首tab距离
set softtabstop=4   
set smartindent     "自动缩进
set smarttab        "按一次backspace就删除4个空格"
"
" status line "显示状态栏
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2
set cmdheight=2
"
" search
set incsearch  "增量搜索
set hlsearch   "搜索结果高亮
set ignorecase "搜索忽略大小写
"
" encoding & format
set encoding=utf-8 "设置编码方式为utf-8
set fileencodings=utf-8,gbk,gb2312,gb18030,ucs-bom,cp936,latin1 "让vim按指定的编码顺序进行尝试打开文件
func EncodeFormat()
    set fileencoding=utf-8  "将当前查看的文件编码为utf-8
    retab                   "用blank替换tab
endfunc
noremap <Leader>11 :call EncodeFormat()<CR>
"
" fold code
set foldcolumn=0
set foldmethod=indent 
set foldlevel=3 
set foldenable              " 打开代码折叠
"
" 自动补全
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
func ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunc
"
" other
set showcmd         " 输入的命令显示出来，看的清楚些  "
set helplang=cn     " 帮助语言设置为中文"
set autoread        " 设置当文件被改动时自动载入"
set autowrite       " 自动保存"
set wildmenu        " vim 自身命令行模式智能补全
"set backspace=indent,eol,start  "光标可以自由退格
"
"""""""""""""""""""""""""""""" default end """""""""""""""""""""""""""""

"""""""""""""""""""""""""""""" code format """""""""""""""""""""""""""""
filetype on        " 侦测文件类型
filetype plugin on " 载入文件类型插件
filetype indent on " 为特定文件类型载入相关缩进文件

noremap <Leader>22 :call CodeFormart()<CR>

func CodeFormart()
    exec "w"
    if &filetype == 'c' || &filetype == 'cpp' || &filetype == 'hpp'
        exec "!astyle --style=ansi -a --suffix=none %"
    elseif &filetype == 'py'||&filetype == 'python'
        exec "!autopep8 -i --aggressive %"
    elseif &filetype == 'xml'
        exec "!astyle --style=gnu --suffix=none %"
    else
        exec "normal gg=G"
        return
    endif
    exec "e! %"
endfunc

"""""""""""""""""""""""""""""" code format end """""""""""""""""""""""""

"""""""""""""""""""""""""""""" plugins config """"""""""""""""""""""""""
" NERDTree
"autocmd vimenter * NERDTree        " 启动时直接打开NERDTree
noremap <Leader>33 :NERDTreeToggle<CR>
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=32
" 设置NERDTree子窗口位置
let NERDTreeWinPos="right"
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1


" minibufexpl
" 显示/隐藏 MiniBufExplorer 窗口
map <Leader>44 :MBEToggle<CR>
" buffer 切换快捷键
map <Leader>f :MBEbn<CR>
map <Leader>b :MBEbp<CR>

" YouCompleteMe
let g:ycm_python_binary_path = 'python'
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
noremap <Leader>g :YcmCompleter GoTo<CR>
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 1
" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1
" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
let g:ycm_confirm_extra_conf=0
map <Leader>00 :YcmDiags<CR>

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup=1  " 随 vim 自启动
let g:indent_guides_start_level=2            " 从第二层开始可视化显示缩进
let g:indent_guides_guide_size=1             " 色块宽度
noremap <Leader>55 :IndentGuidesToggle<CR>

" vim-fswitch
map <Leader>a :FSHere<CR>


"""""""""""""""""""""""""""""" plugins config end """"""""""""""""""""""

