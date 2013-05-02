" Basic Setup {{{1
set nocompatible

" vundle {{{
filetype off
set rtp+=~/.vim/vundle/
call vundle#rc()

" Bundle 'gmarik/vundle'

Bundle 'terryma/vim-multiple-cursors'
Bundle 'terryma/vim-expand-region'

" Bundle 'Valloric/YouCompleteMe'
" generate a Makefile
" cd /tmp && cmake -G 'Unix Makefiles' . ~/.vim/bundle/YouCompleteMe/cpp
" build
" make ycm_core

" latest vim
" hg clone https://code.google.com/p/vim/
" cd vim
" ./configure --with-features=huge \
            " --enable-rubyinterp \
            " --enable-pythoninterp \
            " --enable-perlinterp \
            " --enable-gui=gtk2 --enable-cscope --prefix=/usr
" make VIMRUNTIMEDIR=/usr/share/vim/vim73
" ./src/vim

" Bundle 'airblade/vim-gitgutter'

" Bundle 'maxbrunsfeld/vim-yankstack'
" Bundle 'ehamberg/vim-cute-python'

" Bundle 'foldsearch'
Bundle 'jade.vim'
Bundle 'troydm/easybuffer.vim'
" Bundle 'epeli/slimux'

Bundle 'benmills/vimux'
Bundle 'ctrlp.vim'
Bundle 'mru.vim'
Bundle 'vim-stylus'
" Bundle 'UltiSnips'
Bundle 'vim-indent-object'
Bundle 'vimwiki'
Bundle 'Tagbar'
Bundle 'delimitMate.vim'
" Bundle 'VimOutliner'
Bundle 'vimoutliner/vimoutliner'
" Bundle 'Gundo'
" Bundle 'paster.vim'
" Bundle 'bufkill.vim'
Bundle 'vim-coffee-script'
Bundle 'altercation/vim-colors-solarized'
Bundle 'NrrwRgn'
Bundle 'Lokaltog/vim-powerline'
" Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'mattn/zencoding-vim'
Bundle 'godlygeek/tabular.git'
Bundle 'tomtom/tcomment_vim.git'
Bundle 'git://repo.or.cz/vcscommand'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-fugitive'
" Bundle 'tpope/vim-haml'
" Bundle 'tpope/vim-vividchalk'
Bundle 'unimpaired.vim'
Bundle 'speeddating.vim'
Bundle 'ervandew/supertab.git'
" Bundle 'scrooloose/syntastic.git'
Bundle 'VimClojure'
Bundle 'derekwyatt/vim-scala.git'
Bundle 'timcharper/textile.vim'
Bundle 'nginx.vim'
" Bundle 'DrawIt'
" Bundle 'gnupg.vim'
Bundle 'git://gitorious.org/vim-gnupg/vim-gnupg.git'
" Bundle 'jslint.vim'
Bundle 'jceb/vim-orgmode'
" Bundle 'hsitz/VimOrganizer'
Bundle 'klen/python-mode'
Bundle 'pangloss/vim-javascript'
" Bundle 'nathanaelkane/vim-indent-guides'
" Bundle 'gregsexton/gitv'
Bundle 'slimv.vim'
Bundle 'johnhamelink/blade.vim'
" Bundle 'spolu/dwm.vim'
" Bundle 'roman/golden-ratio'
Bundle 'VimIM'
Bundle 'DirDiff.vim'
Bundle 'bufexplorer.zip'
Bundle 'matchit.zip'
" Bundle 'AnsiEsc.vim'

Bundle 'Valloric/MatchTagAlways.git'
Bundle 'AndrewRadev/switch.vim.git'

" Bundle 'quickrun'
" Bundle 'vim-l9'
" Bundle 'vst'

" Bundle 'Lokaltog/vim-easymotion'
" Bundle 'tpope/vim-rails.git'
" Bundle 'FuzzyFinder'
" Bundle 'Align'
" Bundle 'scrooloose/nerdtree.git'
" Bundle 'scrooloose/nerdcommenter'
" Bundle 'Shougo/neocomplcache.git'
" ack
" bexec
" eunuch
" clam
" ragtag
" voom
" vimroom
" fcitx
" css-color
" conque
" yankering

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

set background=dark
colorscheme solarized
" colorscheme vividchalk
" ir_black molokai peaksea tango2 dusk mustang desert wombat lucius fnaqevan

