source $VIMRUNTIME/vimrc_example.vim

set langmenu=en_US
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set hls
set is
set cb=unnamed
set gfn=8514oem:h9
set expandtab
set tabstop=4
set shiftwidth=4
set si
inoremap { {}<Left>
inoremap {<CR> {<CR>}<Esc>O
inoremap {{ {
inoremap {} {}

set undodir=D:\vim_backups\undo
set backupdir=D:\vim_backups\backup
set directory=D:\vim_backups\swp

:lcd %:p:h

set belloff=all

winpos 500 55

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=40 columns=100
else
  " This is console Vim.
  if exists("+lines")
    set lines=5
  endif
  if exists("+columns")
    set columns=5
  endif
endif

" :hi LineNr guifg=#6cb519
" :hi Type guifg=#6cb519
" :hi Cursor guifg=#bfbf1b
" :hi Statement guifg=#bfbf1b
" :hi Normal guibg =#e0e0e0
" :hi Visual guibg=#bdbdbd

highlight iCursor guifg=white guibg=#828282
set guicursor+=i:block
set guicursor+=i:ver100
set guicursor+=n:blinkon0

:autocmd BufNewFile *.cpp 0r D:\Program Files\Vim\ClassicTemplate.txt

autocmd filetype cpp nnoremap <F9> :w <bar> !g++ -std=c++17 -DLOCAL -Wall -Wextra -Wconversion -Wshadow -Wno-sign-conversion -D_GLIBCXX_DEBUG -fno-sanitize-recover=undefined -DAC % -o %:r -Wl,--stack,268435456<CR>
autocmd filetype cpp nnoremap <F10> :!%:r<CR>
autocmd filetype cpp nnoremap <C-C> :s/^\(\s*\)/\1\/\/<CR> :s/^\(\s*\)\/\/\/\//\1<CR> $
autocmd filetype cpp nnoremap <f5> :w <bar> !g++ -std=c++17 -O2 -Wall % -o %:r && %:r.exe <cr>
autocmd filetype cpp nnoremap <f6> :w <bar> !make <cr>

nnoremap x "_x
vmap x "_d
nnoremap dd "_dd
nnoremap c "_c

noremap s "_ddko

augroup rungroup
    autocmd!
    autocmd BufRead,BufNewFile *.go nnoremap <F11> :exec '!go run' shellescape(@%, 1)<cr>
    autocmd BufRead,BufNewFile *.py nnoremap <F11> :w <bar> :exec '!python' shellescape(@%, 1)<cr>
augroup END

nnoremap <F2> :%y+ <cr>

nnoremap <C-j> :tabprevious <CR>
nnoremap<C-k> :tabnext <CR>
nnoremap <C-x> :tabclose <CR>


set nu
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set rnu
    autocmd BufLeave,FocusLost,InsertEnter * set nornu
	autocmd BufLeave,FocusLost,InsertEnter * set nu
augroup END

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
