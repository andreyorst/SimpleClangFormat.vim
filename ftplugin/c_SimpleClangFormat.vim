if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

command! -buffer -complete=custom,SimpleClangFormat#availableStyles -range=% -nargs=? ClangFormat <line1>,<line2>call SimpleClangFormat#format('<args>')

let &cpoptions = s:save_cpo
unlet s:save_cpo

