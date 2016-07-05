" 更新时间：2016-06-28 17:40:12

"nmap <F3> <Esc>:w<CR>
nmap <F3> :vimgrep <cword> %<CR>:copen<CR>
map <F4> <C-w>w
nmap <F8> :qall<CR>
nmap <F11> <C-t>
nmap <F12> <C-]>
:command -nargs=1 S :vimgrep /<args>/ % | :copen

" 定义快捷键的前缀，即 <Leader>
let mapleader=";"

" >>
" 文件类型侦测

" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on

" <<

" >>
" vim 自身（非插件）快捷键

" 定义快捷键到行首和行尾
nmap LB 0
nmap LE $

" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至vim
nmap <Leader>p "+p

" 定义快捷键关闭当前分割窗口
nnoremap <Leader>q :q<CR>
" 定义快捷键强制关闭当前分割窗口
nnoremap <Leader>q! :q!<CR>
" 定义快捷键保存当前窗口内容
nnoremap <Leader>w :w<CR>
" 定义快捷键保存并退出当前窗口
nnoremap <Leader>wq :wq<CR>
" 不做任何保存，直接退出 vim
nnoremap <Leader>Q :qa<CR>
" 不做任何保存，强制退出 vim
nnoremap <Leader>Q! :qa!<CR>
" 定义快捷键保存所有窗口内容
nnoremap <Leader>W :wa<CR>
" 定义快捷键保存所有窗口内容并退出 vim
nnoremap <Leader>WQ :wa<CR>:q<CR>

" 设置快捷键遍历子窗口
" 依次遍历子窗口
nnoremap nw <C-W><C-W>
" 跳转至左方的窗口
nnoremap <Leader>hw <C-W>h
" 跳转至下方的子窗口
nnoremap <Leader>jw <C-W>j
" 跳转至上方的子窗口
nnoremap <Leader>kw <C-W>k
" 跳转至右方的窗口
nnoremap <Leader>lw <C-W>l

" 定义快捷键在结对符之间跳转
nmap <Leader>M %

" <<

" 让配置变更立即生效
"autocmd BufWritePost $MY_VIM_RC source $MY_VIM_RC

" >>
" 其他

" 开启实时搜索功能
set incsearch
set smartcase           " Enable smart-case search

" 搜索时大小写不敏感
set ignorecase
set visualbell          " Use visual bell (no beeping)

" 关闭兼容模式
set nocompatible
set backspace=2         " Make backspace work like most other apps
set backspace=indent,eol,start

" vim 自身命令行模式智能补全
set wildmenu
set lazyredraw          " Redraw only when we need to.

" <<

" >>>>
" 插件安装

" vundle 环境设置
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
" vundle 管理的插件列表必须位于 vundle#begin() 和 vundle#end() 之间
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
"Plugin 'altercation/vim-colors-solarized'
"Plugin 'tomasr/molokai'
"Plugin 'vim-scripts/phd'
Plugin 'Lokaltog/vim-powerline'
"Plugin 'octol/vim-cpp-enhanced-highlight'
"Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'derekwyatt/vim-fswitch'
"Plugin 'kshenoy/vim-signature'
"Plugin 'vim-scripts/BOOKMARKS--Mark-and-Highlight-Full-Lines'
"Plugin 'majutsushi/tagbar'
"Plugin 'vim-scripts/indexer.tar.gz'
"Plugin 'vim-scripts/DfrankUtil'
"Plugin 'vim-scripts/vimprj'
"Plugin 'dyng/ctrlsf.vim'
"Plugin 'terryma/vim-multiple-cursors'
"Plugin 'scrooloose/nerdcommenter'
"Plugin 'vim-scripts/DrawIt'
"Plugin 'SirVer/ultisnips'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'derekwyatt/vim-protodef'
"Plugin 'scrooloose/nerdtree'
Plugin 'fholgado/minibufexpl.vim'
"Plugin 'gcmt/wildfire.vim'
"Plugin 'sjl/gundo.vim'
"Plugin 'Lokaltog/vim-easymotion'
"Plugin 'suan/vim-instant-markdown'
"Plugin 'lilydjwg/fcitx.vim'

Plugin 'vim-scripts/Mark'
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/winmanager'

" 插件列表结束
call vundle#end()
filetype plugin indent on
" <<<<

"==============================
" taglist
"==============================
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1

"==============================
" WinManager
"==============================
nmap <F7> :WMToggle<CR>
let g:winManagerWindowLayout='FileExplorer|TagList'
let g:winManagerWidth=50

