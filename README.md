# SimpleClangFormat.vim

Simplier usage of clang format in vim and neovim.

## How it works

This Plugin adds new command: `:ClangFormat`. It invoces over full file contents
by default, and supports ranges.

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

## Install

If you're using vim-plug, add this to your .vimrc or init.vim:

```vim
Plug 'andreyorst/SimpleClangFormat.vim'
```

Then do:

```vim
:w | so % | PlugInstall
```

## Configuration

This plugin supports configuration in your .vimrc, using list notation. If no
style specified `:ClangFormat` will fallback to configuration from `.vimrc`. If
no configuration found in `.vimrc`, default style is used.

Configuration example:
```vim
let g:SimpleClangFormat#options = {
    \"BasedOnStyle": "Webkit",
    \"IndentWidth": 4,
\}
```