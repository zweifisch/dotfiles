" Vim syntax file
" filetype:  ledger
" Version:  0.0.1

if version < 600
	sytax clear
elseif exists("b:current_sytax")
	finish
endif

syn match transNorm "^\d.*$" contains=transDate,transClear,transPayee
syn match ledgerYear "^Y\d\{4}"
syn match commPrice "^P.*" contains=transDate,commSymb,Dollars
syn match noSymb "^N.*" contains=commSymb
syn match ledgerCommand "^\!.*" 
syn match transPeriod "^\~.*" contains=transDate,transClear,transPayee,transAccName
syn match transAuto "^=.*" contains=transDate,transClear,transPayee,transAutoPayee
syn match transAcc "^\s.*$" contains=Dollars,transDebitAcc,transAccName,transAccNameV,comments
syn match transPayee "\<.*" contained
syn match transAutoPayee "\/.*[^\/]\/" contained
syn match transAccName "\<.*:\<[^\t]*" contained
syn match transAccNameV "(\<.*:\<[^\t]*)" contained
syn match commSymb "[A-Za-z]*" contained
syn match transDate	"\d\{4}\/\d\{1,2}\/\d\{1,2}" contained
syn match transDate	"\d\{2}\/\d\{1,2}" contained
syn match transDate "\d\{4}\/\d\{1,2}\/\d\{1,2}\ \
			\d\{1,2}:\d\{2}:\d\{2}" contained
syn match transClear "\*" contained
syn match Dollars "\$\-\=\d*\.\d\{2,}" contained
syn match comments "^;.*$"
syn match comments ";.*$" contained

if version >= 508 || !exists("did_config_syntax_inits")
	if version < 508
		let did_config_syntax_inits = 1
		command! -nargs=+ HiLink hi link <args>
	else
		command! -nargs=+ HiLink hi def link <args>
	endif

	HiLink transDate Question
	HiLink transNorm Normal
	HiLink transPeriod Normal
	HiLink transAuto Normal
	HiLink transAutoPayee Underlined
	HiLink transPayee Underlined
	HiLink transAccName Statement
	HiLink transAccNameV Statement
	HiLink Dollars Constant
	HiLink commPrice Normal
	HiLink commSymb Special
	HiLink noSymb Normal
	HiLink comments Comment
	HiLink transClear Normal
	HiLink ledgerYear Constant
	HiLink ledgerCommand Special

	delcommand HiLink
endif

let b:current_syntax = "ledger"

"vim: ts=4 ft=ledger
