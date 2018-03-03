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

- ALE (asynchronous linting)
- autoclose (automatically close matching parenthesis and brackets)
- close-html-tags (automatically close XML/HTML tags)
- CtrlP (quickly open files with fuzzy matching)
- Fugitive (the best Git plugin in any editor or IDE, period)
- GgitGutter (Show git diff in the gutter)
- Gundo (branching undo)
- HTML5.vim (HTML 5 support)
- Lightline (awesome and informative status lines)
- Deus (color theme, [see here](http://vimcolors.com/740/deus/dark))
- Mako bundle (Mako template support)
- Minpac (package manager)
- NERDCommenter (toggle comments on lines, regions, fragments)
- NERDTree (file browser)
- nvim-completion-manager (as-you-type autocompletion)
- python-indent (Python indentation)
- python-syntax (Python syntax highlighting)
- Sensible (sensible defaults for Vim)
- typescript-vim (TypeScript support)
- vim-javascript (Better JavaScript highlighting and indentation)
- vim-jsx (JSX support)
- vim-mako (Mako template language support)
- vim-surround (Add/change/remove surrounding quotes, brackets, etc.)
- vim-vue (VueJS .vue file support)

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

There is no intellisense anywhere, and only basic omnicompletion, since I don't
use it very much.

Keyboard shortcuts
==================

Leader character is ``,``.

In addition to Vim/NeoVim standard shortcuts, and standard shortcuts provided
by the plugins, the following shorctuts are also mapped:

==================  ================  =========================================
Shortcut            Name              Function
==================  ================  =========================================
``,`` ``Tab``       last buffer       Go to last buffer (``:b#``)
``,`` ``S``         git status        Open Git status
``,`` `````         file list         Toggle NerdTREE
``,`` ``b`` ``b``   next buffer       Switch to next buffer
``,`` ``b`` ``l``   list buffers      Start CtrlP in buffer mode
``,`` ``b`` ``m``   modified buffer   Switch to next modified buffer
``,`` ``b`` ``u``   unload buffer     Unload the current buffer
``,`` ``b`` ``q``   quit buffer       Delete (quit) the current buffer
``,`` ``f``         find current      Open NerdTREE and go to current file
``,`` ``n``         no highlight      Disable search highlighting
``,`` ``o``         open with CtrlP   Start CtrlP
``,`` ``p``         split horiz.      Horizontal split
``,`` ``q``         quit              Quit
``,`` ``t`` ``p``   previous tab      Switch to previous tab
``,`` ``t`` ``t``   next tab          Switch to next tab
``,`` ``u``         gundo             Toggle Gundo
``,`` ``v``         split verit.      Vertical split
``,`` ``w``         write             Save current buffer
``C-t``             new tab           Create a new tab
``F8``              spell on/off      Toggle spelling (US English)
``F12``             color theme       Toggle dark and light theme
==================  ================  =========================================

Autocommands
============

Whitespace at the end of the lines is stripped automatically when buffer is
saved. This is done for the following file types:

- ``*.coffee``
- ``*.css``
- ``*.js``
- ``*.ls``
- ``*.py``
- ``*.scss``
- ``*.tpl``
- ``*.ts``
- ``*.tsx``
- ``*.vue``

Installation
============

To install, just clone the project to a local directory::

    git clone --recursive https://github.com/foxbunny/vimfiles.git

If you forgot the ``--recursive`` flag, you need two more commands::

    git submodule init
    git submodule update

Finally, create two directories in your home directory or ``%userprofile%``
folder (not needed for NeoVim):

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

Next, create the ``.vimrc`` file at ``%userprofile%\_vimrc`` and put this into
the file::
        
    exec 'source '.$HOME.'\vimfiles\init.vim'

Linux w/ NeoVim
---------------

Symlink the git folder to ``~/.config/nvim``::

    ln -s /path/to/vimfiles.git ~/.config/nvim

More precisely, it uses ``$XDG_CONFIG_HOME``, which may or may not be
``~/.config`` for your particular flavor of Linux. If ``~/.config`` does not
work for you, substitute it for ``$XDG_CONFIG_HOME``.

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
remove packages.

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