"==============================
" cscope
"==============================
if has("cscope")
    " cscopeprg指定了执行cscpoe的命令, 默认是cscope。
    set csprg=/usr/bin/cscope
    " csto决定了|:cstag|执行查找的顺序, 被设置为0, 那么cscope数据将会被优先查找, 假如cscope没有返回匹配项, 然后才会查找tag文件。
    set csto=0
    " 设置cst, 将始终同时查找cscope数据库和tags文件。
    set cst
    " cscopequickfix指定了是否使用quickfix窗口来显示cscope的结果
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    " cscopeverbose
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        :command -nargs=0 C :cs kill 0 | cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb

    set cscopetag
    set cscopeverbose
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>:copen<CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>
    nmap <C-=> :cnext<CR>
    nmap <C--> :cprev<CR>
    "nmap <F12> :cs find g <C-R>=expand("<cword>")<CR><CR>
endif


" 配色方案
set background=dark
"colorscheme default
"colorscheme normal
"colorscheme solarized
colorscheme molokai
"colorscheme phd
set t_Co=256

" >>
" 营造专注气氛

" 禁止光标闪烁
set gcr=a:block-blinkon0

" 禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

" 禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T

" 将外部命令 wmctrl 控制窗口最大化的命令行参数封装成一个 vim 的函数
"fun! ToggleFullscreen()
"    call system('wmctrl -ir ' . v:windowid . ' -b toggle,fullscreen')
"endf
" 全屏开/关快捷键
"map <silent> <F11> :call ToggleFullscreen()<CR>
"" 启动 vim 时自动全屏
"autocmd VimEnter * call ToggleFullscreen()

" <<

" >>
" 辅助信息

" 总是显示状态栏
set laststatus=2

set showcmd             " Show entered commonds in bottom bar
set showmatch           " Highlight matching bracket [{()}]

" 显示光标当前位置
set ruler

" 开启行号显示
set number
"set linebreak          " Break lines at word (requires Wrap lines)
"set showbreak=+++      " Wrap-broken line prefix
"set textwidth=80       " Line wrap (number of cols)

" 高亮显示当前行/列
set cursorline
set cursorcolumn

" 高亮显示搜索结果
set hlsearch

" <<

" >>
" 其他美化

" 设置 gvim 显示字体
set guifont=YaHei\ Consolas\ Hybrid\ 12
"set guifont=Courier_new:h16:b:cDEFAULT
" Refer to http://edyfox.codecarver.org/html/vim_fileencodings_detection.html
set encoding=utf-8      " The internal encoding
set termencoding=utf-8  " The encoding displayed
set fileencoding=utf-8  " The encoding written to file
set fileencodings=ucs-bom,utf-8,cp936,gb18030,gbk,gb2312,big5,euc-jp,euc-kr,latin1

" 禁止折行
"set nowrap

" 设置状态栏主题风格
let g:Powerline_colorscheme='solarized256'

" <<

" >>
" 语法分析

" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on

" <<

" >>
" 缩进

" 自适应不同语言的智能缩进
filetype indent on

" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4
set smarttab            " Enable smart-tabs
set autoindent          " Auto-indent new lines
set cindent
set smartindent         " Enable smart-indent
set formatoptions-=r    " Disable continuation of comments to the next line, :help fo-table
"set paste       " To turn off autoindent when you paste code
"set nopaste     " After you pasted your code, turn off the paste-mode
set pastetoggle=<F2>
"set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<    "Make vim show all white spaces as a character
"set list


" 缩进可视化插件 Indent Guides
" 随 vim 自启动
"let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
"let g:indent_guides_start_level=2
" 色块宽度
"let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
"nmap <silent> <Leader>i <Plug>IndentGuidesToggle

" <<

" >>
" 代码折叠

"set foldenable          " Enable folding
" 启动 vim 时关闭折叠代码
set nofoldenable
" 基于缩进或语法进行代码折叠
"set foldmethod=indent
set foldmethod=syntax
set foldlevelstart=10   " Open most folds by default
set foldnestmax=10      " 10 nested fold max
" <space> open/close folds
nnoremap <space> za

" <<

" >>
" 接口与实现快速切换

" *.cpp 和 *.h 间切换
nmap <silent> <Leader>sw :FSHere<cr>

" <<

" >>
" 代码收藏

