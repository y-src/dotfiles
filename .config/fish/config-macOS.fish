# iTerm2 shell integration 
if set -q TERM_PROGRAM
	if test $TERM_PROGRAM = iTerm.app
		and test -e ~/.iterm2_shell_integration.fish
		source ~/.iterm2_shell_integration.fish
	end
end

# convenience command to get to projects folder
alias cdp "cd ~/projects"

# add homebrew to $PATH
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin

# load private config file for macOS, if exists
if test -e (dirname (status --current-filename))/config-macOS-private.fish
	source (dirname (status --current-filename))/config-macOS-private.fish
end
