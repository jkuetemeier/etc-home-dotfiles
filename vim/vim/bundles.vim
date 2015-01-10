" Modeline and Notes {
" vim: set sw=2 ts=2 sts=2 et tw=79 fmr={,} fdm=marker:

" vim bundles (plugin) configuration file
" (c) 1998-2015 Joerg Kuetemeier <jk@kuetemeier.net>

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

" }

" Vundle plug-in management {
" ===========================

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

" }

" List of active plug-ins {
" =========================

  " NERDTree - A tree explorer plugin for vim {
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

  " }

  " MatchTag - Vim's MatchParen for HTML tags (HTML editing) {
  " -------------------------------------------------------------
  " https://github.com/gregsexton/MatchTag

    Plugin 'gregsexton/MatchTag'

  " }

  " Tagbar - Vim plugin that displays tags in a window, ordered by scope {
  " -------------------------------------------------------------------------

    " on Mac: brew install ctag
    Plugin 'majutsushi/tagbar'
    nmap <F8> :TagbarToggle<CR>

  " }

  " Airline - lean & mean status/tabline for vim that's light as air {
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

  " }

  " numbers.vim - is a vim plugin for better line numbers {
  " --------------------------------------------------------------

    Plugin 'myusuf3/numbers.vim'

    let g:numbers_exclude = ['unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m', 'tagbar', 'gundo', 'nerdtree', 'Vundle']

  " }

  " neo-snippet plugin contains neocomplcache snippets source {
  " --------------------------------------------------------------

    Plugin 'Shougo/neosnippet.vim'
    Plugin 'Shougo/neosnippet-snippets'

    " Plugin key-mappings.
    imap <leader>.     <Plug>(neosnippet_expand_or_jump)
    smap <leader>.     <Plug>(neosnippet_expand_or_jump)
    xmap <leader>.     <Plug>(neosnippet_expand_target)

    " SuperTab like snippets behavior.
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: "\<TAB>"

    " For snippet_complete marker.
    if has('conceal')
      set conceallevel=2 concealcursor=i
    endif

    " Bootstrap snippets
    Plugin 'chrisgillis/vim-bootstrap3-snippets'

  " }

  " neo-snippet plugin contains neocomplcache snippets source {
  " --------------------------------------------------------------

    " use https://github.com/Shougo/neocomplcache.vim if your vim does not have
    " lua compiled in

    Plugin 'Shougo/neocomplete.vim'

    "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return neocomplete#close_popup() . "\<CR>"
      " For no inserting <CR> key.
      "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()
    " Close popup by <Space>.
    "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

    " For cursor moving in insert mode(Not recommended)
    "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
    "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
    "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
    "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
    " Or set this.
    "let g:neocomplete#enable_cursor_hold_i = 1
    " Or set this.
    "let g:neocomplete#enable_insert_char_pre = 1

    " AutoComplPop like behavior.
    "let g:neocomplete#enable_auto_select = 1

    " Shell like behavior(not recommended).
    "set completeopt+=longest
    "let g:neocomplete#enable_auto_select = 1
    "let g:neocomplete#disable_auto_complete = 1
    "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
    "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

  " }

  " Syntastic - Syntax checking hacks for vim {
  " ----------------------------------------------

    Plugin 'scrooloose/syntastic'

    " This does what it says on the tin. It will check your file on open too, not just on save.
    " You might not want this, so just leave it out if you don't.
    let g:syntastic_check_on_open=1

    " npm install -g jshint

  " }

  " vim-coffee-script - CoffeeScript support for vim {
  " -----------------------------------------------------

    Plugin 'kchmck/vim-coffee-script'

  " }

  " ctrlp.vim - Fuzzy file, buffer, mru, tag, etc finder {
  " ---------------------------------------------------------

    Plugin 'kien/ctrlp.vim'

    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlP'

  " }

  " Fugitive - a Git wrapper so awesome, it should be illegal {
  " --------------------------------------------------------------

    " http://www.vim.org/scripts/script.php?script_id=2975
    Plugin 'tpope/vim-fugitive'

  " }

  " Surround - quoting/parenthesizing made simple {
  " --------------------------------------------------

    " http://www.vim.org/scripts/script.php?script_id=1697
    Plugin 'tpope/vim-surround'

  " }

  " TComment - An extensible & universal comment vim-plugin {
  " that also handles embedded filetypes

    "Plugin 'scrooloose/nerdcommenter'
    Plugin 'tomtom/tcomment_vim'

    " comment and uncomment with <Leader>c
    map <Leader>c <C-_><C-_>

  " }

  " Emmet-vim - expanding abbreviations similar to emmet {
  " ---------------------------------------------------------

    " emmet for vim: http://emmet.io/ http://mattn.github.io/emmet-vim
    Plugin 'mattn/emmet-vim'

  " }

  " GoYo - Zen Editing for vim {
  " -------------------------------

    " Zen Editing
    Plugin 'junegunn/goyo.vim'
    Plugin 'amix/vim-zenroom2'
    nnoremap <silent> <leader>z :Goyo<cr>

  " }

  " Multiple Cursors - True Sublime Text style multiple selections for Vim {
  " ---------------------------------------------------------------------------
  " https://github.com/terryma/vim-multiple-cursors

    Plugin 'terryma/vim-multiple-cursors'

  " }

  " Easy Motion - Vim motion on speed! {
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

  " }

  " JavaScript plug-ins {
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

  " }

  " vim-gitgutter - shows a git diff in the gutter {
  " ---------------------------------------

    Plugin 'airblade/vim-gitgutter'

  " }

" }

" Load local plug-ins {
" =====================

  if filereadable(expand("bundles.local.vim"))
    source bundles.local.vim
  endif

" }

" Vundle END {
" ============

  call vundle#end()
  filetype on

" }
