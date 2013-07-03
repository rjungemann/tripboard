class Tripboard

  # Copy STDIN to tripboard buffer.
  def copy
    File.open "#{ ENV['HOME'] }/.tripboard-buffer.txt", 'w' do |f|
      f.puts(STDIN.gets + "\n")
    end
  end

  # Paste tripboard buffer to STDOUT.
  def paste
    check_tmux

    # There will always be exactly one stray newline, so remove it
    contents = File.read("#{ ENV['HOME'] }/.tripboard-buffer.txt")[0..-2]

    print contents
  end

  # Check if tmux buffer has contents. If it does, move it to tripboard buffer
  # then delete contents of tmux buffer.
  def check_tmux
    # If tmux is running
    unless `ps aux | grep tmux | grep -v grep`.empty?
      contents = `tmux show-buffer 2>/dev/null`

      # XXX: tmux on Linux will claim that there are characters in an empty tmux
      # buffer!
      contents_empty = RUBY_PLATFORM.downcase.include?('linux') ?
        contents.length <= 2 :
        contents.empty?

      # If tmux buffer has contents
      unless contents_empty
        File.open "#{ ENV['HOME'] }/.tripboard-buffer.txt", 'w' do |f|
          f.puts contents
        end

        `tmux delete-buffer`
      end
    end
  end

end

