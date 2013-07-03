function! TripboardCopy()
ruby << EOF
  # Read contents of vim register 'a'
  contents = Vim.evaluate('getreg("a")')

  # Add an extra linebreak to contents if contents ends in a linebreak because
  # Vim seems to chomp it somewhere.
  contents += "\n" if contents.length != contents.chomp.length

  # Move contents to tripboard buffer.
  File.open "#{ ENV['HOME'] }/.tripboard-buffer.txt", "w" do |f|
    f.puts contents
  end
EOF
endfunction

function! TripboardPaste()
  " Move tmux buffer over to tripboard if necessary.
  call system("ruby " . $HOME . "/.tripboard/tripboard.rb check_tmux")

  " Read tripboard buffer.
  let register_file = $HOME . "/.tripboard-buffer.txt"
  let contents = join(readfile(register_file), "\n")

  " Move contents of tripboard buffer into vim register 'a'.
  call setreg('a', contents)
endfunction

" Copy vim selection into vim register 'a' then persist it to tripboard buffer.
map <Leader>C "ay:call TripboardCopy()<CR>

" Copy tripboard buffer into register 'a', then place it at vim cursor.
map <Leader>V :call TripboardPaste()<CR>"ap

