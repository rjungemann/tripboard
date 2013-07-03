Tripboard
=========

By Roger Jungemann

A simple, extensible, omnipresent clipboard for tmux, vim, and zsh/bash.

Installation
------------

`git clone https://github.com/thefifthcircuit/tripboard.git ~/.tripboard`

To your `~/.zshrc` (or `~/.profile`, or similar), add:

    source ~/.tripboard/zshrc-tripboard

To your `~/.vimrc`, add:

    source ~/.tripboard/tripboard.vim

Usage
-----

In vim, make a text selection and hit `<Leader>C` to copy the text.

You can paste the text elsewhere by hitting `<Leader>V`.

In zsh/bash, you can copy text like this:

    echo foo | C

Elsewhere, you can paste text like this:

    V

If you use tmux, anytime you make a text selection, tripboard will know about
it and that selection will be usable next time you paste. Try selecting some
text using tmux selections, then in zsh, entering `V`.

How does it work?
-----------------

The clipboard is stored in `~/.tripboard-buffer.txt` (with an extra newline
added for vim compatibility reasons).

Everytime you copy with Tripboard, regardless of where you do it, it pipes the
contents to `~/.tripboard-buffer.txt` and appends a newline.

Everytime you paste, it first checks to see if tmux is running. If it is, it
checks to see if there is anything in the tmux buffer. If there is, it pipes
the contents of the tmux buffer to `~/.tripboard-buffer.txt` and deletes the
tmux buffer. Finally, it takes the contents of `~/.tripboard-buffer.txt`,
strips the final newline, and pipes it to the destination of your choice.

You can use `tripboard` directly like so:

  * `echo foo | ~/.tripboard/tripboard copy` to copy contents to tripboard
  * `~/.tripboard/tripboard paste > somfile` to paste contents somewhere else
  * `~/.tripboard/tripboard check_tmux` to manually copy over tmux buffer

TODO
----

* Allow for user to specify buffer file with an environment variable.
* Allow for user to specify tripboard path with an environment variable.
* Refactor `tripboard` script into a library for easier extensibility.
* Consider what other scripts may use tripboard.
* OS X text service for tripboard copy and paste

