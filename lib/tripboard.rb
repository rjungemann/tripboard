class Tripboard
  # Copy STDIN to tripboard buffer.
  def copy(contents)
    File.open "#{ ENV['HOME'] }/.tripboard-buffer.txt", 'w' do |f|
      f.puts(contents + "\n")
    end
  end

  # Paste tripboard buffer to STDOUT.
  def paste
    check_tmux

    # There will always be exactly one stray newline, so remove it
    File.read("#{ ENV['HOME'] }/.tripboard-buffer.txt")[0..-2]
  end

  # Check if tmux buffer has contents. If it does, move it to tripboard buffer
  # then delete contents of tmux buffer.
  #
  def check_tmux
    # Skip if tmux is not running.
    return if `ps aux | grep tmux | grep -v grep`.empty?

    contents = `tmux show-buffer 2>/dev/null`

    # Return if tmux buffer has no contents has contents.
    #
    # XXX: On Linux, tmux will sometimes claim that there is a character
    # followed by a newline when the tmux buffer is empty!
    #
    return if contents.empty? ||
      (contents.length == 2 && contents.match(/.\n/))

    File.open "#{ ENV['HOME'] }/.tripboard-buffer.txt", 'w' do |f|
      f.puts contents
    end

    `tmux delete-buffer`
  end
end