" set colorcolumn=81
" highlight colorcolumn guibg=black

se nohlsearch

" set cindent
set tabstop=3
set shiftwidth=3

set smartindent
set autoindent

autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
set relativenumber

" dispaly position info
set ruler
" dispaly time
set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)

set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" allways show statusline
set laststatus=2

let g:Powerline_symbols = 'fancy'

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

set wildignore=*.swp,*.bak,*.pyc,*.class,*.apk,*.png,*.jpg,*.gif,*.dex,*.swf,*.swc,*.jar,*.ttf,node_modules,build,venv,*.egg-info,cabal-dev

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
" acp {{{
" disable auto start
let g:acp_enableAtStartup = 1
nmap <leader>al :AcpLock<CR>a
nmap <leader>au :AcpUnlock<CR>a

let g:acp_behaviorSnipmateLength=1

" CursorMovedI will make Conque slow
let g:acp_mappingDriven = 1
" complete
" let g:acp_completeOption = '.,w,b,k,t'
" }}}
" arpeggio {{{
" call arpeggio#load()
" Arpeggio inoremap jk <Esc>
" Arpeggio inoremap fh <Esc>
" Arpeggio inoremap hj <Esc>
" Arpeggio inoremap fj <Esc>
" Arpeggio inoremap asdf <Esc>
" }}}
" bexec {{{
let bexec_script_types = ['coffee']
" }}}
" bufexplorer {{{
let g:bufExplorerDetailedHelp=0
" }}}
" calendar {{{
" nnoremap <leader>cl :Calendar<cr>
com! Cal :Calendar
" }}}
" coffee {{{
command -nargs=1 C CoffeeCompile | :<args>
command CM CoffeeMake
" }}}
" coffeetags {{{
" let g:tagbar_type_coffee = {
"   \ 'kinds' : [
"   \   'f:functions',
"   \   'o:object'
"   \ ],
"   \ 'kind2scope' : {
"   \   'f' : 'object',
"   \   'o' : 'object'
"   \},
"   \ 'sro' : ".",
"   \ 'ctagsbin' : 'coffeetags',
"   \ 'ctagsargs' : ' ',
"   \}
" }}}
" commandt {{{
" nnoremap <leader>tt :CommandT<CR>
nnoremap <leader>tc :CommandT %:p:h<CR>
nnoremap <leader>tf :CommandTFlush<CR>:CommandT<CR>
nnoremap <leader>tb :CommandTBuffer<CR>
" }}}
" conque {{{
nnoremap <leader>ba :ConqueTerm bash<CR>
nnoremap <leader>zs :ConqueTerm zsh<CR>
" }}}
" cscope {{{
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" search tag files first
set cscopetagorder=1
" search both tag and db
set cscopetag
" silent
set nocscopeverbose
if filereadable("cscope.out")
    cs add cscope.out .
