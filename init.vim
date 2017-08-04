call plug#begin('~/.nvim/plugged')

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction


" On-demand loading
Plug 'scrooloose/nerdtree'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'rliang/nvim-pygtk3', {'do': 'make install'}
Plug 'SirVer/ultisnips'
Plug 'morhetz/gruvbox' 
Plug 'pangloss/vim-javascript'
Plug 'honza/vim-snippets'
Plug 'mxw/vim-jsx'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tmhedberg/matchit'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'easymotion/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'jlanzarotta/bufexplorer'
Plug 'bkad/CamelCaseMotion'
Plug 'mlaursen/vim-react-snippets'
Plug 'rodnaph/vim-color-schemes'

" Initialize plugin system
call plug#end()

"let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:jsx_ext_required = 0

let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

set number
autocmd Filetype javascript.jsx setlocal ts=2 sw=2 expandtab
autocmd FileType css setlocal ts=2 sw=2 expandtab
autocmd FileType cpp setlocal ts=4 sw=4 expandtab
autocmd Filetype python setlocal ts=3 sw=3 expandtab

"set background=light
"set hidden 

colo Black

syntax on
hi Visual term=reverse cterm=reverse guibg=Grey
"hi Normal guibg=NONE ctermbg=NONE
set cursorline
"hi CursorLine ctermbg=blue term=bold cterm=bold ctermbg=yellow
highlight CursorLine cterm=bold ctermbg=237 term=bold
hi CursorLineNR cterm=bold ctermbg=237
"highlight CursorLine cterm=bold ctermbg=248 ctermfg=None term=bold


let mapleader = ","

xnoremap p pgvy

vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

"share clipboard
set clipboard=unnamedplus

noremap <Nul> <Esc>
inoremap <Nul> <Esc>
cnoremap <Nul> <C-c>
noremap <C-Space> <Esc>
inoremap <C-Space> <Esc>
cnoremap <C-Space> <C-c>
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

set hlsearch
set incsearch
set ignorecase
set smartcase
set showcmd

nnoremap <F3> :set hlsearch!<CR>
" move splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"ignore ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

"log
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_use_vim_stdout = 0
let g:ycm_server_log_level = 'debug'
let g:ycm_path_to_python_interpreter = '/usr/bin/python'

"share clipboard 
set clipboard=unnamedplus

"snippets

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.

set backupdir=/tmp
set directory=$HOME/.vim/swapfiles/

" hate the d
"vnoremap p "_dp
nnoremap _d "_d
vnoremap _d "_d

nnoremap <C-s> :w<cr>
nnoremap <Space> :
nnoremap <C-O> :NERDTreeToggle<cr>
nnoremap :Q :qa

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

noremap <leader>w :call DeleteTrailingWS()<CR>
set updatetime=250

"nmap <Leader>bb :ls<CR>:buffer<Space>
nmap <Leader>bb :BufExplorerHorizontalSplit<CR>

cnoreabbrev Q qa

set laststatus=2 statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" avoid scrolling when change buffer
" Save current view settings on a per-window, per-buffer basis.
function! AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction

" Restore current view settings.
function! AutoRestoreWinView()
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction

" When switching buffers, preserve window view.
if v:version >= 700
    autocmd BufLeave * call AutoSaveWinView()
    autocmd BufEnter * call AutoRestoreWinView()
endif


" paste
xnoremap p pgvy

"nmap <Leader>bb :ls<CR>:buffer<Space>
nmap <Leader>> gg=G''zz


"camel case motion

map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge

sunmap w
sunmap b
sunmap e
sunmap ge



let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
