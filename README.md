# SimpleClangFormat.vim

Simpler usage of clang-format in Vim and Neovim.

## What this plugin do:

This Plugin adds new command: `:ClangFormat`. It invokes `clang-format` over
whole file by default, and supports ranges.

You can specify a style in this command:

- `:ClangFormat llvm`
- `:ClangFormat Mozilla`
- `:ClangFormat Chrome`
- `:ClangFormat Chromium`
- `:ClangFormat Webkit`

Or you can pass options directly:
```vim
:ClangFormat {"BasedOnStyle": "Webkit", "IndentWidth": 4}
```

## What this plugin doesn't do:

- This plugin doesn't modify you `&equalprg` settings.
- This plugin doesn't provide
collections of custom formatting styles except those, which is shipped with `clang-format`

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

This plugin supports configuration in your `.vimrc`, using list notation. If no
style specified `:ClangFormat` will fallback to configuration from `.vimrc`. If
no configuration found in `.vimrc`, default style is used.

Configuration example:
```vim
let g:SimpleClangFormat#options = {
    \"BasedOnStyle": "Webkit",
    \"IndentWidth": 4,
\}
```

Also SimpleClangFormat.vim can track your `shiftwidth` and `tabstop` settings
with any of this variables:

```vim
let g:SimpleClangFormat#useShiftWidth = 1
```

Or:

```vim
let g:SimpleClangFormat#useTabStop = 1`
```

## About
This plugin is created and being maintained by [@andreyorst](https://GitHub.com/andreyorst).
It is being tested against Vim 8.0, Vim 7.4.1689 and neovim 0.3.0. Other versions
are not officially supported, but might work. If you found an issue, or want to
propose a change, you're welcome to do so at SimpleClangFormat.vim GitHub
repository: https://github.com/andreyorst/SimpleClangFormat.vim

