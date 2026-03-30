# usu-vim

Vim/Neovim plugin for the [usu](https://github.com/usu-dev/usu) language.

## Features

- Syntax highlighting (Legacy Vim syntax and Neovim Tree-sitter)
- Filetype detection (`*.usu`)

## Installation

### Neovim (Tree-sitter)

To get modern Tree-sitter support, you'll need [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) installed.

Once installed, you can add the `usu` parser by running:

```vim
:TSInstall usu
```

### Legacy Vim

Use your favorite plugin manager:

```vim
" Example with vim-plug
Plug 'usu-dev/usu-vim'
```

&nbsp;

<p align="center"><img src="https://raw.githubusercontent.com/usu-dev/usu/main/assets/footer.svg" width="100%"></p>
<p align="center">Copyright &copy; 2023-present <a href="https://github.com/usu-dev" target="_blank">Usu Org</a>
<a>
