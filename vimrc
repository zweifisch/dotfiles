" Basic Setup {{{1
set nocompatible

" vundle {{{
filetype off
set rtp+=~/.vim/vundle/
call vundle#rc()

" Bundle 'gmarik/vundle'

" Bundle 'tpope/vim-vinegar'
" Bundle 'goldfeld/vim-seek'
" Bundle 'mhinz/vim-signify'

Bundle 'ctrlp.vim'
Bundle 'bufexplorer.zip'
" Bundle 'troydm/easybuffer.vim'
Bundle 'vimwiki'
Bundle 'benmills/vimux'
" Bundle 'epeli/slimux'

Bundle 'vim-indent-object'
" Bundle 'terryma/vim-multiple-cursors'
" Bundle 'Valloric/YouCompleteMe'
" Bundle 'maxbrunsfeld/vim-yankstack'
Bundle 'blueyed/vim-colors-solarized'
" Bundle 'mhinz/vim-startify'
" Bundle 'sotte/presenting.vim'
" Bundle 'itchyny/thumbnail.vim'
Bundle 'zweifisch/pipe2eval'

Bundle 'katono/rogue.vim'

" Bundle 'rfc-syntax'
" Bundle 'dag/vim2hs'
Bundle 'lukerandall/haskellmode-vim'
Bundle 'wting/rust.vim'
Bundle 'avakhov/vim-yaml'
" Bundle 'juvenn/mustache.vim'
" Bundle 'jnwhiteh/vim-golang'
Bundle 'fatih/vim-go'
" Bundle 'shawncplus/phpcomplete.vim'
Bundle 'StanAngeloff/php.vim'
" Bundle '2072/PHP-Indenting-for-VIm'
Bundle 'elixir-lang/vim-elixir'
Bundle 'Neurogami/mirah-vim'
Bundle 'lambdatoast/elm.vim'
" Bundle 'jimenezrick/vimerl'
" Bundle 'b4winckler/vim-objc'
Bundle 'digitaltoad/vim-jade'
Bundle 'vim-stylus'
" Bundle 'tpope/vim-markdown'
Bundle 'plasticboy/vim-markdown'
" Bundle 'nelstrom/vim-markdown-folding'
Bundle 'vim-coffee-script'
" Bundle 'tpope/vim-haml'
" Bundle 'klen/python-mode'
" Bundle 'pangloss/vim-javascript'
" Bundle 'johnhamelink/blade.vim'
" Bundle 'jceb/vim-orgmode'
" Bundle 'hsitz/VimOrganizer'

Bundle 'VimClojure'
Bundle 'tpope/vim-fireplace'
Bundle 'tpope/vim-classpath'
Bundle 'guns/vim-clojure-static'
Bundle 'kien/rainbow_parentheses.vim'

" Bundle 'derekwyatt/vim-scala.git'
" Bundle 'timcharper/textile.vim'
Bundle 'nginx.vim'

" Bundle 'tpope/vim-dispatch'
" Bundle 'nelstrom/vim-visual-star-search'

" Bundle 'terryma/vim-expand-region'
" Bundle 'airblade/vim-gitgutter'
" Bundle 'ehamberg/vim-cute-python'
" Bundle 'foldsearch'
" Bundle 'mru.vim'
" Bundle 'SirVer/ultisnips'
Bundle 'Tagbar'
Bundle 'delimitMate.vim'
Bundle 'vimoutliner/vimoutliner'
" Bundle 'Gundo'
" Bundle 'paster.vim'
" Bundle 'bufkill.vim'
Bundle 'NrrwRgn'
" Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'mattn/emmet-vim'
Bundle 'godlygeek/tabular.git'
Bundle 'tomtom/tcomment_vim.git'
" Bundle 'git://repo.or.cz/vcscommand'
" Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-unimpaired'
" Bundle 'tpope/vim-vividchalk'
" Bundle 'speeddating.vim'
Bundle 'ervandew/supertab.git'
Bundle 'scrooloose/syntastic.git'
" Bundle 'DrawIt'
" Bundle 'gnupg.vim'
Bundle 'git://gitorious.org/vim-gnupg/vim-gnupg.git'
" Bundle 'jslint.vim'
" Bundle 'nathanaelkane/vim-indent-guides'
" Bundle 'gregsexton/gitv'
" Bundle 'slimv.vim'
" Bundle 'spolu/dwm.vim'
" Bundle 'roman/golden-ratio'
" Bundle 'VimIM'
" Bundle 'DirDiff.vim'
Bundle 'matchit.zip'
" Bundle 'AnsiEsc.vim'
Bundle 'Valloric/MatchTagAlways.git'
" Bundle 'AndrewRadev/switch.vim.git'
" Bundle 'Lokaltog/vim-easymotion'
" Bundle 'scrooloose/nerdtree.git'
" Bundle 'scrooloose/nerdcommenter'
" ack
" eunuch
" clam
" ragtag
" voom
" vimroom
" fcitx
" css-color
" yankering
Bundle 'jdonaldson/vaxe'

