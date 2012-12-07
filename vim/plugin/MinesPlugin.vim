" Mines.vim: emulates a minefield
"   Author:		Charles E. Campbell, Jr.
"   Date:		Dec 20, 2010
"   Version:	18e	ASTRO-ONLY
" Copyright:    Copyright (C) 1999-2010 Charles E. Campbell, Jr. {{{1
"               Permission is hereby granted to use and distribute this code,
"               with or without modifications, provided that this copyright
"               notice is copied with it. Like much else that's free,
"               Mines.vim is provided *as is* and comes with no warranty
"               of any kind, either expressed or implied. By using this
"               plugin, you agree that in no event will the copyright
"               holder be liable for any damages resulting from the use
"               of this software.
" GetLatestVimScripts: 551 1 :AutoInstall: Mines.vim
" GetLatestVimScripts: 1066 1 cecutil.vim
"
"  There is therefore now no condemnation to those who are in {{{1
"  Christ Jesus, who don't walk according to the flesh, but
"  according to the Spirit. (Rom 8:1 WEB)
"redraw!|call DechoSep()|call inputsave()|call input("Press <cr> to continue")|call inputrestore()
" ---------------------------------------------------------------------
"  Single Loading Only: {{{1
if &cp || exists("g:loaded_Mines")
 finish
endif
let s:keepcpo      = &cpo
set cpo&vim

" ---------------------------------------------------------------------
"  Mining Variables: {{{1
if !exists("g:mines_timer")
 let g:mines_timer= 1
endif

" ---------------------------------------------------------------------
"  Public Interface: {{{1

if !hasmapto('<Plug>EasyMines')
 nmap <unique> <Leader>mfe	<Plug>EasyMines
endif
nmap <silent> <script> <Plug>EasyMines	:set lz<CR>:call Mines#EasyMines()<CR>:set nolz<CR>

if !hasmapto('<Plug>MedMines')
 nmap <unique> <Leader>mfm	<Plug>MedMines
endif
nmap <silent> <script> <Plug>MedMines	:set lz<CR>:call Mines#MedMines()<CR>:set nolz<CR>

if !hasmapto('<Plug>HardMines')
 nmap <unique> <Leader>mfh	<Plug>HardMines
endif
nmap <silent> <script> <Plug>HardMines	:set lz<CR>:call Mines#HardMines()<CR>:set nolz<CR>

if !hasmapto('<Plug>RestoreMines')
 nmap <unique> <Leader>mfr  <Plug>RestoreMines
endif
nmap <silent> <script> <Plug>RestoreMines	:set lz<CR>:call Mines#DisplayMines(0)<CR>:set nolz<CR>

if !hasmapto('<Plug>ToggleMineTimer')
 nmap <unique> <Leader>mft  <Plug>ToggleMineTimer
endif
nmap <silent> <script> <Plug>ToggleMineTimer	:set lz<CR>:let g:mines_timer= !g:mines_timer<CR>:set nolz<CR>

if !hasmapto('<Plug>SaveStatistics')
 nmap <unique> <Leader>mfc  <Plug>SaveStatistics
endif
nmap <silent> <script> <Plug>SaveStatistics	:set lz<CR>:call Mines#SaveStatistics(0)<CR>:set nolz<CR>

" ---------------------------------------------------------------------
"  Restore: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo

" ---------------------------------------------------------------------
"  Modelines: {{{1
" vim: ts=4 fdm=marker
