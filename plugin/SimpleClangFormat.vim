if exists('g:loaded_simple_clang_format_plugin')
    finish
endif
let g:loaded_simple_clang_format_plugin = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

command! -complete=customlist,SimpleClangFormat#availableStyles -range=% -nargs=? ClangFormat <line1>,<line2>call SimpleClangFormat#format('<args>')

let &cpoptions = s:save_cpo
unlet s:save_cpo
