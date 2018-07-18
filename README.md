# SimpleClangFormat.vim

Simpler usage of clang-format in Vim and NeoVim.

## What this plugin do:

This Plugin adds new command: `:ClangFormat`.

You can specify a style:

- `:ClangFormat llvm`
- `:ClangFormat Mozilla`
- `:ClangFormat Chrome`
- `:ClangFormat Chromium`
- `:ClangFormat Webkit`
- `:ClangFormat file`

Or you can pass options directly:
```vim
:ClangFormat {BasedOnStyle: Webkit, IndentWidth: 4}
```

Furthermore, you can create your own styles.

## What this plugin doesn't do:

- This plugin doesn't modify you `&equalprg` settings.
- This plugin doesn't provide
collections of custom formatting styles except those, which are shipped with `clang-format`.
- This plugin doesn't support setting `BraceWrapping: custom` option in `.vimrc` (yet).

## Install

If you're using [vim-plug](https://github.com/junegunn/vim-plug), add this to your `.vimrc` or `init.vim`:

```vim
Plug 'andreyorst/SimpleClangFormat.vim'
```

Then do:

```vim
:w | so % | PlugInstall
```

## Configuration

This plugin can be configured in your `.vimrc`, by using list notation. If no
style specified `:ClangFormat` will fallback to this configuration. If
no configuration found in `.vimrc`, default style is used.

Configuration example:
```vim
let g:SimpleClangFormat#options = {
    \ "BasedOnStyle": "webkit",
    \ "IndentWidth": 4,
    \ "TabWidth": 4,
    \ "PointerAlignment": "Left",
    \ "AlignAfterOpenBracket": "DontAlign",
    \ "AlignConsecutiveAssignments": "true",
    \ "AlignConsecutiveDeclarations": "true",
    \ "AlignTrailingComments": "true",
    \ "BreakBeforeBraces": "Stroustrup",
    \ "UseTab": "ForIndentation",
    \ "SortIncludes": "false",
\}
```

Also SimpleClangFormat.vim can track your `shiftwidth` and `tabstop` settings
with any of this variables:

```vim
let g:SimpleClangFormat#useShiftWidth = 1
let g:SimpleClangFormat#useTabStop = 1`
```

If one of these variables is specified, `:ClangFormat` will force all styles to use `IndentWidth: 4` or `TabWidth: 4` accordingly.
[User Styles](https://github.com/andreyorst/SimpleClangFormat.vim#custom-user-styles) are immune to these settings, so you need to specify `TabWidth` and `IndentWidth`.
If you pass option list directly, using `:ClangFormat {...}` notation, explicit declaration of any of these settings will ignore user tabstop and shiftwidth settings:

```
:let g:SimpleClangFormat#useShiftWidth = 1
:let g:SimpleClangFormat#useTabStop = 1`

:set tabstops=8 | set shiftwidthw=8

" Will be extended with IndentWidth: 8, TabWidth: 8
:ClangFormat {BasedOnStyle: LLVM}
:ClangFormat {BasedOnStyle: LLVM, IndentWidth: 2, TabWidth: 2}" will ignore user tabstop and shiftwidth settings
```

### Custom User Styles

You can create custom user styles to use with `:ClangFormat`. The syntax is similar to the
`g:SimpleClangFormat#options`, except that you specify lists inside list:

```vim
let g:SimpleClangFormat#userStyles = {
    \ "AStyle": {
        \ "BasedOnStyle": "webkit"
        " rest of AStyle settings here
    \},
    \ "Stroustrup": {
        \ "BasedOnStyle": "llvm"
        ...
    \},
}
```

Custom user styles are not affected by `g:SimpleClangFormat#useShiftWidth` and `g:SimpleClangFormat#useTabStop`.


## About
This plugin is created and being maintained by [@andreyorst](https://GitHub.com/andreyorst).
It is being tested against Vim 8.0, Vim 7.4.1689 and neovim 0.3.\*. Other versions
are not officially supported, but might work. If you found an issue, or want to
propose a change, you're welcome to do so at SimpleClangFormat.vim GitHub
repository: https://github.com/andreyorst/SimpleClangFormat.vim