filetype plugin indent on
" }}}
" solarized {{{
let g:solarized_termtrans=0
let g:solarized_menu=0
let g:solarized_underline=0
" }}}
" config {{{
" syntax on
syntax enable

if empty($INSIDE_EMACS)
	set background=dark
	colorscheme solarized
	" Bundle 'Lokaltog/powerline'
	Bundle 'bling/vim-airline'
	" Bundle 'itchyny/lightline.vim'
	" Bundle 'edkolev/tmuxline.vim'
else
	" pass
endif

" colorscheme vividchalk
" ir_black molokai peaksea tango2 dusk mustang desert wombat lucius fnaqevan

" set colorcolumn=81
" highlight colorcolumn guibg=black

se nohlsearch

" set cindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set smartindent
set autoindent

autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
set relativenumber

" dispaly position info
set ruler
" dispaly time
set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)

if empty($INSIDE_EMACS)

	set statusline+=%#warningmsg#
	" set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*
	" allways show statusline
	set laststatus=2

	let g:airline_powerline_fonts = 1
end

" enable loading a buffer in a window that currently has a modified buffer
set hidden

set nowrap

" set backspace free
set backspace=indent,eol,start

set cot+=menuone

set scrolloff=3

" set autochdir

" show partial commands as you type
set showcmd
" set cmdheight=2

set shortmess+=A

" for autocompletion
set wildmode=list:longest,full

set completeopt=longest,menu

set foldenable
set fdm=syntax
" set foldlevelstart=1

" let g:javaScript_fold=1
" let g:perl_fold=1               " Perl
" let g:r_syntax_folding=1        " R
" let g:ruby_fold=1               " Ruby
" let g:sh_fold_enabled=1         " sh
" let g:xml_syntax_folding=1      " XML
" let g:php_folding=1

" set cursorline cursorcolumn
set cursorline

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

set autowrite

set wildignore=*.swp,*.bak,*.pyc,*.class,*.apk,*.png,*.jpg,*.gif,*.dex,*.swf,*.swc,*.jar,*.ttf,node_modules,build,venv,*.egg-info,cabal-dev,vendor,deps,ebin,bower_components

" change the terminal's title
set title

" encoding
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936,big5,iso-8859-1,utf-16

set clipboard=unnamedplus 

set incsearch
set hlsearch

" enable per-directory .vimrc files
set exrc
" disable unsafe commands in local .vimrc files
set secure

" viewport
set splitbelow
set splitright

" How many lines of history to remember.
set history=1000

" Use all the memory needed, for maximum performance.
set maxmemtot=2000000
set maxmem=2000000
set maxmempattern=2000000
"set guioptions=a

set mouse=

" store all swp files in one place
set backupdir=~/.vim_swp,~/tmp,/var/tmp,/tmp
set directory=~/.vim_swp,~/tmp,/var/tmp,/tmp

" Shortcut to rapidly toggle `set list`
nmap <leader>ti :set list!<CR>
" set list

" Use the same symbols as TextMate for tabstops and EOLs
" set listchars=tab:▸\ ,eol:¬
" set listchars=eol:¶
"set list listchars=tab:·\ ,trail:ᚗ,nbsp:•
"set list listchars=tab:·\ ,trail:•,nbsp:•
" set listchars=tab:·\ ,trail:↜,nbsp:•
set listchars=tab:›\ ,trail:·,extends:…,precedes:…

set formatprg=par\ w80

" set noerrorbells
" set visualbell
" set t_vb

set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

let html_number_lines = 1
let g:netrw_liststyle= 1
" }}}

