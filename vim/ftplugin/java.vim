
" javacomplete#AddClassPath('/opt/android-sdk/platforms/android-7/android.jar')

" setlocal omnifunc=javacomplete#Complete

" PATH=$PATH:'opt/android-sdk/platforms/android-7/android.jar'

" set makeprg=vim-ant
" 
" set efm=\ %#[javac]\ %#%f:%l:%c:%*\\d:%*\\d:\ %t%[%^:]%#:%m,
" 			\%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#
