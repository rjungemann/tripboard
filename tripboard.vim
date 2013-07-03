function! TripboardCopy()
ruby << EOF
  contents = Vim.evaluate('getreg("a")')

  # Add an extra linebreak if it ends in a linebreak because Vim seems to
  # chomp it somewhere
  contents += "\n" if contents.length != contents.chomp.length

  File.open "#{ ENV['HOME'] }/.tripboard-buffer.txt", "w" do |f|
    f.puts contents
  end
EOF
endfunction

function! TripboardPaste()
  call system("ruby " . $HOME . "/.tripboard/tripboard.rb check_tmux")

  let register_file = $HOME . "/.tripboard-buffer.txt"
  let contents = join(readfile(register_file), "\n")

  call setreg('a', contents)
endfunction

map <Leader>C "ay:call TripboardCopy()<CR>
map <Leader>V :call TripboardPaste()<CR>"ap

