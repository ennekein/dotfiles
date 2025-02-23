scriptencoding utf-8
set encoding=utf-8
set nocompatible                   " be iMproved
set runtimepath=~/.vim,$VIMRUNTIME " or else windows uses $HOME/vimfiles

" ====================================
" First time load, install plugins
" ====================================
if empty(glob("~/.vim/autoload/plug.vim"))
    if executable('git')
        execute('!mkdir -p ~/.vim/{autoload,undo,swap} && curl -sfLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim && vim +PlugInstall +qall')
    else
        echom "Please install git to allow plugin configuration through vim-plug"
    endif
endif

" ====================================
" Plugin Management with vim-plug
" ====================================
call plug#begin()

" Appearance: colors, status bar, icons
Plug 'chriskempson/base16-vim'          "
Plug 'altercation/vim-colors-solarized' " precision colorscheme for the vim text editor 
Plug 'vim-airline/vim-airline'          " lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline-themes'   " A collection of themes for vim-airline
Plug 'kshenoy/vim-signature'            " Plugin to toggle, display and navigate marks
Plug 'Xuyuanp/nerdtree-git-plugin',     " A plugin of NERDTree showing git status
Plug 'ryanoasis/vim-devicons'           " Adds file type glyphs/icons to popular Vim plugins: NERDTree, vim-airline
Plug 'Yggdroot/indentLine'              " A vim plugin to display the indention levels with thin vertical lines
Plug 'junegunn/limelight.vim'           " 🔦 All the world's indeed a stage and we are merely players
Plug 'junegunn/goyo.vim'                " 🌷 Distraction-free writing in Vimm
Plug 'junegunn/seoul256.vim'            " 🌳 Low-contrast Vim color scheme based on Seoul Colors


" Coding: tags, git, C\C++
Plug 'tpope/vim-fugitive'               " a Git wrapper so awesome, it should be illegal
Plug 'sheerun/vim-polyglot'             " A collection of language packs for Vim
Plug 'majutsushi/tagbar'                " Vim plugin that displays tags in a window, ordered by scope 
Plug 'ajh17/VimCompletesMe'             " You don't Complete Me; Vim Completes Me! A super simple, super minimal, super light-weight tab completion plugin for Vim.  

" Fuzy search: buffers, files, tags
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " A command-line fuzzy finder
Plug 'junegunn/fzf.vim'                                           " fzf ❤️ vim, vim key bindings

" File browsing
Plug 'scrooloose/nerdtree',            " File explorer

" Persistent sessions
Plug 'tpope/vim-obsession'              " continuously updated session files 

" Keybinding 
Plug 'vim-scripts/DrawIt'               " Ascii drawing plugin: lines, ellipses, arrows, fills, and more! 
Plug 'tpope/vim-surround'               " quoting/parenthesizing made simple 
Plug 'tpope/vim-repeat'                 " enable repeating supported plugin maps with '.'
Plug 'tpope/vim-commentary'             " comment stuff out, Use gcc to comment out a line 
Plug 'christoomey/vim-tmux-navigator'   " Seamless navigation between tmux panes and vim splits
Plug 'vim-utils/vim-husk'               " Mappings that boost vim command line mode.
Plug 'easymotion/vim-easymotion'

call plug#end()


" ====================================
" vim Configuration
" ====================================
" Basic config: line numbers, no line wrap, highlight incremental search,
" remap escape key. Quick config if no .vimrc:
" colo desert |set nu|set nowrap|set hls|set is|inoremap jk <esc>
" With 4 space tabs:
" colo desert |set nu|set et|set ts=4|set sw=4|set ci|set ai|set nowrap|set hls|set is|inoremap jk <esc>
set nu
set nowrap
set hlsearch
set incsearch
inoremap jk <esc> 

" Identation
set expandtab
set tabstop=4
set shiftwidth=4
set cindent
set autoindent
filetype indent on

autocmd FileType make set noexpandtab
autocmd BufRead,BufNewFile   *.html,*.php,*.yaml setl sw=2 sts=2 et foldmethod=indent
autocmd BufRead,BufNewFile   *.c,*.cpp,*.h setl sw=4 sts=4 et

" add #! to new scripts: https://vim.fandom.com/wiki/Shebang_line_automatically_generated
augroup Shebang
  autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl>\<nl>\"|$
  autocmd BufNewFile *.sh 0put =\"#!/usr/bin/env bash\<nl>\<nl>\"|$
augroup END

" color theme
syntax enable
set background=dark
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
else
    try
        colorscheme seoul256
        let g:airline_theme='zenburn'
    catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme desert
    endtry