" 自定义 vim-signature 快捷键
"let g:SignatureMap = {
"        \ 'Leader'             :  'm',
"        \ 'PlaceNextMark'      :  'm,',
"        \ 'ToggleMarkAtLine'   :  'm.',
"        \ 'PurgeMarksAtLine'   :  'm-',
"        \ 'DeleteMark'         :  'dm',
"        \ 'PurgeMarks'         :  'mda',
"        \ 'PurgeMarkers'       :  'm<BS>',
"        \ 'GotoNextLineAlpha'  :  '']',
"        \ 'GotoPrevLineAlpha'  :  ''[',
"        \ 'GotoNextSpotAlpha'  :  '`]',
"        \ 'GotoPrevSpotAlpha'  :  '`[',
"        \ 'GotoNextLineByPos'  :  ']'',
"        \ 'GotoPrevLineByPos'  :  '['',
"        \ 'GotoNextSpotByPos'  :  'mn',
"        \ 'GotoPrevSpotByPos'  :  'mp',
"        \ 'GotoNextMarker'     :  '[+',
"        \ 'GotoPrevMarker'     :  '[-',
"        \ 'GotoNextMarkerAny'  :  ']=',
"        \ 'GotoPrevMarkerAny'  :  '[=',
"        \ 'ListLocalMarks'     :  'ms',
"        \ 'ListLocalMarkers'   :  'm?'
"        \ }

" <<

" >>
" 标签列表

" 设置 tagbar 子窗口的位置出现在主编辑区的左边
"let tagbar_left=1
" 设置显示／隐藏标签列表子窗口的快捷键。速记：identifier list by tag
"nnoremap <Leader>ilt :TagbarToggle<CR>
" 设置标签子窗口的宽度
"let tagbar_width=32
" tagbar 子窗口中不显示冗余帮助信息
"let g:tagbar_compact=1
" 设置 ctags 对哪些代码标识符生成标签
"let g:tagbar_type_cpp = {
"     \ 'ctagstype' : 'c++',
"     \ 'kinds'     : [
"         \ 'c:classes:0:1',
"         \ 'd:macros:0:1',
"         \ 'e:enumerators:0:0',
"         \ 'f:functions:0:1',
"         \ 'g:enumeration:0:1',
"         \ 'l:local:0:1',
"         \ 'm:members:0:1',
"         \ 'n:namespaces:0:1',
"         \ 'p:functions_prototypes:0:1',
"         \ 's:structs:0:1',
"         \ 't:typedefs:0:1',
"         \ 'u:unions:0:1',
"         \ 'v:global:0:1',
"         \ 'x:external:0:1'
"     \ ],
"     \ 'sro'        : '::',
"     \ 'kind2scope' : {
"         \ 'g' : 'enum',
"         \ 'n' : 'namespace',
"         \ 'c' : 'class',
"         \ 's' : 'struct',
"         \ 'u' : 'union'
"     \ },
"     \ 'scope2kind' : {
"         \ 'enum'      : 'g',
"         \ 'namespace' : 'n',
"         \ 'class'     : 'c',
"         \ 'struct'    : 's',
"         \ 'union'     : 'u'
"     \ }
"\ }

" <<

" >>
" 代码导航

" 基于标签的代码导航

" 设置插件 indexer 调用 ctags 的参数
" 默认 --c++-kinds=+p+l，重新设置为 --c++-kinds=+l+p+x+c+d+e+f+g+m+n+s+t+u+v
" 默认 --fields=+iaS 不满足 YCM 要求，需改为 --fields=+iaSl
"let g:indexer_ctagsCommandLineOptions="--c++-kinds=+l+p+x+c+d+e+f+g+m+n+s+t+u+v --fields=+iaSl --extra=+q"

" 正向遍历同名标签
"nmap <Leader>tn :tnext<CR>
" 反向遍历同名标签
"nmap <Leader>tp :tprevious<CR>

" 基于语义的代码导航

"nnoremap <leader>jc :YcmCompleter GoToDeclaration<CR>
" 只能是 #include 或已打开的文件
"nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>

" <<

" >>
" 查找

" 使用 ctrlsf.vim 插件在工程内全局查找光标所在关键字，设置快捷键。快捷键速记法：search in project
"nnoremap <Leader>sp :CtrlSF<CR>

" <<

" >>
" 内容替换

" 快捷替换
"let g:multi_cursor_next_key='<S-n>'
"let g:multi_cursor_skip_key='<S-k>'

" 精准替换
" 替换函数。参数说明：
" confirm：是否替换前逐一确认
" wholeword：是否整词匹配
" replace：被替换字符串
function! Replace(confirm, wholeword, replace)
    wa
    let flag = ''
    if a:confirm
        let flag .= 'gec'
    else
        let flag .= 'ge'
    endif
    let search = ''
    if a:wholeword
        let search .= '\<' . escape(expand('<cword>'), '/\.*$^~[') . '\>'
    else
        let search .= expand('<cword>')
    endif
    let replace = escape(a:replace, '/\&~')
    execute 'argdo %s/' . search . '/' . replace . '/' . flag . '| update'
