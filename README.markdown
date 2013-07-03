Tripboard
=========

By Roger Jungemann

An omnipresent clipboard for tmux, vim, and zsh.

Installation
------------

`git clone https://github.com/thefifthcircuit/tripboard.git ~/.tripboard`

To your `~/.zshrc`, add:

    source ~/.tripboard/zshrc-tripboard

To your `~/.vimrc`, add:

    source ~/.tripboard/tripboard.vim

Usage
-----

In vim, make a text selection and hit `<Leader>C` to copy the text.

You can paste the text elsewhere by hitting `<Leader>V`.

In zsh, you can copy text like this:

    echo foo | C

Elsewhere, you can paste text like this:

    V

If you use tmux, anytime you make a text selection, tripboard will know about
it and that selection will be usable next time you paste. Try selecting some
text using tmux selections, then in zsh, entering `V`.