" }}}1
" Plugin Settings {{{1
" bufexplorer {{{
let g:bufExplorerDetailedHelp=0
" }}}
" coffee {{{
command -nargs=1 C CoffeeCompile | :<args>
command CM CoffeeMake
" }}}
" ctrlp {{{
let g:ctrlp_working_path_mode = 0
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.so,*.out,*.in,tags
" }}}
" dirdiff{{{
let g:DirDiffExcludes = "CVS,*.class,*.exe,.*.swp,.git,.hg" 
" }}}
" haskell {{{
let g:haddock_browser="/usr/bin/firefox"
" }}}
" indent-guides {{{
" hi IndentGuidesOdd  ctermbg=black
" hi IndentGuidesEven ctermbg=darkgrey
" }}}
" javascript {{{
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
" }}}
" phpfold {{{
" nmap <F5> <Esc>:EnableFastPHPFolds<Cr>
" nmap <F6> <Esc>:EnablePHPFolds<Cr>
" nmap <F7> <Esc>:DisablePHPFolds<Cr>
" }}}
" latex {{{
" let g:tex_flavor='latex'

" Set your grep program to always generate a file-name.
" set grepprg=grep\ -nH\ $*
" 
" type \ref{fig: and press <C-n> automatically cycle through all the figure labels
" set iskeyword+=:

" let g:texindex='thesis'
" nmap <leader>xi :let g:texindex= input('tex index: ')<CR>
" nmap <leader>xc :echo g:texindex<CR>
" nmap <leader>xs :let g:texindex= expand("%:t:r")<CR>
" nmap <leader>xx :!xelatex -output-directory=output <c-r>=expand(g:texindex)<CR>.tex<CR>
" nmap <leader>xv :!mupdf output/<c-r>=expand(g:texindex)<CR>.pdf<CR>
" nmap <leader>xp :!xelatex -output-directory=output <c-r>=expand(g:texindex)<CR>.tex<CR> \| !mupdf output/<c-r>=expand(g:texindex)<CR>.pdf<CR>
"}}}
" easy motion {{{
" let g:EasyMotion_leader_key = '<Leader>m'
let g:EasyMotion_leader_key = '-'
let g:EasyMotion_mapping_w = ')'
let g:EasyMotion_mapping_b = '('
let g:EasyMotion_mapping_f = 'f'
let g:EasyMotion_mapping_F = 'F'
" }}}
" go {{{
let g:go_auto_type_info = 1
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <Leader>gd <Plug>(go-doc-vertical)
" }}}
" python-mode {{{
let g:pymode_lint_ignore = "W191,E501,W806,E122,E128,E121,W404,W402,W0401,E302,E701"
" E302 two blank line
" E701 multiple statements on one line
" let g:pymode_indent = 0
let g:pymode_lint_checker = "pyflakes"
" let g:pymode_python = 'python3'
let g:pymode_rope_complete_on_dot = 0
" }}}
" rainbow {{{
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
" }}}
" restart {{{
let g:restart_command = 'Restart'
"}}}
" screen{{{
let g:ScreenImpl = 'Tmux'
" }}}
" spell check {{{
nmap <leader>ee <Esc>:setlocal spell spelllang=en<CR>
nmap <leader>dd <Esc>:setlocal spell spelllang=de_20<CR>
nmap <leader>nn <Esc>:setlocal nospell<CR>
"}}}
" supertab {{{
" let g:SuperTabDefaultCompletionType = '<c-x><c-u>'
" let g:SuperTabDefaultCompletionType = '<c-x><c-o>'
" let g:SuperTabLongestHighlight=1
" }}}
" switch {{{
let g:switch_definitions =
    \ [
    \   ['is', 'isnt'],
    \   ['yes', 'no'],
    \   ['on', 'off']
    \ ]
" }}}
" syntastic {{{
let g:syntastic_enable_signs=1
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=1
let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_disabled_filetypes = ['tex', 'coffee', 'sql', 'sh', 'go']

let g:syntastic_mode_map = { 'mode': 'active',
									 \ 'active_filetypes': ['ruby', 'php'],
									 \ 'passive_filetypes': ['sh', 'go', 'javascript']
									 \ }