endfunction
" 不确认、非整词
nnoremap <Leader>R :call Replace(0, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" 不确认、整词
nnoremap <Leader>rw :call Replace(0, 1, input('Replace '.expand('<cword>').' with: '))<CR>
" 确认、非整词
nnoremap <Leader>rc :call Replace(1, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" 确认、整词
nnoremap <Leader>rcw :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>
nnoremap <Leader>rwc :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>

" <<

" 模板补全
" UltiSnips 的 tab 键与 YCM 冲突，重新设定
"let g:UltiSnipsSnippetDirectories=["mysnippets"]
"let g:UltiSnipsExpandTrigger="<leader><tab>"
"let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
"let g:UltiSnipsJumpBackwardTrigger="<leader><s-tab>"

" >>
" YCM 补全

" YCM 补全菜单配色
" 菜单
"highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5
" 选中项
"highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900

" 补全功能在注释中同样有效
"let g:ycm_complete_in_comments=1

" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
"let g:ycm_confirm_extra_conf=0

" 开启 YCM 标签补全引擎
"let g:ycm_collect_identifiers_from_tags_files=0
"" 引入 C++ 标准库 tags
"set tags+=/data/misc/software/app/vim/stdcpp.tags
"set tags+=/data/misc/software/app/vim/sys.tags

" YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
"inoremap <leader>; <C-x><C-o>

" 补全内容不以分割子窗口形式出现，只显示补全列表
"set completeopt-=preview

" 从第一个键入字符就开始罗列匹配项
"let g:ycm_min_num_of_chars_for_completion=1

" 禁止缓存匹配项，每次都重新生成匹配项
"let g:ycm_cache_omnifunc=0

" 语法关键字补全
"let g:ycm_seed_identifiers_with_syntax=1

" <<

" >>
" 由接口快速生成实现框架

" 成员函数的实现顺序与声明顺序一致
"let g:disable_protodef_sorting=1

" <<

" >>
" 库信息参考

" 启用:Man命令查看各类man信息
"source $VIMRUNTIME/ftplugin/man.vim

" 定义:Man命令查看各类man信息的快捷键
"nmap <Leader>man :Man 3 <cword><CR>

" <<

" >>
" 工程文件浏览

" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
"nmap <Leader>fl :NERDTreeToggle<CR>
" 设置 NERDTree 子窗口宽度
"let NERDTreeWinSize=24
" 设置 NERDTree 子窗口位置
"let NERDTreeWinPos="left"
" 显示隐藏文件
"let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
"let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
"let NERDTreeAutoDeleteBuffer=1

" <<

" >>
" 多文档编辑

let g:miniBufExplMapWindowNavVim=1
let g:miniBufExplMapWindowNavArrows=1
let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplModSelTarget=1
let g:miniBufExplSplitToEdge=0
let g:miniBufExplSplitBelow=0

" 显示/隐藏 MiniBufExplorer 窗口
map <Leader>bl :MBEToggle<cr>

" buffer 切换快捷键
nmap <C-TAB> :MBEbn<CR>
nmap <F9> :MBEbp<CR>
nmap <F10> :MBEbn<CR>
"map <C-Tab> :MBEbn<cr>
"map <C-S-Tab> :MBEbp<cr>

" <<


" >>
" 环境恢复

" 设置环境保存项
"set sessionoptions="blank,globals,localoptions,tabpages,sesdir,folds,help,options,resize,winpos,winsize"

" 保存 undo 历史。必须先行创建 .undo_history/
"set undodir=~/.undo_history/
"set undofile

" 保存快捷键
"map <leader>ss :mksession! my.vim<cr> :wviminfo! my.viminfo<cr>
"map <leader>ss :mksession! my.vim<cr>

" 恢复快捷键
"map <leader>rs :source my.vim<cr> :rviminfo my.viminfo<cr>
"map <leader>rs :source my.vim<cr>

" <<

" 设置快捷键实现一键编译及运行
"nmap <Leader>m :wa<CR> :cd build/<CR> :!rm -rf main<CR> :!cmake CMakeLists.txt<CR>:make<CR><CR> :cw<CR> :cd ..<CR>
"nmap <Leader>g :wa<CR>:cd build/<CR>:!rm -rf main<CR>:!cmake CMakeLists.txt<CR>:make<CR><CR>:cw<CR>:cd ..<CR>:!build/main<CR>

" >>
" 快速选中结对符内的文本

" 快捷键
"map <SPACE> <Plug>(wildfire-fuel)
"vmap <S-SPACE> <Plug>(wildfire-water)

" 适用于哪些结对符
"let g:wildfire_objects = ["i'", 'i"', "i)", "i]", "i}", "i>", "ip"]

" <<

" 调用 gundo 树
"nnoremap <Leader>ud :GundoToggle<CR>