endif

if &term =~ '256color'
    " disable Background Color Erase (BCE)
    set t_ut=
endif

" Indicates a fast terminal connection.  More characters will be sent to the
" screen for redrawing
set ttyfast

" End-of-line options
set fileformats=unix,dos

" struct member autocomple, c only
set omnifunc=ccomplete#Complete

" Show more information while completing tags.
set showfulltag

" Add /usr/include tags to the tag search
set tags+=/usr/include/tags

" Always show status line
set laststatus=2

" mode is shown in the status line
set noshowmode

" Shows the number of chars/lines selected in visualmode
set showcmd

" Open splits more naturally
set splitright

" Show invisible chars (eol, tabs, trailing space)
"set list
set listchars=eol:$,tab:▸-,trail:·,extends:↷,precedes:↶,nbsp:•

" Use an undo file and set a directory to store the undo history
set undofile
set undodir=~/.vim/undo/

" put swap files in common dir
set backupdir=~/.vim/swap//,.,/tmp
set directory=~/.vim/swap//,.,/tmp

" automatically create folds, open all folds
set foldmethod=indent
set foldlevelstart=99

" any buffer can be hidden (keeping its changes) without first writing the 
" buffer to a file. This affects all commands and all buffers.
set hidden

" When you type the first tab hit will complete as much as possible, the 
" second tab hit will provide a list, the third and subsequent tabs will cycle 
" through completion options so you can complete the file without further keys
set wildmode=longest,list,full
set wildmenu

" Configs for vimdiff
if &diff
    set diffopt+=iwhite             " Ignore whitespace in vimdiff
endif

"  highlight the current line in every window and update the highlight as the
"  cursor moves.
"set cursorline

" Let cursor move past the last char in <C-v> mode
set virtualedit=block

" Keep 10 lines above and below the cursor
set scrolloff=10

" Mouse all
set mouse=a

" Gvim options
if has("gui_running")
    set go=
    colorscheme solarized
    try
        if has('gui_win32')
            set guifont=DejaVuSansMonoForPowerline_NF:h10:cANSI 
        else
            set guifont=Inconsolata-dz\ for\ Powerline\ Medium\ 10
        endif
    catch /^Vim\%((\a\+)\)\=:E596/
        echom "The Inconsolata-dz_for_Powerline font is not installed"
    endtry
endif

" To disable beeping
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif
    

" ====================================
" Plugin Configuration
" ====================================

" vim-airline
" ------------
"  " don't count trailing whitespace since it lags in huge files
"let g:airline#extensions#whitespace#enabled = 0
 " put a buffer list at the top
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#obsession#indicator_text = ''

"special characters
let DISABLE_POWERLINE_FONT=$DISABLE_POWERLINE_FONT 
if DISABLE_POWERLINE_FONT == '1' 
    " use when a powerline font is not installed, define empty  powerline symbols
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
else
    let g:airline_powerline_fonts = 1 " needs https://github.com/powerline/fonts
endif


" NERDTree
" ------------
"autocmd VimEnter * NERDTreeFind
"autocmd VimEnter * wincmd p
augroup nerd_loader
    autocmd!
    autocmd VimEnter * silent! autocmd! FileExplorer
    autocmd BufEnter,BufNew *
                \  if isdirectory(expand('<amatch>'))
                \|   call plug#load('nerdtree')
                \|   execute 'autocmd! nerd_loader'
                \| endif
augroup END
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
let NERDTreeShowHidden=1


" Tagbar
" ------------
"autocmd VimEnter * nested :call tagbar#autoopen(1)



" GenTags
" ------------
let g:gen_tags#statusline=1
 

" fzf
" ------------
" git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({ 'dir': systemlist('git rev-parse --show-toplevel')[0] }), <bang>0)

" Augmenting Ag command using fzf#vim#with_preview function
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
  


" indentLine
" -----------
let g:indentLine_char = '┊'


" Goyo
" -----------
function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowcmd
  set scrolloff=999
  Limelight
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showcmd
  set scrolloff=10
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()



" ====================================
" Key Maps
" ====================================
" Toggle line numbers and special characters with <F3>
noremap <F3> :set nu!<CR>:IndentLinesToggle<CR>
inoremap <F3> <C-o>:set nu!<CR>:IndentLinesToggle<CR>

" Toggle paste mode
set pastetoggle=<F2>

" remap leader
let mapleader = "\<Space>"

" switch back to last buffer
cmap bb b#

" Tagbar
nnoremap <leader>t :TagbarToggle<CR>