"}}}
" tagbar {{{
nmap <leader>l :TagbarToggle<CR>
let g:tagbar_compact = 1
let g:tagbar_sort = 0
let g:tagbar_type_php = {
	 \ 'kinds' : [
		  \ 'c:classes',
		  \ 'f:functions',
		  \ 'v:variables:1'
	 \ ]
\ }
let g:tagbar_type_markdown = {
	\ 'ctagstype' : 'markdown',
	\ 'kinds' : [
		\ 'h:headings'
	\ ],
	\ 'sort' : 0,
\ }
let g:tagbar_ctags_bin='/usr/bin/ctags'
"}}}
" taglist {{{
" nmap <leader>l :TlistToggle<CR>
let Tlist_Use_Right_Window=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Enable_Fold_Column=0
let Tlist_Show_One_File=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Compact_Format=1
let tlist_php_settings = 'php;c:class;f:function'
"}}}
" vimim {{{
let g:vimim_map='c-bslash'
let g:vimim_map='no-gi'
" let g:vimim_plugin = '~/.vim/plugin'  
" let g:vimim_cloud = -1
" }}}
" vim-markdown {{{
let g:markdown_github_languages = ['ruby', 'javascript', 'php', 'coffee', 'python']
" }}}
" vimoutline {{{
nmap ,,ht :!otl2html.py % > <c-r>=expand("%:r")<cr>.html<CR>
nmap ,,hT :!otl2html.py % > <c-r>=expand("%:r")<cr>.html && firefox <c-r>=expand("%:r")<cr>.html<CR>
" }}}
" vimroom {{{
" nnoremap <silent> <Leader>rt <Plug>VimroomToggle
nnoremap <silent> <Leader>vr :VimroomToggle<CR>
" }}}
" vimux {{{
nmap <Leader>vc :VimuxPromptCommand<CR>

vmap <silent> <CR> "vy:call VimuxRunCommand(escape(@v, '$`'), 0)<CR>

nmap <silent> <CR> :VimuxInterruptRunner<CR>:VimuxRunLastCommand<CR>

let g:VimuxHeight = "40"
let g:VimuxOrientation = "h"
let g:VimuxUseNearestPane = 1
" }}}
" wiki {{{
let g:vimwiki_camel_case = 0
let g:vimwiki_folding = 'expr'
let g:vimwiki_url_maxsave = 0
" let g:vimwiki_use_mouse = 1

nmap <silent> <leader>stupidmap <Plug>VimwikiNormalizeLinkVisualCR

let vimwiki_path='~/.vimwiki/'
let vimwiki_export_path='~/.vimwiki-exported/'
let wiki_settings={
\ 'template_path': vimwiki_export_path.'vimwiki-assets/',
\ 'template_default': 'default',
\ 'template_ext': '.html',
\ 'syntax': 'markdown',
\ 'auto_export': 0,
\ 'nested_syntaxes': {
\   'js': 'javascript',
\   'javascript': 'javascript',
\   'python': 'python',
\   'py': 'python',
\   'prolog': 'prolog',
\   'lisp': 'lisp',
\   'clojure': 'clojure',
\   'clj': 'clojure',
\   'c++': 'cpp',
\   'ruby': 'ruby',
\   'go': 'go',
\   'html': 'html',
\   'css': 'css',
\   'R': 'r',
\   'coffee': 'coffee',
\   'cs': 'coffee',
\   'java': 'java',
\   'php': 'php',
\   'sql': 'sql',
\   'sh': 'sh',
\   'bash': 'sh',
\   'nginx': 'nginx',
\   'apache': 'apache',
\   'jade': 'jade',
\   'actionscript': 'actionscript',
\   'tex': 'tex',
\   'hs': 'haskell',
\   'xml': 'xml',
\   'yaml': 'yaml',
\   'objc': 'objc',
\   'erl': 'erlang',
\   'ex': 'elixir',
\   'monit': 'monit'
\ }}

let wikis=["wikis"]
let g:vimwiki_list = []
for wiki_name in wikis
	let wiki=copy(wiki_settings)
	let wiki.path = vimwiki_path.wiki_name.'/'
	let wiki.path_html = vimwiki_export_path.wiki_name.'/'
	let wiki.diary_index = 'index'
	let wiki.diary_rel_path = '../diary/'
	call add(g:vimwiki_list, wiki)
endfor


au BufRead,BufNewFile *.wiki map <buffer> ,,cb :VimwikiToggleListItem<cr>

nnoremap <leader>wh :Vimwiki2HTML<CR>
nnoremap <leader>wa :VimwikiAll2HTML<CR>
nnoremap <leader>wb :VimwikiTable<CR>
nnoremap <leader>wg :VimwikiGoto

