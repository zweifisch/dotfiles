" set omnifunc=actionscriptcomplete#CompleteAS
" set dictionary=$HOME/vimfiles/dict/actionscript.dict
"

set makeprg=mxmlc\ %\ -optimize=false\ -output\ %:r.swf\ -default-size=600,400\ -default-frame-rate=24\ -default-background-color=0xffffff\ -debug=true
" setlocal errorformat = \%f(%l):\ Error:\ %m

nmap <leader>as :!flashplayerdebugger <c-r>=expand("%:r")<cr>.swf <cr>

nmap <leader>fc :!fcshcmp %:p<cr>
nmap <leader>fr :!fcshcmp %:p run<cr>

" set makeprg=fcshcmp\ %:p




