" ~/.vim/plugin/php-doc.vim 
" inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i 
" nnoremap <C-P> :call PhpDocSingle()<CR> 
" vnoremap <C-P> :call PhpDocRange()<CR> 

" set makeprg=php\ %
" let makeprg = "php -l %"

" " php syntax check -----------------------------------------------------------
" " now use sytastic
" 
" " au! BufWriteCmd  *.php    call PHPsynCHK()
" imap <c-l> <esc>:up<cr>:call PHPsynCHK()<cr>
" map <c-l> <esc>:up<cr>:call PHPsynCHK()<cr>
" 
" fun! PHPsynCHK()
" 	let winnum = winnr() " get current window number
" 	let linenum = line('.')
" 	let colnum = col('.')
" 
" 	" silent execute "%!php -l -f ".bufname("%")." | grep line >.vimerr"
" 	silent execute "%!php -l -f /dev/stdin | sed 's/\\/dev\\/stdin/".bufname("%")."/g' | grep line >.vimerr; cat"
" 	" silent execute "%!php -l -f /dev/stdin | sed 's/\\/dev\\/stdin/".expand("%:p")."/g' | grep line >.vimerr; cat"
" 	silent cfile .vimerr
" 	cwindow " open the error window if it contains error
" 	" return to the window with cursor set on the line of the first error (if any)
" 	execute winnum . "wincmd w"
" 	silent undo " clear the error message
" 	silent cfile
" 	if 1 == len(getqflist())
" 		write
" 	else
" 		" no error
" 		call cursor(linenum, colnum)
" 	endif
" endfun
" 
" set errorformat=%m\ in\ %f\ on\ line\ %l
" ------------------------------------------------------------------------------



" code sniffer -----------------------------------------------------------------
" function! RunPhpcs()
"   let l:filename=@%
"   " let l:phpcs_output=system('phpcs --report=csv --standard=YMC '.l:filename)
"   let l:phpcs_output=system('phpcs --report=csv --standard=Zend '.l:filename)
"   echo l:phpcs_output
"   let l:phpcs_list=split(l:phpcs_output, "\n")
"   unlet l:phpcs_list[0]
"   cexpr l:phpcs_list
"   cwindow
" endfunction
" 
" set errorformat+=\"%f\"\\,%l\\,%c\\,%t%*[a-zA-Z]\\,\"%m\"
" command! CS execute RunPhpcs()
" ------------------------------------------------------------------------------
" set omnifunc=phpcomplete#CompletePHP