nnoremap <leader>w{ O{{{<esc>j
nnoremap <leader>w} o}}}<esc>
nnoremap <leader>w[ O{{{<esc>j
nnoremap <leader>w] o}}}<esc>
"}}}
" yankring {{{
nmap <leader>yt :YRShow<CR>
let g:yankring_history_file = '.yankring_history'
"}}}
" zen code {{{
let g:user_emmet_leader_key = '<c-e>'
"}}}
"}}}1
" Key Mappings {{{1

" call yankstack#setup()
imap <c-z> <esc>:stop<cr>

imap jj <esc>
" nmap <space> :
nmap <space> za

nmap ; :

" imap ii <esc>

map n nzz
map N Nzz
" imap kk <esc>

map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-H> <C-W>h
" map <C-H> <C-W>W
" nmap j gj
" nmap k gk

nnoremap <C-N> <C-W>w
nnoremap <C-P> <C-W>W

nmap <leader>f :CtrlP <c-r>=expand('%:p:h')<cr><cr>
nmap <leader>F :CtrlP<cr>
nmap <leader>b :CtrlPBuffer<cr>
nmap <leader>B :CtrlPMRU<cr>

map ,j <c-w>j
map ,k <c-w>k
map ,l <C-W>l
map ,h <C-W>h

map L :BufExplorer<cr>

" map <S-H> gT
" map <S-H> :bp<cr>
map <S-H> :b#<cr>
imap <C-S-H> <esc>:b#<cr>
" map <S-L> :bn<cr>

" nmap - <C-u>
" nmap _ <C-d>

" nnoremap - :Switch<cr>

nmap + <C-a>
nmap - <C-x>

" nmap <C-S-L> :redraw!<cr>

nnoremap Q gqap
vnoremap Q gq

" Go to the middle of the line
nmap gm :exe 'normal '.(virtcol('$')/2).'\|'<CR>

nmap gf :e <cfile><CR>

"Clear all spaces at the end of the line
nmap <Leader>s :%s/\s\+$//g<CR>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$
" noremap p p`[
" Shortcuts
" Change Working Directory to that of the current file
" cmap cwd lcd <c-r>=expand('%:p:h')<cr> <cr>
com! CWD :lcd %:p:h

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null
" cmap ww w !tee % >/dev/null
nmap ,dt a<C-R>=strftime("%Y-%m-%d %H:%M:%S %a")<CR>
nmap ,da a<C-R>=strftime("%Y-%m-%d")<CR>
nmap ,ti a<C-R>=strftime("%H:%M:%S")<CR>

" }}}1
" ft {{{
au BufRead,BufNewFile *.go set ft=go
au BufRead,BufNewFile *.kv set ft=kv
au BufRead,BufNewFile *.as set ft=actionscript
au BufRead,BufNewFile *.ldg,*.ledger set ft=ledger  
au BufRead,BufNewFile *.md set ft=markdown
au BufRead,BufNewFile *.json set ft=json
au BufNewFile,BufRead *.cfdg set ft=cfdg
au BufNewFile,BufRead *.cljs set ft=clojure
au BufNewFile,BufRead *.hx set ft=haxe
au BufNewFile,BufRead *.mongo set ft=javascript
au BufRead,BufNewFile *.rs set ft=rust
au BufRead,BufNewFile *.hist set ft=sh
au BufRead,BufNewFile *.pgsql set ft=pgsql
au BufRead,BufNewFile *.hamlet set ft=hamlet
au BufRead,BufNewFile *.pl set ft=prolog

au BufReadCmd *.epub call zip#Browse(expand("<amatch>"))

" vim -b : edit binary using xxd-format!
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

function! RedirctTest()
  redir => m
  silent w ! ruby
  redir END
  new
  put=m
  set buftype=nofile
  set bufhidden=hide
  setlocal noswapfile
endfunction

" map <leader>jt  <Esc>:%!json_xs -f json -t json-pretty<CR>
au BufRead,BufNewFile *.json setl foldmethod=indent

" au BufRead,BufNewFile *.java javacomplete#AddClassPath('/opt/android-sdk/platforms/android-7/android.jar')
" au BufRead,BufNewFile *.java setlocal omnifunc=javacomplete#Complete

augroup otl
	au FileType vo_base setl foldlevel=0
augroup end

