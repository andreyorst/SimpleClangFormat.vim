" Create custom command to format code with clang-format
exec "command! -range=% -nargs=? ClangFormat <line1>,<line2>call SimpleClangFormat#format('<args>')"
