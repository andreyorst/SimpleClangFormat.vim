" Author: Andrey Orst
" Last Modification Date: 07.16.18
" Language: C/Cpp
" License: MIT

if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

command! -buffer -complete=custom,s:AvailableStyles -range=% -nargs=? ClangFormat <line1>,<line2>call SimpleClangFormat#format('<args>')

let &cpoptions = s:save_cpo
unlet s:save_cpo

function! s:AvailableStyles(a,b,c)
	let l:styles = ["LLVM", "Google", "Chromium", "Mozilla", "WebKit", "File"]
	if exists('g:SimpleClangFormat#userStyles')
		for key in keys(g:SimpleClangFormat#userStyles)
			call add(l:styles, key)
		endfor
	endif
	return join(l:styles, "\n")
endfunction

