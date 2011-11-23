set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set fileformats=unix,dos

set ignorecase

set tabstop=2

set shiftwidth=2

set softtabstop=2

set expandtab

set autoindent

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
let moria_style='dark'
colo moria
"colo slate
set guifont=inconsolata:h14
set tags=./tags;../../../../

" 1
function FindCtagsHere(dir, dir_sep)
      let tag_dir = a:dir
      let sep = a:dir_sep
      while !filereadable(tag_dir.sep."tags") && tag_dir!=$HOME && stridx(tag_dir, sep)>=0
              let tag_dir = substitute(tag_dir, sep.'[^'.sep.']\+$', "", "")
      endwhile
      if filereadable(tag_dir.sep."tags")
              return tag_dir.sep."tags"
      else
              return ''
      endif
endfunction

" 2
au BufReadPost *.cpp    let b:current_file_tags=FindCtagsHere(expand('%:p:h'),'/')
au BufReadPost *.h      let b:current_file_tags=FindCtagsHere(expand('%:p:h'),'/')

" 3
au BufReadPost *        if exists("b:current_file_tags") &&
\       filereadable(b:current_file_tags) &&
\       stridx(&tags, b:current_file_tags)<0 | let &tags.=','.b:current_file_tags | endif

" 4
let x = FindCtagsHere(getcwd(), '/')
if filereadable(x)
       let &tags .= ','.x
endif

autocmd BufNewFile,BufRead *.html set ft=htmldjango

set backupdir=c:/Users/Jeremy/vimbackup
set directory=c:/Users/Jeremy/vimswp

"set list " we do what to show tabs, to ensure we get them 
         " out of my files
"set listchars=tab:>-,trail:- " show tabs and trailing 
set number
set ruler
set smartcase
set foldlevel=100
set autochdir

"call SuperTabSetCompletionType('<C-N>')

au VimResized * exe "normal! \<c-w>="