endif
" reset
set cscopeverbose
" }}}
" ctrlp {{{
let g:ctrlp_working_path_mode = 0
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.so,*.out,*.in,tags
" let g:ctrlp_map = 'F'
" }}}
" dbext {{{
" use pipe2eval mysql
" }}}
" dirdiff{{{
let g:DirDiffExcludes = "CVS,*.class,*.exe,.*.swp,.git,.hg" 
" }}}
" eclim {{{
let g:EclimBrowser = 'firefox'
nmap <Leader>jm :JavaImport<CR>
"}}}
" fuzzyfinder {{{
" let g:fuf_modesDisable = []
" let g:fuf_mrufile_maxItem = 400
" let g:fuf_mrucmd_maxItem = 400
" nnoremap <silent> sj     :FufBuffer<CR>
" nnoremap <silent> sk     :FufFileWithCurrentBufferDir<CR>
" nnoremap <silent> sK     :FufFileWithFullCwd<CR>
" nnoremap <silent> s<C-k> :FufFile<CR>
" nnoremap <silent> sl     :FufCoverageFileChange<CR>
" nnoremap <silent> sL     :FufCoverageFileChange<CR>
" nnoremap <silent> s<C-l> :FufCoverageFileRegister<CR>
" nnoremap <silent> sd     :FufDirWithCurrentBufferDir<CR>
" nnoremap <silent> sD     :FufDirWithFullCwd<CR>
" nnoremap <silent> s<C-d> :FufDir<CR>
" nnoremap <silent> sn     :FufMruFile<CR>
" nnoremap <silent> sN     :FufMruFileInCwd<CR>
" nnoremap <silent> sm     :FufMruCmd<CR>
" nnoremap <silent> su     :FufBookmarkFile<CR>
" nnoremap <silent> s<C-u> :FufBookmarkFileAdd<CR>
" vnoremap <silent> s<C-u> :FufBookmarkFileAddAsSelectedText<CR>
" nnoremap <silent> si     :FufBookmarkDir<CR>
" nnoremap <silent> s<C-i> :FufBookmarkDirAdd<CR>
" nnoremap <silent> st     :FufTag<CR>
" nnoremap <silent> sT     :FufTag!<CR>
" nnoremap <silent> s<C-]> :FufTagWithCursorWord!<CR>
" nnoremap <silent> s,     :FufBufferTag<CR>
" nnoremap <silent> s<     :FufBufferTag!<CR>
" vnoremap <silent> s,     :FufBufferTagWithSelectedText!<CR>
" vnoremap <silent> s<     :FufBufferTagWithSelectedText<CR>
" nnoremap <silent> s}     :FufBufferTagWithCursorWord!<CR>
" nnoremap <silent> s.     :FufBufferTagAll<CR>
" nnoremap <silent> s>     :FufBufferTagAll!<CR>
" vnoremap <silent> s.     :FufBufferTagAllWithSelectedText!<CR>
" vnoremap <silent> s>     :FufBufferTagAllWithSelectedText<CR>
" nnoremap <silent> s]     :FufBufferTagAllWithCursorWord!<CR>
" nnoremap <silent> sg     :FufTaggedFile<CR>
" nnoremap <silent> sG     :FufTaggedFile!<CR>
" nnoremap <silent> so     :FufJumpList<CR>
" nnoremap <silent> sp     :FufChangeList<CR>
" nnoremap <silent> sq     :FufQuickfix<CR>
" nnoremap <silent> sy     :FufLine<CR>
" nnoremap <silent> sh     :FufHelp<CR>
" nnoremap <silent> se     :FufEditDataFile<CR>
" nnoremap <silent> sr     :FufRenewCache<CR>
" }}}
" gundo {{{
nnoremap <leader>uu :GundoToggle<CR>
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
" let g:EasyMotion_mapping_F = 'F'
" }}}
" neocomplcache {{{
" }}}
" nerdtree {{{
" nnoremap <leader>n :NERDTreeToggle<cr>
" nnoremap <leader><leader>n :NERDTreeFind<cr>
" }}}
" minibufexplorer {{{
let g:miniBufExplMapWindowNavVim = 1
" let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
" let g:miniBufExplModSelTarget = 1 
" MiniBufExpl Colors
" hi MBEVisibleActive guifg=#A6DB29 guibg=fg
" hi MBEVisibleChangedActive guifg=#F1266F guibg=fg
" hi MBEVisibleChanged guifg=#F1266F guibg=fg
" hi MBEVisibleNormal guifg=#5DC2D6 guibg=fg
" hi MBEChanged guifg=#CD5907 guibg=fg
" hi MBENormal guifg=#808080 guibg=fg
" }}}
" python mode {{{
let g:pymode_lint_ignore = "W191,E501,W806,E122,E128,E121,W404,E101"
" E101 mixed spaces and tabs, even in string!?
let g:pymode_indent = 0
let g:pymode_lint_checker = "pyflakes"
" }}}
" restart {{{
let g:restart_command = 'Restart'
"}}}
" screen{{{
let g:ScreenImpl = 'Tmux'
" }}}
" showmarks {{{
hi ShowMarksHLl guifg=NONE guibg=NONE gui=NONE ctermfg=white ctermbg=NONE
hi ShowMarksHLu guifg=NONE guibg=NONE gui=NONE ctermfg=DarkBlue ctermbg=NONE
hi ShowMarksHLo guifg=NONE guibg=NONE gui=NONE ctermfg=DarkGray ctermbg=NONE
let g:showmarks_enable=0
nmap <leader>mc :ShowMarksClearMark<CR>
"}}}
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
let g:syntastic_quiet_warnings=1
let g:syntastic_disabled_filetypes = ['tex','coffee','sql','php']

let g:syntastic_mode_map = { 'mode': 'active',
									 \ 'active_filetypes': ['ruby'],
									 \ 'passive_filetypes': ['php'] }