" FZF
nnoremap <leader>g :GGrep<CR>
nnoremap <leader>e :Files<CR>
nnoremap <leader>d :call fzf#vim#tags(expand('<cword>'), {'options': '--exact --select-1 --exit-0'})<CR>
nnoremap <leader>b :Buffers<CR>

function! SearchGoogleW3m(str,extra)
    let l:sCmd="w3m -M www.google.com/search\\?q=".UrlEncode(a:str).a:extra
    "echom l:sCmd
    execute "!" . l:sCmd
endfunction
vnoremap <leader>s :call SearchGoogleW3m(GetVisualSelection(), "")<CR>

" Goyo
nnoremap <leader>o :Goyo 85%<CR>


" ====================================
" Funcitons, could be plugins...
" ====================================
" from http://stackoverflow.com/a/6271254
function! GetVisualSelection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

"from http://www.danielbigham.ca/cgi-bin/document.pl?mode=Display&DocumentID=1053
" URL encode a string. ie. Percent-encode characters as necessary.
function! UrlEncode(string)

    let result = ""

    let characters = split(a:string, '.\zs')
    for character in characters
        if character == " "
            let result = result . "+"
        elseif CharacterRequiresUrlEncoding(character)
            let i = 0
            while i < strlen(character)
                let byte = strpart(character, i, 1)
                let decimal = char2nr(byte)
                let result = result . "\\\\%" . printf("%02x", decimal)
                let i += 1
            endwhile
        else
            let result = result . character
        endif
    endfor

    return result

endfunction

" Returns 1 if the given character should be percent-encoded in a URL encoded
" string.
function! CharacterRequiresUrlEncoding(character)

    let ascii_code = char2nr(a:character)
    if ascii_code >= 48 && ascii_code <= 57
        return 0
    elseif ascii_code >= 65 && ascii_code <= 90
        return 0
    elseif ascii_code >= 97 && ascii_code <= 122
        return 0
    elseif a:character == "-" || a:character == "_" || a:character == "." || a:character == "~"
        return 0
    endif

    return 1

endfunction


" https://stackoverflow.com/a/26314537
let g:rnd = localtime() % 0x10000
function! Random(n) abort
  let g:rnd = (g:rnd * 31421 + 6927) % 0x10000
  return g:rnd * a:n / 0x10000
endfunction

function! RebuildCtags()
    echo "Regenerating tags..."
    execute "!rm -f tags cscope"
    execute "!ctags -R --totals=yes --exclude=.git --exclude=*/obj/* --python-kinds=-i --c++-kinds=+p --fields=+iaS --extras=+q"
    execute "!cscope -R ."
endfunction
noremap <leader>c :call RebuildCtags()<CR>


" Use cscope with FZF inspired by https://gist.github.com/amitab/cd051f1ea23c588109c6cfcb7d1d5776
" -----------
function! Cscope(option, query)
  let color = '{ x = $1; $1 = ""; z = $3; $3 = ""; printf "\033[34m%s\033[0m:\033[31m%s\033[0m\011\033[37m%s\033[0m\n", x,z,$0; }'
  let opts = {
  \ 'source':  "cscope -dL" . a:option . " " . a:query . " | awk '" . color . "'",
  \ 'options': ['--ansi', '--multi', '--bind', 'alt-a:select-all,alt-d:deselect-all',
  \             '--color', 'fg:188,fg+:222,bg+:#3a3a3a,hl+:104'],
  \ 'down': '40%'
  \ }
  function! opts.sink(lines) 
    let data = split(a:lines)
    let file = split(data[0], ":")
    execute 'e ' . '+' . file[1] . ' ' . file[0]
  endfunction
  call fzf#run(opts)
endfunction

function! CscopeChoice(query)
  let opts = {
  \ 'source':  [
  \  '9: Find assignments to this symbol:'.a:query,
  \  '8: Find files #including this file:'.a:query,
  \  '7: Find this file:'.a:query,
  \  '6: Find this egrep pattern:'.a:query,
  \  '3: Find functions calling this function:'.a:query,
  \  '4: Find this text string:'.a:query,
  \  '2: Find functions called by this function:'.a:query,
  \  '1: Find this global definition:'.a:query,
  \  '0: Find this C symbol: '.a:query],
  \ 'down': '40%'
  \ }
  function! opts.sink(lines) 
    let data = split(a:lines, ":")
    call Cscope(data[0], data[2])
  endfunction
  call fzf#run(opts)
endfunction
nnoremap <silent> <C-]> :call CscopeChoice(expand('<cword>'))<CR>

