===================
Foxbunny's vimfiles
===================

After a long while, I got around to cleaning up my vim configuration. Removed
all the stuff I don't need, updated all bundles, etc. Since it sucks to keep
files in sync between machines, I'm putting it up here.

.. warning ::
  This configuration is only compatible with the latest versions of Vim and
  NeoVim. In particular, it uses Minpac which relies on Vim packages support.

The following is included (in alphabetical order):

- autoclose (automatically close matching parenthesis and brackets)
- close-html-tags (automatically close XML/HTML tags)
- CtrlP (quickly open files with fuzzy matching)
- Fugitive (the best Git plugin in any editor or IDE, period)
- Gundo (branching undo)
- HTML5.vim (HTML 5 support)
- Lightline (awesome and informative status lines)
- Lucius (color theme)
- Mako bundle (Mako template support)
- Minpac (package manager)
- NERDTree (file browser)
- python-indent (Python indentation)
- python-syntax (Python syntax highlighting)
- Sensible (sensible defaults for Vim)
- Syntastic (metalinter for most languages)
- TSLint (TypeScript linter support)
- Tsuquyomi (TypeScript intellisense and code checking)
- vim-javascript (Better JavaScript highlighting and indentation)
- vim-jsx (JSX support)
- vim-mako (Mako template language support)
- vim-surround (Add/change/remove surrounding quotes, brackets, etc.)
- vim-vue (VueJS .vue file support)
- vimproc.vim (Support for subprocesses in some of the plugins)

The configuration covers the following languages and libraries:

- Python
- HTML5/CSS
- SASS/SCSS
- Mako templates
- JavaScript and JSX
- TypeScript and TSX
- VueJS
- CoffeeScript
- PureScript
- Shell scripts

Installation
============

To install, just clone the project to a local directory::

    git clone --recursive https://github.com/foxbunny/vimfiles.git

If you forgot the ``--recursive`` flag, you need two more commands:

    git submodule init
    git submodule update

The ``vimproc`` plugin needs to be compiled. Under *Nix systems, you can simply
run ``make`` in the plugin folder. On Windows, you will need to first install
`MinGW <http://mingw.org/>`_, and then use the MinGW shell to compile the
plugin.

Finally, create two directories in your home directory or ``%userprofile%``
folder:

- ``.vim_undo`` for persistent undo
- ``.vim_swap`` for storing swap files in a single folder

Using the configuration
=======================

The configuration files are located in different locations depending on the
OS and whether you want to use this with NeoVim or vanilla Vim.

Windows w/ NeoVim
-----------------

Symlink the git folder to ``%userprofile%\AppData\Local\nvim``::

    mklink /J %userprofile%\AppData\Local\nvim \path\to\vimfiles.git

Windows w/ Vim
--------------

Symlink the git folder to `%userprofiles%\vimfiles`::

    mklink /J %userprofile%\vimfiles

Next, create the vimrc file at %userprofile%\_vimrc and put this into the
file::
        
    exec 'source '.$HOME.'\vimfiles\init.vim'

Linux w/ NeoVim
---------------

Symlink the git folder to ``~/.config/nvim``::

    ln -s /path/to/vimfiles.git ~/.config/nvim

More precisely, it uses ``$XDG_CONFIG_HOME``, which may or may not be
``~/.config`` for your particular flavor of Linux. If ``~/.config`` does not
work for you, subsititute it for ``$XDG_CONFIG_HOME``.

Linux w/ Vim
------------

Symlink the git folder to ``~/.vim``::

    ln -s /path/to/vimfiles.git ~/.vim

Also symlink the main configuration file::
    
    ln -s /path/to/vimfiles.git/init.vim ~/.vimrc

Initializing the plugins
========================

The first time you start Vim or NeoVim with this configuration, you will notice
that many of the promised goodies don't work. This is because the plugins are
not part of the repository, but are, instead, managed by Minpac. The first time
you run your editor, use the following command::

    :Pacsync

This will download the necessary plugins from GitHub and install them under
``pack/minpac/start``. 

This command is also used when you update the ``init.vim`` file to add or
remove pckages.

Machine-specific configuration
==============================

In some cases, the configuration needs to mention paths to various executable
(e.g., Python interpreter in NeoVim). Since these are different for each
platform and possibly other factors, the main configuration file will attempt
to pull in a file called ``machine.vim`` in your home directory or
``%userprofile%`` folder. This file may contain any of the usual NeoVim/Vim
configuration scripts and you can use that to customize the configuration
instead of patching the ``init.vim`` file.

Screenshot
==========

.. figure:: screenshot.png

License
=======

To the extent legally permitted, you are free to do whatever you want with
these files.
