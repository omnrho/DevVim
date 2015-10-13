"""""""""""""""""""""""""""""""
" basic  setting
""""""""""""""""""""""""""""""
set nu
set bg=dark
set incsearch
set hls
set tabstop=4 
set shiftwidth=4 
"set mouse=nv 
set ic
set noswf
"set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)
let mapleader = ","
filetype on 
filetype plugin on
au FileType c,cpp setlocal comments-=:// comments+=f://
au FileType c,cpp set expandtab 
nmap <C-]> g<C-]>
 
"""""""""""""""""""""""""""""""
" function key  setting
""""""""""""""""""""""""""""""
nmap <F2> :NERDTreeToggle<CR>
nmap <F3> :TagbarToggle<CR>
nmap <F4> :MarksBrowser<cr> 
map  <F6> :Tlist<CR>
nmap <F7> :MBEToggleAll<CR>
nmap <F8> :e ~/.vimrc<CR>
nmap <F9> :source ~/.vimrc<CR>
nmap <F10> :set tags+=${TOPDIR}/TAGDIR/kernel/tags<CR>:cs add ${TOPDIR}/TAGDIR/kernel/cscope.out<CR>
nmap <F11> :set tags+=${TOPDIR}/TAGDIR/mapps/tags<CR>:cs add ${TOPDIR}/TAGDIR/mapps/cscope.out<CR>
nmap <F12> :!~/.vim/scripts/uptags<CR><CR>:set tags+=${PWD}/TAGDIR/tags<CR>:cs add ${PWD}/TAGDIR/cscope.out<CR>

"""""""""""""""""""""""""""""""
" tagbar  setting
""""""""""""""""""""""""""""""
let g:tagbar_width = 40
let g:tagbar_expand = 1

"""""""""""""""""""""""""""""""
" taglist  setting
""""""""""""""""""""""""""""""
"let Tlist_Ctags_Cmd = 'ctags'
"let Tlist_Show_One_File = 1
"let Tlist_Exit_OnlyWindow = 1
"let Tlist_Use_Right_Window = 1

"""""""""""""""""""""""""""""""
" minibufexpl  setting
""""""""""""""""""""""""""""""
" MiniBufExpl Colors
"hi MBENormal               guifg=#808080 guibg=fg
"hi MBEChanged              guifg=#CD5907 guibg=fg
"hi MBEVisibleNormal        guifg=#5DC2D6 guibg=fg
"hi MBEVisibleChanged       guifg=#F1266F guibg=fg
"hi MBEVisibleActiveNormal  guifg=#A6DB29 guibg=fg
"hi MBEVisibleActiveChanged guifg=#F1266F guibg=fg
 
"""""""""""""""""""""""""""""""
" ctrlp setting
"""""""""""""""""""""""""""""""
let g:ctrlp_by_filename = 1
let g:ctrlp_max_files = 0
let g:ctrlp_max_height = 20
"let g:ctrlp_max_files = 60000
"let g:ctrlp_working_path_mode = 'cr'
"let g:ctrlp_user_command = 'find %s -name "*.c" -o -name "*.h" -o -name "*.cpp"'
let g:ctrlp_user_command = 'find %s -type f | grep -v "\.[k]*o$"'
let g:ctrlp_cmd = 'CtrlP ./'
let g:ctrlp_match_func = {}

"""""""""""""""""""""""""""""""
" showmarks setting
""""""""""""""""""""""""""""""
" Enable ShowMarks
let showmarks_enable = 1
" Show which marks
let showmarks_include ="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
"let showmarks_include ="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
" Ignore help, quickfix, non-modifiable buffers
let showmarks_ignore_type = "hqm"
" Hilight lower & upper marks
let showmarks_hlline_lower = 1
let showmarks_hlline_upper = 1 
" For showmarks plugin
hi ShowMarksHLl ctermbg=Yellow   ctermfg=Black  guibg=#FFDB72    guifg=Black
hi ShowMarksHLu ctermbg=Magenta  ctermfg=Black  guibg=#FFB3FF    guifg=Black 

"""""""""""""""""""""""""""""""
" cscope setting
"""""""""""""""""""""""""""""""
if has("cscope")
  set csto=1
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
  endif
  set csverb
endif
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>

"""""""""""""""""""""""""""""""