augroup ruby
	au BufRead,BufNewFile capfile setl filetype=ruby
	au BufRead,BufNewFile Capfile setl filetype=ruby
	au BufRead,BufNewFile Ghostfile setl filetype=ruby
	au BufRead,BufNewFile *.rb nm <buffer> <leader>r :!ruby %<cr>
	au BufRead,BufNewFile *.rb nm <buffer> <leader>R :r !ruby %<cr>
augroup end

augroup perl
	au BufRead,BufNewFile *.pl nm <buffer> <leader>r :!perl %<cr>
	au BufRead,BufNewFile *.pl nm <buffer> <leader>R :r !perl %<cr>
augroup end

augroup python
	au BufRead,BufNewFile *.py nm <buffer> <leader>r :!python %<cr>
	au BufRead,BufNewFile *.py nm <buffer> <leader>R :r !python %<cr>
augroup end

augroup coffee
	" au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!
	au BufNewFile,BufReadPost *.coffee setl foldmethod=indent foldnestmax=2
	" au BufNewFile,BufReadPost *.coffee setl fdm=expr fde=getline(v:lnum)=~'[-=]>$'?'>1':getline(v:lnum)=~'^\\s*$'?0:'='
	" au BufNewFile,BufReadPost *.coffee setl fdm=expr fde=getline(v:lnum)=~'[-=]>$'&&indent(v:lnum)<indent(v:lnum+2)?'a1':'s1'
	au BufNewFile,BufReadPost *.coffee vm <buffer> <leader><space> :!coffee -ps<CR>
augroup end

" augroup js 
	" au BufNewFile,BufReadPost *.js :call JavaScriptFold()
" augroup end

function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    set fillchars=fold:\ 
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction

augroup php
	au BufRead,BufNewFile *.php setlocal keywordprg=pman
	au FileType php inoremap <buffer> >> $this->
augroup end

au FileType vim setlocal fdm=marker
au FileType html,xml setlocal fdm=indent

augroup wiki
	au BufRead,BufNewFile *.wiki nm <leader>vo :Voom vimwiki<CR>
	" au BufRead,BufNewFile *.wiki :call Voom vimwiki<cr>
	" au BufRead,BufNewFile *.wiki set ft=markdown
	au BufRead,BufNewFile *.wiki setl foldlevel=1
augroup end

augroup clojure
    au VimEnter *.clj RainbowParenthesesToggle
    au Syntax *.clj RainbowParenthesesLoadRound
    " au Syntax *.clj RainbowParenthesesLoadSquare
    " au Syntax *.clj RainbowParenthesesLoadBraces
augroup end

au BufWritePost *.scss !sass %\:%:t:r.css

" vm \cl :!nc -w 1 localhost 1234<CR>
"| sed 's/clojure.core=> //' 

autocmd BufReadCmd *.doc,*.xls,*.ppt exe ":silent 1,$!gsf-dump %" | setlocal buftype=nofile
" }}}
" Scripts {{{1
" folders and files {{{
nmap ,td :e ~/notes/otl/todo.otl<cr>
nmap ,l :e ~/notes/otl<cr>
" }}}
" scrot {{{
nmap ,sc :!scrot <c-r>=expand("%:t")<cr>.png
" }}}
" rcs {{{
" autocmd bufwritepost .vimrc source $MYVIMRC
nmap ,vrc :e $MYVIMRC<cr>
nmap ,grc :e .gvimrc<cr>
nmap ,zrc :e $HOME/.zshrc<cr>
nmap ,trc :e $HOME/.tmux.conf<cr>
nmap ,prc :e $HOME/.pentadactylrc<cr>
nmap ,rem :e $HOME/.reminders<cr>
nmap ,arc :e $HOME/.config/awesome/rc.lua<cr>
"}}}
" Mysql {{{
function! Mysql()
	let env = system("cat /dev/shm/repl.sql.*")
	echo env
endfunc
com! Mysql :call Mysql()
" }}}
" Ranger {{{
fun! RangerChooser()
	exec "silent !ranger --choosefile=/tmp/chosenfile " . expand("%:p:h")
	if filereadable('/tmp/chosenfile')
		exec 'edit ' . system('cat /tmp/chosenfile')
		call system('rm /tmp/chosenfile')
	endif
	redraw!
endfun
map <leader>rg :call RangerChooser()<CR>
"}}}
"}}}1
