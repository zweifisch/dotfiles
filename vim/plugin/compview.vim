"------------------------------------------------------------------------------
" Name Of File: compview.vim
"
"  Description: Vim plugin to search for a word and display a window with
"               matches.
"
"       Author: Juan Frias (juandfrias at gmail.com)
"
"  Last Change: 2009 Apr 10
"      Version: 1.05
"
"    Copyright: Permission is hereby granted to use and distribute this code,
"               with or without modifications, provided that this header
"               is included with it.
"
"               This script is to be distributed freely in the hope that it
"               will be useful, but is provided 'as is' and without warranties
"               as to performance of merchantability or any other warranties
"               whether expressed or implied. Because of the various hardware
"               and software environments into which this script may be put,
"               no warranty of fitness for a particular purpose is offered.
"
"               GOOD DATA PROCESSING PROCEDURE DICTATES THAT ANY SCRIPT BE
"               THOROUGHLY TESTED WITH NON-CRITICAL DATA BEFORE RELYING ON IT.
"
"               THE USER MUST ASSUME THE ENTIRE RISK OF USING THE SCRIPT.
"
"               The author does not retain any liability on any damage caused
"               through the use of this script.
"
"      Install: 1. Read the section titled 'Options'
"               2. Setup any variables need in your vimrc file
"               3. Copy 'compview.vim' to your plugin directory.
"
"  Mapped Keys: <Leader>v   Begin a search.
"
"        Usage: Start the script with the mapped key you'll be presented
"               with a prompt with the word under the cursor, press enter
"               to accept the word or type '\c' without the quotes to do a
"               case insensitive word or type in new word/expression to
"               search instead of current word.
"
"               Once the search is complete a new window appears with the
"               matches found moving around the window will also update the
"               position of the current document.
"
"               The following keys are mapped to the results window:
"
"                   q - Quit, and restore original cursor position.
"
"                   e - Exit, and keep results window open note that
"                       movements on the result window will no longer be
"                       updated.
"
"                <cr> - Quit and place the cursor on the selected line.
"
"------------------------------------------------------------------------------
" Please send me any bugs you find, so I can keep the script up to date.
"------------------------------------------------------------------------------

" History: {{{1
"------------------------------------------------------------------------------
" GetLatestVimScripts: 1803 1 :AutoInstall: compview.vim
"
" 1.05  Fixed bug where use in different tabs/buffers would not work.
"
" 1.04  Added configurable key map
"       Cleanned up code
"
" 1.03  Fixed infinite loop bug.
"
" 1.02  Fixed missing match if the match is at the start of the line.
"       Fixed problems with unnamed buffers.
"
" 1.01  Added open window position option cvWindowPosition.
"       Thanks to Bernhard Walle
"
" 1.00  Initial version.
"
" User Options: {{{1
"------------------------------------------------------------------------------
"
" <Leader>v
"       This is the default key map to view the task list.
"       to overwrite use something like:
"           map <leader>s <Plug>CompView
"       in your vimrc file
"
" g:cvWindowPosition
"       This is specifies the position of the window to be opened. By
"       default it will open at on top. To overwrite use:
"           let g:cvWindowPosition = 1
"       in your vimrc file, options are as follows:
"           0 = Open on top
"           1 = Open on the bottom
"

" Global variables: {{{1
"------------------------------------------------------------------------------

" Load script once
"------------------------------------------------------------------------------
if exists("g:loaded_compview") || &cp
    finish
endif
let g:loaded_compview = 1

" Set where the window opens
"------------------------------------------------------------------------------
if !exists('g:cvWindowPosition')
"   0 = Open at top
    let g:cvWindowPosition = 0
endif

" Function: Search file {{{1
"--------------------------------------------------------------------------
function! s:SearchFile(buffnr, word)
    " Add the name of the file to the top.
    let @z = "File:".expand("%:p")."\n"

    " Search at the beginning and keep adding them to the register
    normal! gg0
    let l:last_match = -1
    while search(a:word, "Wc") > 0
        let l:curr_line = line('.')
        if l:last_match == l:curr_line
            if l:curr_line == line('$')
                break
            endif
            normal! j0
            continue
        endif
        let l:last_match = l:curr_line
        if foldlevel(l:curr_line) != 0
            normal! 99zo
        endif
        normal! 0
        let @z = @z.line('.').':'
        normal! "Zy$
        let @z = @z."\n"
        normal! $
    endwhile

    " Open results window and place items there.
    if g:cvWindowPosition == 0
      execute 'sp -SearchResults_'.a:buffnr.'-'
    else
      execute 'botright sp -SearchResults_'.a:buffnr.'-'
    endif
    set modifiable
    normal! "zPGddgg

    " Resize line if too big.
    let l:hits = line("$")
    if l:hits < winheight(0)
        sil! exe "resize ".l:hits
    endif

    " Clean up.
    let @z = ""
    set nomodified