"}}}
" tagbar {{{
nmap <leader>l :TagbarToggle<CR>
let g:tagbar_compact = 1
let g:tagbar_type_php = {
	 \ 'kinds' : [
		  \ 'c:classes',
		  \ 'f:functions',
		  \ 'v:variables:1'
	 \ ]
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
" vimclojure {{{
let vimclojure#WantNaigun = 1
let vimclojure#NailgunClient = "/home/cm/bin/ng"
let vimclojure#SplitPos = "left"
let g:vimclojure#ParenRainbow = 1
"}}}
" vimim {{{
let g:vimim_map='c-bslash'
let g:vimim_map='no-gi'
" let g:vimim_plugin = '~/.vim/plugin'  
" let g:vimim_cloud = -1
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
map <Leader>rq :CloseVimTmuxRunner<CR>
map <Leader>rx :CloseVimTmuxPanes<CR>
map <Leader>rs :InterruptVimTmuxRunner<CR>
map <Leader>rl :RunLastVimTmuxCommand<CR>
map <Leader>ri :InspectVimTmuxRunner<CR>
map <Leader>rp :PromptVimTmuxCommand<CR>

map <Leader>rw :call RunVimTmuxCommand("clear; watchr watch.rb")<CR>
map <Leader>rm :call RunVimTmuxCommand("clear; foreman start")<CR>
vmap <silent> <CR> "vy:call RunVimTmuxCommand(@v, 0)<CR>

let VimuxHeight = "40"
let VimuxOrientation = "h"
let VimuxUseNearestPane = 1
" }}}
" wiki {{{
let g:vimwiki_camel_case = 0
let g:vimwiki_folding=1
" let g:vimwiki_use_mouse = 1
 
" let g:vimwiki_rxEqIn = '\$[^$`]\+\$'
" let g:vimwiki_char_eqin = '\$'

nmap <silent> <leader>stupidmap <Plug>VimwikiNormalizeLinkVisualCR

let vimwiki_path='~/notes/vimwiki/'
let vimwiki_export_path='~/notes/vimwiki-exported/'
let wiki_settings={
\ 'template_path': vimwiki_export_path.'vimwiki-assets/',
\ 'template_default': 'default',
\ 'template_ext': '.html',
\ 'syntax': 'markdown',
\ 'auto_export': 0,
\ 'nested_syntaxes': {
\   'js':'javascript',
\   'python': 'python',
\   'py': 'python',
\   'lisp':'lisp',
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
\   'nginx': 'nginx',
\   'apache': 'apache',
\   'jade': 'jade',
\   'actionscript': 'actionscript',
\   'tex': 'tex',
\   'hs': 'haskell',
\   'xml': 'xml',
\   'monit': 'monit'
\ }}

let wikis=["linux","web","logs","game","projects","nlp","de","geld","cs","misc"]
let g:vimwiki_list = []
for wiki_name in wikis
	let wiki=copy(wiki_settings)
	let wiki.path = vimwiki_path.wiki_name.'/'
	let wiki.path_html = vimwiki_export_path.wiki_name.'/'
	let wiki.diary_index = 'index'
	let wiki.diary_rel_path = 'diary/'
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
let g:user_zen_expandabbr_key='<c-e>'
"}}}
"}}}1
" Key Mappings {{{1

" call yankstack#setup()

imap jj <esc>
" nmap <space> :
nmap <space> za

nmap ; :

" imap ii <esc>

map n nzz
map N Nzz
" imap kk <esc>

" Easier moving in tabs and windows
map <C-J> <C-W>j
" map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k
" map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l
map <C-H> <C-W>h
" map <C-H> <C-W>W
" nmap j gj
" nmap k gk

nnoremap <C-N> <C-W>w
nnoremap <C-P> <C-W>W

" dwm
" let g:dwm_map_keys = 0
" 
" nmap <C-N> <Plug>DWMNew
" nmap <C-C> <Plug>DWMClose
" nmap <C-M> <Plug>DWMFocus
" 
" nmap <C-L> <Plug>DWMGrowMaster
" nmap <C-H> <Plug>DWMShrinkMaster

map ,j <c-w>j
map ,k <c-w>k
map ,l <C-W>l
map ,h <C-W>h

map L :BufExplorer<cr>
" map t :CommandTBuffer<cr>
" map F :CommandT<cr>

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

nmap K :!man <C-R>=expand('<cword>')<CR><CR>

" }}}1
" ft {{{
au BufRead,BufNewFile *.go set ft=go
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
	au BufRead,BufNewFile *.php nm ,rl :!php -r '<C-R>=getline('.')<cr>'<cr>
	au BufRead,BufNewFile *.php nm ,rL :r !php -r '<C-R>=getline('.')<cr>'<cr>
	au BufRead,BufNewFile *.php nm <leader>r :!php <c-r>=expand("%:p")<CR><CR>
	au BufRead,BufNewFile *.php nm <leader>R :r !php <c-r>=expand("%:p")<CR><CR>
	au BufRead,BufNewFile *.php setlocal keywordprg=pman\ -s
	" au FileType php setlocal keywordprg=pman\ -s
	" au FileType php inoremap <buffer> @ $this->
	" au BufRead,BufNewFile *.php vm <leader><space> :!eval-php-dump<CR>
augroup end

au FileType r          vm <buffer> <space> :!pipe2eval r<CR>
au FileType php        vm <buffer> <space> :!pipe2eval php<CR>
au FileType javascript vm <buffer> <space> :!pipe2eval javascript<CR>
au FileType sql        vm <buffer> <space> :!pipe2eval sql<CR>
au FileType mysql      vm <buffer> <space> :!pipe2eval sql<CR>
au FileType vimwiki    vm <buffer> <space> :!pipe2eval bash<CR>
au FileType sh         vm <buffer> <space> :!pipe2eval bash<CR>
au FileType vo_base    vm <buffer> <space> :!pipe2eval bash<CR>
au FileType python     vm <buffer> <space> :!pipe2eval python<CR>
au FileType perl       vm <buffer> <space> :!pipe2eval perl<CR>
au FileType ruby       vm <buffer> <space> :!pipe2eval ruby<CR>
au FileType coffee     vm <buffer> <space> :!pipe2eval coffee<CR>
au FileType go         vm <buffer> <space> :!pipe2eval go<CR>
au FileType markdown   vm <buffer> <space> :!pipe2eval markdown<CR>
au FileType xml        vm <buffer> <space> :!pipe2eval xml<CR>
au FileType pgsql      vm <buffer> <space> :!pipe2eval pgsql<CR>
au FileType json       vm <buffer> <space> :!python -mjson.tool<CR>

au BufRead *.html  vm <buffer> <space> :!html2text<CR>
au BufRead *.mongo vm <buffer> <space> :!pipe2eval mongo<CR>

au FileType vim setlocal fdm=marker
au FileType html,xml setlocal fdm=indent

augroup wiki
	au BufRead,BufNewFile *.wiki nm <leader>vo :Voom vimwiki<CR>
	" au BufRead,BufNewFile *.wiki :call Voom vimwiki<cr>
	" au BufRead,BufNewFile *.wiki set ft=markdown
	au BufRead,BufNewFile *.wiki setl foldlevel=1
augroup end

au BufWritePost *.scss !sass %\:%:t:r.css

" vm \cl :!nc -w 1 localhost 1234<CR>
"| sed 's/clojure.core=> //' 

autocmd BufReadCmd *.doc,*.xls,*.ppt exe ":silent 1,$!gsf-dump %" | setlocal buftype=nofile
" }}}
" Scripts {{{1
" misc {{{
com! Weather :r !cliweather shanghai
com! IP :r !curl --silent ifconfig.me
" }}}
" define {{{
" Dic
" com! -nargs=1 Def :r !sdcv -n <f-args> |
" 	\sed -e 's/\[ color[^>]*>//g'|
" 	\sed -e 's/\]$//g' |
" 	\elinks
com! -nargs=1 Def :r !define <f-args>
nm <leader>df :Def <c-r>=expand("<cword>")<cr><cr>
" }}}
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
" nmap ,grc :e $MYGVIMRC<cr>
nmap ,grc :e .gvimrc<cr>
nmap ,zrc :e $HOME/.zshrc<cr>
nmap ,trc :e $HOME/.tmux.conf<cr>
nmap ,prc :e $HOME/.pentadactylrc<cr>
nmap ,rem :e $HOME/.reminders<cr>
nmap ,arc :e $HOME/.config/awesome/rc.lua<cr>
"}}}
" fetch file {{{
nmap <leader>ge :!wget -c <c-r>=expand("<cfile>")<cr><cr>
nmap <leader>fe :!aria2c -c -s3 <c-r>=expand("<cfile>")<cr><cr>
" }}}
" openfetion {{{
" nmap ;ss :!ss <c-r>=getline('.')<cr><cr>
nmap ,ss :!sslp "<c-r>=getline('.')<cr>"
" }}}
" run current line {{{
nmap ,rl :! <c-r>=getline('.')<cr><cr>
nmap ,rr :echo "<c-r>=getline('.')"<cr>!bash<cr>
nmap ,rL :r !<c-r>=getline('.')<cr><cr>
nmap ,RL :!sudo <c-r>=getline('.')<cr><cr>
"}}}
" run current file {{{
" nmap ,rr :! <c-r>=expand("%:p")<cr><cr>
" nmap ,rR :! chmod +x % && <c-r>=expand("%:p")<cr><cr>
"}}}
" txt2tags {{{
au BufNewFile,BufRead *.t2t set ft=txt2tags
nnoremap <leader>xh :!txt2tags -t html -o ~/web/s/%:t:r.html %<CR>
" nnoremap <leader>xh :!txt2tags -t html -o ~/web/html/%:t:r.html --encoding utf-8 --toc %<CR>
" nnoremap <leader>xh :!txt2tags -t html --toc %<cr>
com! Html2Txt :so ~/.vim/unhtml.vim
" }}}
" decode base64 encoded string {{{
command! -range=% Decode64 :w | <line1>,<line2>delete | let foo = @"
 \| perl -MMIME::Base64 my $foo=VIM::Eval(foo); my ($r, $c)=$curwin->Cursor(); $curbuf->Append($r-1, split '\n', MIME::Base64::decode($foo));

command! -range=% DecodeQP :w | <line1>,<line2>delete | let foo = @"
 \| perl my $foo=VIM::Eval(foo); my ($r, $c)=$curwin->Cursor(); $curbuf->Append($r-1, split '\n', MIME::QuotedPrint::decode_qp($foo));
" }}}
" firefox {{{
" open current file
nnoremap <leader>ff :!firefox <c-r>=expand("%:p" )<cr><cr>
" open current link
nnoremap ,ff :!firefox <c-r>=expand("<cWORD>")<cr><cr>
" google current word
nnoremap ,gg :!firefox 'http://google.com/search?as_q=<c-r>=expand("<cword>")<cr>'<cr>
" nnoremap ,gg :!firefox 'http://google.com.hk/?q=<c-r>=expand("<cword>")<cr>'<cr>
" nnoremap R :RefreshFirefox<cr>

" autocmd BufWriteCmd *.html,*.css :call RefreshFirefox()
com! RefreshFirefox call RefreshFirefox()
function! RefreshFirefox()
	if &modified
		write
	endif
	call NC('localhost',4242,'BrowserReload();repl.quit();')
endfunction

" autocmd BufWriteCmd *.html,*.css :call Refresh_firefox()
function! Refresh_firefox()
  if &modified
    write
    silent !echo  'vimYo = content.window.pageYOffset;
          \ vimXo = content.window.pageXOffset;
          \ BrowserReload();
          \ content.window.scrollTo(vimXo,vimYo);
          \ repl.quit();'  |
          \ nc -w 1 localhost 4242 2>&1 > /dev/null
  endif
endfunction
"}}}
" penta{{{

if (!exists('g:firefox_execute') || empty(g:firefox_execute))
	let g:firefox_execute = 'firefox'
endif
fun! DactylComplete(A, L, P) "{{{
	if (!exists('g:DactylCompleteLoaded'))
		let l:tmp = tempname()
		let l:getListCommands = 'js let hives = modules.commands.allHives;'
					\ .'var names = [];'
					\ .'Array.forEach(hives, function(hive) {'
					\ .' let lists = hive._list;'
					\ .' Array.forEach(lists, function(list) {'
					\ .' names = names.concat(list.names);'
					\ .' });'
					\ .'});'
					\ .'names.sort();'
					\ .'uniqueNames = names.filter(function(elem, pos) names.indexOf(elem) == pos);'
					\ .'names = uniqueNames;'
					\ .'var localFile = Components.classes["@mozilla.org/file/local;1"].createInstance(Components.interfaces.nsILocalFile);'
					\ .'try {'
					\ .printf(' localFile.initWithPath("%s");', l:tmp)
					\ .' if (!localFile.exists() || (!localFile.isDirectory())) {'
					\ .' Components.utils.import("resource://gre/modules/NetUtil.jsm");'
					\ .' Components.utils.import("resource://gre/modules/FileUtils.jsm");'
					\ .' var ostream = FileUtils.openSafeFileOutputStream(localFile);'
					\ .' var converter = Components.classes["@mozilla.org/intl/scriptableunicodeconverter"].createInstance(Components.interfaces.nsIScriptableUnicodeConverter);'
					\ .' converter.charset = "UTF-8";'
					\ .' var istream = converter.convertToInputStream(names.join("\n"));'
					\ .' NetUtil.asyncCopy(istream, ostream, function(status) {'
					\ .' if (!Components.isSuccessCode(status)) {'
					\ .' return;'
					\ .' }'
					\ .' });'
					\ .' } else {'
					\ .' dactyl.echoerr("Unable to save file!");'
					\ .' }'
					\ .'} catch (e) {'
					\ .' dactyl.echoerr("failed!");'
					\ ."}"
		sil call system(printf("%s -pentadactyl-remote \"%s\"", shellescape(g:firefox_execute, 1), escape(l:getListCommands, "\"")))

		try
			let g:DactylCommands = readfile(l:tmp)
			let g:DactylCompleteLoaded = 1
		catch
			echoerr "Completion failed, maybe firefox isn't running."
			return []
		endtry
	endif
	let l:args = g:DactylCommands
	let l:valid_completes = []
	for l:arg in l:args
		if stridx(l:arg, a:A) == 0
			let l:valid_completes += [l:arg]
		endif
	endfor
	return l:valid_completes
endfunction "}}}
" FIXME: :Dactyl echo <></>
" FIXME: let it work on Windows
command! -complete=customlist,DactylComplete -nargs=* Dactyl sil call system(printf("%s -pentadactyl-remote \"%s\"", shellescape(g:firefox_execute, 1), escape(<q-args>, "\"")))

"}}}
" npd {{{
com! -nargs=+ Mp call NC("localhost",6600,<f-args>)
"}}}
" netcat {{{
com! -nargs=+ NC call NC(<f-args>)
function! NC(host,port,cmd)
	execute "!echo ".shellescape(a:cmd)." | nc -c ".shellescape(a:host)." ".shellescape(a:port)." 2>&1 > /dev/null"
endfunction
"}}}
" fold with tab {{{
" setlocal foldmethod=expr
" setlocal foldexpr=(getline(v:lnum)=~'^$')?-1:((indent(v:lnum)<indent(v:lnum+1))?('>'.indent(v:lnum+1)):indent(v:lnum))
" set foldtext=getline(v:foldstart)
" set fillchars=fold:\ "(there's a space after that \)
" highlight Folded ctermfg=DarkGreen ctermbg=Black
" }}}
" template {{{
autocmd BufNewFile * silent! 0r $VIMHOME/template/%:e.tpl
autocmd BufNewFile *.php silent! 0r $VIMHOME/template/php.tpl
" }}}
" markdown {{{
vmap md :!Markdown.pl --html4tags<CR>
" }}}
" dump {{{
nmap <leader>dm vip:w! ~/tmp/buffer/index.html
" }}}
" FocusMode {{{
function! ToggleFocusMode()
  if (&foldcolumn != 12)
    set laststatus=0
    set numberwidth=10
    set foldcolumn=12
    set noruler
    hi FoldColumn ctermbg=none
    hi LineNr ctermfg=0 ctermbg=none
    hi NonText ctermfg=0
  else
    set laststatus=2
    set numberwidth=4
    set foldcolumn=0
    set ruler
    execute 'colorscheme ' . g:colors_name
  endif
endfunc
nnoremap <F1> :call ToggleFocusMode()<cr>
" }}}
" Codeigniter {{{
function! CIEnv()
	" system(shellescape("sed -n '/^[ \t]*define(\'ENV/ p' index.php"))
	let env = system("sed -n ". shellescape('/^[ \t]*define(.*ENV/ s/^.*,\(.*\));$/\1/p'). " index.php")
	echo env
endfunc
com! CIEnv :call CIEnv()
" }}}
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
