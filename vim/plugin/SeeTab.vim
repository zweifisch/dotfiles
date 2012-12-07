" SeeTab:	displays a bar for each tab
"  Author:	Charles E. Campbell, Jr.
"  Date:	Jun 05, 2008
"  Version:	4b	ASTRO-ONLY
"
" GetLatestVimScripts: :AutoInstall: 628 1 SeeTab.vim
"  Usage:  :SeeTab    (toggles tab-bars)  {{{1
"
"  Variables:
"     g:SeeTab(CTerm|GUI)FG : nominal foreground color
"     g:SeeTab(CTerm|GUI)BG : nominal background color
"                             defaults are magenta and black, or vice
"                             versa, depending on 'background'

" allow user to bypass loading, also implements only-load-once
"
" GetLatestVimScripts: 628 1 :AutoInstall: SeeTab.vim

" ---------------------------------------------------------------------
" Load Once: {{{1
if exists("g:loaded_SeeTab")
 finish
endif
let s:keepcpo      = &cpo
let g:loaded_SeeTab= "v4b"

" ---------------------------------------------------------------------
" Highlighting Overrides: {{{1
"  user may override either or both of these colors in his/her <.vimrc>
if &bg == "dark"
 if !exists("g:SeeTabCtermFG")
  let g:SeeTabCtermFG="magenta"
 endif
 if !exists("g:SeeTabCtermBG")
  let g:SeeTabCtermBG="black"
 endif
 if !exists("g:SeeTabGuiFG")
  let g:SeeTabGuiFG="magenta"
 endif
 if !exists("g:SeeTabGuiBG")
  let g:SeeTabGuiBG="black"
 endif
else
 if !exists("g:SeeTabCtermFG")
  let g:SeeTabCtermFG="black"
 endif
 if !exists("g:SeeTabCtermBG")
  let g:SeeTabCtermBG="magenta"
 endif
 if !exists("g:SeeTabGuiFG")
  let g:SeeTabGuiFG="black"
 endif
 if !exists("g:SeeTabGuiBG")
  let g:SeeTabGuiBG="magenta"
 endif
endif

" ---------------------------------------------------------------------
" Public Interface: {{{1
com! -nargs=0 -bang SeeTab :call <SID>SeeTab(<bang>0)

" ---------------------------------------------------------------------
" SeeTab: toggles between showing tabs and using standard listchars {{{1
fun! s:SeeTab(doallwin)
"  call Dfunc("SeeTab(a:doallwin=".a:doallwin.")")
  if a:doallwin
   windo call s:SeeTab(0)
"   call Dret("SeeTab")
   return
  endif

  let SeeTab_sfx="_".bufnr('%')
  if !exists("s:SeeTabEnabled".SeeTab_sfx)
   " -----------------------
   " Make tab bar(s) visible
   " -----------------------
"   call Decho("make tab bars visible (et=".&et.")")
   let s:SeeTabEnabled{SeeTab_sfx}= 1

   " record original SpecialKey, change SpecialKey
   if !exists("s:SeeTabSpecialKey")
    let regA= @a
    redir @a
     silent! hi SpecialKey
    redir END
    let s:SeeTabSpecialKey             = @a
    let @a                             = regA
    let s:SeeTab_listchars{SeeTab_sfx} = &listchars
   endif
   hi clear SpecialKey

   " record original list option
   let s:SeeTab_list{SeeTab_sfx}   = &list
   let s:SeeTab_syntax{SeeTab_sfx} = &syntax

   if &et
	let s:SeeTab_ft{SeeTab_sfx} = &ft
    syn clear
    syn match SeeTabMatch   /^\s\+/ contains=SeeTabBar
    let tsm1= &ts - 1
    exe 'syn match SeeTabBar        /  \{'.tsm1.'}/hs=s,he=s+1 contained'
    hi link SeeTabBar SpecialKey
"    call Decho('et: exe silent! hi SpecialKey ctermfg='.g:SeeTabCtermBG.' ctermbg='.g:SeeTabCtermFG.' guifg='.g:SeeTabGuiBG.' guibg='.g:SeeTabGuiFG)
    exe 'silent! hi SpecialKey ctermfg='.g:SeeTabCtermBG.' ctermbg='.g:SeeTabCtermFG.' guifg='.g:SeeTabGuiBG.' guibg='.g:SeeTabGuiFG
   else
    " note that list uses SpecialKey highlighting
    let s:SeeTab_list{SeeTab_sfx}      = &list
    let s:SeeTab_listchars{SeeTab_sfx} = &listchars
    setlocal list
    setlocal listchars=tab:\|\ 
    exe 'silent! hi SpecialKey ctermfg='.g:SeeTabCtermFG.' ctermbg='.g:SeeTabCtermBG.' guifg='.g:SeeTabGuiFG.' guibg='.g:SeeTabGuiBG
   endif

  else
"   call Decho("remove tab bars from display")
   " -------------------------
   " restore display to normal
   " -------------------------
"   call Decho("restore display to normal")
   silent! exe "hi ".substitute(s:SeeTabSpecialKey,'xxx','','e')
   if &et
	silent! syn clear SeeTabMatch SeeTabBar
	if exists("s:SeeTabft{SeeTab_sfx}")
	 let &ft= s:SeeTab_ft{SeeTab_sfx}
	 unlet s:SeeTab_ft{SeeTab_sfx}
	endif
   endif
   if exists("s:SeeTab_list{SeeTab_sfx}")
	let &l:list      = s:SeeTab_list{SeeTab_sfx}
    let &l:syntax    = s:SeeTab_syntax{SeeTab_sfx}
    let &l:listchars = s:SeeTab_listchars{SeeTab_sfx}
    unlet s:SeeTabEnabled{SeeTab_sfx} s:SeeTab_list{SeeTab_sfx} s:SeeTab_syntax{SeeTab_sfx}
   endif
   if exists("s:SeeTabEnabled{SeeTab_sfx}")
	unlet s:SeeTabEnabled{SeeTab_sfx}
   endif
  endif
"  call Dret("SeeTab")
endfun

let &cpo= s:keepcpo
unlet s:keepcpo
" ---------------------------------------------------------------------
"  Modelines: {{{1
" vim: ts=4 fdm=marker

