" Author: Andrey Orst
" Last Modification Date: 07.06.18
" Language: C/Cpp
" License: MIT

"TODO: Externalize flow control
function! SimpleClangFormat#format(...) range
	let l:user = 0
	let l:options = ''
	if !executable('clang-format')
		echo "[ERROR] clang-format not found in path. Is it installed?"
		return -1
	endif
	if a:0 > 1
		echo "[ERROR] multiple arguments are not supported"
		return -1
	endif
	if a:0 == 0 || a:1 == ''
		if exists('g:SimpleClangFormat#options')
			let l:options = s:ParseClangOptions(g:SimpleClangFormat#options)
		else
			let l:options = 'llvm'
		endif
	elseif a:1 ==? "LLVM" || a:1 ==? "Google" || a:1 ==? "Chromium" || a:1 ==? "Mozilla" || a:1 ==? "WebKit"
		let l:options = "'{BasedOnStyle: ".a:1."}'"
	elseif a:1 ==? "File"
		let l:options = a:1
	elseif exists('g:SimpleClangFormat#userStyles') && has_key(g:SimpleClangFormat#userStyles, a:1)
		let l:user = 1
		let l:options = s:ParseClangOptions(g:SimpleClangFormat#userStyles[a:1])
	else
		" handle options directly
		if l:options =~ '\v\{.*\}'
			let l:options = s:ParseClangOptions(a:1)
		else
			echo "[ERROR] Wrong style options"
			return -1
		endif
	endif
	if l:user != 1
		let l:options = s:ApplyUserIndentationSettings(l:options)
	endif
	exec a:firstline.",".a:lastline."!clang-format -style=".l:options
	return 0
endfunction

function! s:ApplyUserIndentationSettings(options)
	let l:options = a:options
	if exists('g:SimpleClangFormat#useShiftWidth')
		if g:SimpleClangFormat#useShiftWidth == 1
			let l:options = substitute(l:options, '}', ', IndentWidth: '.&shiftwidth.'}', &gdefault ? 'gg' : 'g')
		endif
	endif
	if exists('g:SimpleClangFormat#useTabStop')
		if g:SimpleClangFormat#useTabStop == 1
			let l:options = substitute(l:options, '}', ', TabWidth: '.&tabstop.'}', &gdefault ? 'gg' : 'g')
		endif
	endif
	return l:options
endfunction

"TODO: Find a way to parsenested entries in inline config
function! s:ParseClangOptions(options)
	let l:tmp = substitute(string(a:options), "'", "", &gdefault ? 'gg' : 'g')
	return "'".l:tmp."'"
endfunction

function! SimpleClangFormat#availableStyles(a,b,c)
	let l:styles = ["LLVM", "Google", "Chromium", "Mozilla", "WebKit", "File"]
	if exists('g:SimpleClangFormat#userStyles')
		for key in keys(g:SimpleClangFormat#userStyles)
			call add(l:styles, key)
		endfor
	endif
	return join(l:styles, "\n")
endfunction
