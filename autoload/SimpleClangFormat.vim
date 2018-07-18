" Author: Andrey Orst
" Last Modification Date: 07.16.18
" Language: C/Cpp
" License: MIT

function! SimpleClangFormat#format(...) range
	if !executable('clang-format')
		echo "[ERROR] clang-format not found in path. Is it installed?"
		return -1
	endif
	if a:0 == 0
		let l:style = ''
	else
		let l:style = a:1
	endif
	let l:settings = s:GetSettingsFromStyle(l:style)
	if l:settings.ignore_user_ts_sw != 1
		let l:settings.style = s:ApplyUserIndentationSettings(l:settings.style)
	endif
	exec a:firstline.",".a:lastline."!clang-format -style=".l:settings.style
	return 0
endfunction

function! s:GetSettingsFromStyle(style)
	let l:settings = {
	\    'ignore_user_ts_sw': 0,
	\    'style': '',
	\}
	if a:style == ''
		if exists('g:SimpleClangFormat#options')
			let l:settings.style = s:ParseClangOptions(g:SimpleClangFormat#options)
		else
			let l:settings.style = 'llvm'
		endif
	elseif a:style ==? "LLVM" || a:style ==? "Google" || a:style ==? "Chromium" || a:style ==? "Mozilla" || a:style ==? "WebKit"
		let l:settings.style = "'{BasedOnStyle: ".a:style."}'"
	elseif a:style ==? "File"
		let l:settings.style = 'file'
	elseif exists('g:SimpleClangFormat#userStyles') && has_key(g:SimpleClangFormat#userStyles, a:style)
		let l:settings.ignore_user_ts_sw = 1
		let l:settings.style = s:ParseClangOptions(g:SimpleClangFormat#userStyles[a:style])
	else
		" handle style directly
		if a:style =~ '\v\{.*\}'
			let l:save_ignorecase = &ignorecase
			set ignorecase
			if match(a:style, 'IndentWidth') >= 0 || match(a:style, 'TabWidth') >= 0
				let l:settings.ignore_user_ts_sw = 1
			endif
			let &ignorecase = l:save_ignorecase
			let l:settings.style = s:ParseClangOptions(a:style)
		else
			echo "[ERROR] Wrong style style: ".a:style
			return -1
		endif
	endif
	return l:settings
endfunction

function! s:ApplyUserIndentationSettings(style)
	let l:style = a:style
	if exists('g:SimpleClangFormat#useShiftWidth')
		if g:SimpleClangFormat#useShiftWidth == 1
			let l:style = substitute(l:style, '}', ', IndentWidth: '.&shiftwidth.'}', &gdefault ? 'gg' : 'g')
		endif
	endif
	if exists('g:SimpleClangFormat#useTabStop')
		if g:SimpleClangFormat#useTabStop == 1
			let l:style = substitute(l:style, '}', ', TabWidth: '.&tabstop.'}', &gdefault ? 'gg' : 'g')
		endif
	endif
	return l:style
endfunction

"TODO: Find a way to parsenested entries in inline config
function! s:ParseClangOptions(style)
	let l:tmp = substitute(string(a:style), "'", "", &gdefault ? 'gg' : 'g')
	return "'".l:tmp."'"
endfunction

