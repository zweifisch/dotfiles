" File: scratch.vim
" Author: Yegappan Lakshmanan (yegappan AT yahoo DOT com)
" Version: 1.0
" Last Modified: June 3, 2003
"
" Usage
" -----
" You can use the following command to open/edit the scratch buffer:
"
"       :Scratch
"
" To open the scratch buffer in a new split window, use the following command:
"
"       :Sscratch
"
if exists('loaded_scratch') || &cp
    finish
endif
let loaded_scratch=1

" Scratch buffer name
let ScratchBufferName = "__Scratch__"

" ScratchBufferOpen
" Open the scratch buffer
function! s:ScratchBufferOpen(new_win)
    let split_win = a:new_win

    " If the current buffer is modified then open the scratch buffer in a new
    " window
    if !split_win && &modified
        let split_win = 1
    endif

    " Check whether the scratch buffer is already created
    let scr_bufnum = bufnr(g:ScratchBufferName)
    if scr_bufnum == -1
        " open a new scratch buffer
        if split_win
            exe "new " . g:ScratchBufferName
        else
            exe "edit " . g:ScratchBufferName
        endif
    else
        " Scratch buffer is already created. Check whether it is open
        " in one of the windows
        let scr_winnum = bufwinnr(scr_bufnum)
        if scr_winnum != -1
            " Jump to the window which has the scratch buffer if we are not
            " already in that window
            if winnr() != scr_winnum
                exe scr_winnum . "wincmd w"
            endif
        else
            " Create a new scratch buffer
            if split_win
                exe "split +buffer" . scr_bufnum
            else
                exe "buffer " . scr_bufnum
            endif
        endif
    endif
endfunction

" ScratchMarkBuffer
" Mark a buffer as scratch
function! s:ScratchMarkBuffer()
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    setlocal buflisted
endfunction

autocmd BufNewFile __Scratch__ call s:ScratchMarkBuffer()

" Command to edit the scratch buffer in the current window
command! -nargs=0 Scratch call s:ScratchBufferOpen(0)
" Command to open the scratch buffer in a new split window
command! -nargs=0 Sscratch call s:ScratchBufferOpen(1)

