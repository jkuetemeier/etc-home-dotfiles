"
" vim bundles (plugin) configuration file
" (c) 1998-2015 Joerg Kuetemeier <jk@kuetemeier.net>
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"     http://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.

" Vundle plug-in management {{{1
" =============================

" Plug-ins are handled by Vundle, the plug-in manager for Vim
" https://github.com/gmarik/Vundle.vim

" vundle needs the vim mode
if &compatible
  set nocompatible
end

" run vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" Let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" ===== }}}1

" List of active plug-ins {{{1
" ============================

" NERDTree - A tree explorer plugin for vim {{{2
" ----------------------------------------------
" https://github.com/scrooloose/nerdtree

Plugin 'scrooloose/nerdtree'

" show hidden files
let NERDTreeShowHidden=1

let NERDTreeCaseSensitiveSort = 1
map <F9> :NERDTreeToggle <CR>

" open NERDTree if no file is given
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" close Vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" --- }}}2

" MatchTag - Vim's MatchParen for HTML tags (HTML editing) {{{2
" -------------------------------------------------------------
" https://github.com/gregsexton/MatchTag

Plugin 'gregsexton/MatchTag'

" --- }}}2

" Tagbar - Vim plugin that displays tags in a window, ordered by scope {{{2
" -------------------------------------------------------------------------

" on Mac: brew install ctag
Plugin 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

" --- }}}2

" Airline - lean & mean status/tabline for vim that's light as air {{{2
" ---------------------------------------------------------------------

Plugin 'bling/vim-airline'

set noshowmode

" find themes at: https://github.com/bling/vim-airline/wiki/Screenshots
let g:airline_theme='hybrid' " works best for hybrid theme
let g:airline_enable_branch=1
let g:airline_powerline_fonts=1
let g:airline_detect_whitespace = 1
let g:airline#extensions#hunks#non_zero_only = 1

let g:airline#extensions#tabline#enabled = 2
" let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_min_count = 2

" --- }}}2

" snipMate.vim - TextMate's snippets features in Vim {{{2
" -------------------------------------------------------

Plugin 'msanders/snipmate.vim'

" --- }}}2

" Syntastic - Syntax checking hacks for vim {{{2
" ----------------------------------------------

Plugin 'scrooloose/syntastic'

" This does what it says on the tin. It will check your file on open too, not just on save.
" You might not want this, so just leave it out if you don't.
let g:syntastic_check_on_open=1

" npm install -g jshint

" }}}2

" vim-coffee-script - CoffeeScript support for vim {{{2
" -----------------------------------------------------

Plugin 'kchmck/vim-coffee-script'

" --- }}}2

" ctrlp.vim - Fuzzy file, buffer, mru, tag, etc finder {{{2
" ---------------------------------------------------------

Plugin 'kien/ctrlp.vim'

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" --- }}}2

" Fugitive - a Git wrapper so awesome, it should be illegal {{{2
" --------------------------------------------------------------

" http://www.vim.org/scripts/script.php?script_id=2975
Plugin 'tpope/vim-fugitive'

" --- }}}2

" Surround - quoting/parenthesizing made simple {{{2
" --------------------------------------------------

" http://www.vim.org/scripts/script.php?script_id=1697
Plugin 'tpope/vim-surround'

" --- }}}2

" NERDCommenter - Vim plugin for intensely orgasmic commenting {{{2
" -----------------------------------------------------------------

Plugin 'scrooloose/nerdcommenter'

" --- }}}2

" Emmet-vim - expanding abbreviations similar to emmet {{{2
" ---------------------------------------------------------

" emmet for vim: http://emmet.io/ http://mattn.github.io/emmet-vim
Plugin 'mattn/emmet-vim'

" --- }}}2

" GoYo - Zen Editing for vim {{{2
" -------------------------------

" Zen Editing
Plugin 'junegunn/goyo.vim'
Plugin 'amix/vim-zenroom2'
nnoremap <silent> <leader>z :Goyo<cr>

" --- }}}2

" Multiple Cursors - True Sublime Text style multiple selections for Vim {{{2
" ---------------------------------------------------------------------------
" https://github.com/terryma/vim-multiple-cursors

Plugin 'terryma/vim-multiple-cursors'

" --- }}}

" Easy Motion - Vim motion on speed! {{{2
" ---------------------------------------

Plugin 'Lokaltog/vim-easymotion'

" Gif config
"map  / <Plug>(easymotion-sn)
"omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)

" --- }}}2

" JavaScript plug-ins {{{2
" ------------------------

" better JavaScript editing
" http://oli.me.uk/2013/06/29/equipping-vim-for-javascript/

Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Raimondi/delimitMate'
" imap <C-c> <CR><Esc>O

" These are the tweaks I apply to YCM's config, you don't need them but they might help.
" YCM gives you popups and splits by default that some people might not like, so these should tidy it up a bit for you.
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview

Plugin 'marijnh/tern_for_vim'




" --- }}}

" vim-gitgutter - shows a git diff in the gutter {{{2
" ---------------------------------------

Plugin 'airblade/vim-gitgutter'

" --- }}}2

" ===== }}}1

" Load local plug-ins {{{1
" ==================

if filereadable(expand("bundles.local.vim"))
  source bundles.local.vim
endif

" ===== }}}1

" Vundle END {{{1
" ===============

call vundle#end()
filetype on

" ===== }}}1
