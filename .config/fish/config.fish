# add homebrew to $PATH
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# iTerm2 shell integration 
source ~/.iterm2_shell_integration.fish
