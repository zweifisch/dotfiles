" RunView:
"   Author: Charles E. Campbell, Jr.
"   Date:   Apr 07, 2011
"   Version: 3f	ASTRO-ONLY
" Copyright:    Copyright (C) 2005-2011 Charles E. Campbell, Jr. {{{1
"               Permission is hereby granted to use and distribute this code,
"               with or without modifications, provided that this copyright
"               notice is copied with it. Like most software that's free,
"               RunView.vim is provided *as is* and comes with no warranty
"               of any kind, either expressed or implied. By using this
"               plugin, you agree that in no event will the copyright
"               holder be liable for any damages resulting from the use
"               of this software.
" GetLatestVimScripts: 2511 1 :AutoInstall: RunView.vim

" ---------------------------------------------------------------------
"  Load Once: {{{1
if &cp || exists("g:loaded_RunView")
 finish
endif
let g:loaded_RunView= "v3f"
"DechoTabOn

" ---------------------------------------------------------------------
"  Defaults: {{{1
if !exists("g:runview_filtcmd")
 let g:runview_filtcmd= "zsh"
endif
if !exists("g:runview_swapwin")
 let g:runview_swapwin= 1
endif

" ---------------------------------------------------------------------
"  Public Interface: {{{1
com!      -bang -range=% -nargs=? RunView let s:winposn= SaveWinPosn(0)|sil <line1>,<line2>call s:RunView(<bang>0,<q-args>)
sil! com  -bang -range=% -nargs=? RV      let s:winposn= SaveWinPosn(0)|sil <line1>,<line2>call s:RunView(<bang>0,<q-args>)

" \rh map: RunView filter-command
if !hasmapto('<Plug>RunViewH')
 vmap <unique> <Leader>rh <Plug>RunViewH
endif
vmap <silent> <script> <Plug>RunViewH	:let s:winposn= SaveWinPosn(0)<bar>call <SID>RunView(0)<cr>

" \rv map: RunView! filter-command
if !hasmapto('<Plug>RunViewV')
 vmap <unique> <Leader>rv <Plug>RunViewV
endif
vmap <silent> <script> <Plug>RunViewV	:let s:winposn= SaveWinPosn(0)<bar>call <SID>RunView(1)<cr>

" =====================================================================
"  Functions: {{{1

" ---------------------------------------------------------------------
" RunView: {{{2
fun! s:RunView(v,...) range
"  call Dfunc("RunView(v=".a:v.") [".a:firstline.",".a:lastline."] a:0=".a:0)

  " set splitright to zero while in this function
  let keep_splitright= &splitright
  let keep_splitbelow= &splitbelow
  set nosplitright nosplitbelow

  " if arg provided, use it as filter-command.  Use it for the default next time.
  " Otherwise, use g:runview_filtcmd.
  if a:0 > 0 && a:1 != ""
   " use argument as filter command
   let filtcmd           = a:1
   let g:runview_filtcmd = filtcmd
  elseif exists("b:runview_filtcmd")
   " use buffer-local filter command
   let filtcmd= b:runview_filtcmd
  else
   " use default filter command
   let filtcmd= g:runview_filtcmd
  endif
  let filtcmdfile= substitute(filtcmd,' .*$','','')
"  call Decho("filtcmd<".filtcmd.">")
"  call Decho("filtcmdfile<".filtcmdfile.">")

  " get a copy of the selected lines
  let keepa   = @a
  let marka   = getpos("'a")
  let curfile = expand("%")
  exe "sil ".a:firstline.",".a:lastline."y a"
  if filtcmd =~ '-@'
   " insert curfile before -@
   let winout = substitute(filtcmd,'^\(.*\)\(-@ .*\)$','\1','')." ".curfile." ".substitute(filtcmd,'^\(.*\)\(-@ .*\)$','\2','')
  else
   let winout = filtcmd.' '.curfile
  endif
"  call Decho("curfile<".curfile.">")
"  call Decho("winout<".winout.">")

  if bufexists(filtcmdfile)
   " output window already exists by given name.
   " Place delimiter and append output to it
"   call Decho("output window<".g:runview_filtcmd."> already exists, appending to it")
   let curwin  = winnr()
   let bufout  = bufwinnr(filtcmdfile)
   exe bufout."wincmd w"
   set ma
   let lastline= line("$")
"   call Decho("lastline=".lastline)
   let delimstring = "===".strftime("%m/%d/%y %H:%M:%S")."==="
   call setline(lastline+1,delimstring)
   $
   sil put a
   let lastlinep2= lastline + 2
"   call Decho("exe sil ".lastlinep2.",$!".filtcmd)
   exe "sil ".lastlinep2.",$!".filtcmd
   set noma nomod bh=wipe
   $
   call search('^===','bcW')
   exe "norm! z\<cr>"
   redraw
   exe curwin."wincmd w"

  else
   " (vertically) split and run register a's lines through filtcmd
"   call Decho("split and run filtcmd<".filtcmd.">")
   let curname= bufname("%")
"   call Decho("curname<".curname.">")
   if !a:v
    vert new
   else
    new
   endif
   setlocal ma buftype=nofile bh=wipe noswapfile
   sil put a
"   call Decho("exe sil %!".filtcmd)
   exe "sil %!".filtcmd
   exe "file ".fnameescape(filtcmdfile)
   let title       = 'RunView '.filtcmd.' Output Window'
   let delimstring = "===".strftime("%m/%d/%y %H:%M:%S")."==="
   1
   sil put!=''
   put =''
   call setline(1,title)
   call setline(2,delimstring)
   sil 3
   set ft=runview
   set noma nomod
   $
   call search('^===','bcW')
   exe "norm! z\<cr>"
   redraw
   if g:runview_swapwin == 1
    wincmd x
   else
    wincmd w
   endif
  endif

  " restore register a, splitright, and splitbelow
  let @a          = keepa
  let &splitright = keep_splitright
  let &splitbelow = keep_splitbelow
  call setpos("'a",marka)

  " restore position in script buffer
"  call Decho("restoring winposn")
  call RestoreWinPosn(s:winposn)

"  call Dret("RunView")
endfun

" ---------------------------------------------------------------------
"  Modelines: {{{1
"  vim: fdm=marker
