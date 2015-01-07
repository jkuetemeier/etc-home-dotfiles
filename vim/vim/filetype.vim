" vim resource file for filetypes
" (c) 2014 Jörg Kütemeier <jkuetemeier@jkuetemeier.com>

" inspired by https://github.com/ddellaquila/dd-vim/blob/master/filetypes.vim
"

if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au! BufRead,BufNewFile *.zcml     set filetype=xml
  au! BufRead,BufNewFile *.rst      setfiletype rst
  au! BufRead,BufNewFile *.txt      setfiletype markdown
  au! BufRead,BufNewFile *.md       setfiletype markdown

  au BufNewFile,BufRead,BufEnter *.wiki  setlocal spell  spelllang=de_de
  au BufNewFile,BufRead,BufEnter *.md    setlocal spell  spelllang=de_de
  au BufNewFile,BufRead,BufEnter *.txt   setlocal spell  spelllang=de_de
  au BufNewFile,BufRead,BufEnter README  setlocal spell  spelllang=en_us
  au BufNewFile,BufRead,BufEnter README.md  setlocal spell  spelllang=en_us
augroup END

autocmd FileType html  set tabstop=2|set shiftwidth=2
autocmd FileType xhtml set tabstop=2|set shiftwidth=2
autocmd FileType xml   set tabstop=2|set shiftwidth=2
autocmd FileType py    set tabstop=4|set shiftwidth=4

" source local variant if it exists
if !empty(glob("filetypes.local.vim"))
  source filetypes.local.vim
endif

