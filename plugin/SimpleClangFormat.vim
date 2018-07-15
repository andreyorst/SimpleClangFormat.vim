" Create custom command to format code with clang-format
exec "command! -range=% -nargs=? ClangFormat <line1>,<line2>call s:SimpleClangFormat('<args>')"

function! s:SimpleClangFormat(...) range
	if !executable('clang-format')
		echo "[ERROR] clang-format not found in path. Is it installed?"
		return -1
	endif
	let l:options = ''
	if a:0 > 1
		echo "[ERROR] multiple arguments are not supported"
		return -1
	elseif a:0 == 0 || a:1 == ''
		if exists('g:SimpleClangFormat#options')
			let l:options = s:ParseClangOptions(g:SimpleClangFormat#options)
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
		else
			let l:options = 'llvm'
		endif
	elseif a:1 ==? "LLVM" || a:1 ==? "Google" || a:1 ==? "Chromium" || a:1 ==? "Mozilla" || a:1 ==? "WebKit" || a:1 ==? "File"
		let l:options = a:1
	else
		let l:options = s:ParseClangOptions(a:1)
	endif
	exec a:firstline.",".a:lastline."!clang-format -style=".l:options
	return 0
endfunction

function! s:ParseClangOptions(options)
	let l:tmp = substitute(string(a:options), "'", "", &gdefault ? 'gg' : 'g')
	return "'".l:tmp."'"
endfunction