endfunction

" Function: Get line number {{{1
"--------------------------------------------------------------------------
function! s:LineNumber()
    let l:text = getline(".")
    if strpart(l:text, 0, 5) == "File:"
        return 0
    endif
    return strpart(l:text, 0, stridx(l:text, ":"))
endfunction

" Function: Update document position {{{1
"--------------------------------------------------------------------------
function! s:UpdateDoc()
    let l:line_hit = <sid>LineNumber()
    let l:buffnr = b:original_buffnr
    match none
    exe 'match Search /\%'.line(".").'l.*/'
    if line(".") < (line("$") - (winheight(0) / 2)) + 1
        normal! zz
    endif
    execute bufwinnr(l:buffnr)." wincmd w"
    match none
    if l:line_hit == 0
        normal! 1G
    else
        exe "normal! ".l:line_hit."Gzz"
        exe 'match Search /\%'.line(".").'l.*/'
    endif
    execute bufwinnr('-SearchResults_'.l:buffnr.'-')." wincmd w"
    redraw
endfunction

" Function: Clean up on exit {{{1
"--------------------------------------------------------------------------
function! s:Exit(key)

    call <sid>UpdateDoc()
    match none

    let l:original_line = b:original_line

    if a:key == -1
        nunmap <buffer> e
        nunmap <buffer> q
        nunmap <buffer> <cr>
        execute bufwinnr(b:original_buffnr)." wincmd w"
    else
        bd!
    endif

    if a:key == 0
        exe "normal! ".l:original_line."G"
    endif

    match none
    normal! zz

    execute "set updatetime=".s:old_updatetime
endfunction

" Function: Check for screen update {{{1
"--------------------------------------------------------------------------
function! s:CheckForUpdate()
    if stridx(expand("%:t"), "-SearchResults_") == -1
        return
    endif
    if b:selected_line != line(".")
        call <sid>UpdateDoc()
        let b:selected_line = line(".")
    endif
endfunction

" Function: Start the search. {{{1
"--------------------------------------------------------------------------
function! s:CSearch()
    let l:current_word = expand("<cword>")
    let l:original_buffnr = bufnr('%')
    let l:original_line = line(".")

    " Get the word {{{
    " ----------------

    " If the word is too big then blank it out
    if strlen(l:current_word) > 30
        let l:current_word = ""
    endif

    " Ask to verify the word
    echohl Search
    let l:search_word = input(l:current_word.",/")
    echohl None

    " If no new word was given use the one we picked up.
    if strlen(l:search_word) == 0
        let l:search_word = l:current_word
    endif

    " If only \c was passed then append it to the beginning
    if l:search_word == "\\c"
        let l:search_word = l:search_word.l:current_word
    endif

    " }}}

    " Make sure we at least have one hit.
    if !search(l:search_word, 'w')
        echohl Search
        echo "No matches found"
        echohl None
        return
    endif

    " Generate hit window
    call s:SearchFile(l:original_buffnr, l:search_word)

    " Look for the next closest match
    let l:last_lineno = -1
    while 1
        let l:curr_lineno = <sid>LineNumber()
        if l:last_lineno == l:curr_lineno
            break
        endif
        let l:last_lineno = l:curr_lineno
        if l:curr_lineno >= l:original_line
            break
        endif
        normal! j
    endwhile

    " Map exit keys
    nnoremap <buffer> <silent> q :call <sid>Exit(0)<cr>
    nnoremap <buffer> <silent> <cr> :call <sid>Exit(1)<cr>
    nnoremap <buffer> <silent> e :call <sid>Exit(-1)<cr>

    " Setup syntax highlight {{{
    exe 'syntax match compviewSearchWord   /'.l:search_word.'/'
    syntax match compviewFileDivider       /^File:.*$/
    syntax match compviewLineNumber        /^\d\+:/

    highlight def link compviewFileDivider  Title
    highlight def link compviewLineNumber   LineNr
    highlight def link compviewSearchWord   Search
    " }}}

    " Save globals and change updatetime
    let b:original_line = l:original_line
    let b:original_buffnr = l:original_buffnr
    let b:selected_line = line(".")
    let s:old_updatetime = &updatetime
    set updatetime=350

    " update the doc and hook the CheckForUpdate function.
    call <sid>UpdateDoc()
    au! CursorHold <buffer> nested call <sid>CheckForUpdate()

endfunction
"}}}

" Command
command! CompView call s:CSearch()

" Default key map
if !hasmapto('<Plug>CompView')
    map <unique> <Leader>vv <Plug>CompView
endif

" Key map to Command
nnoremap <unique> <script> <Plug>CompView :CompView<CR>

" vim:fdm=marker:tw=75:
