# iTerm2 shell integration 
if set -q TERM_PROGRAM
	if test $TERM_PROGRAM = iTerm.app
		and test -e ~/.iterm2_shell_integration.fish
		source ~/.iterm2_shell_integration.fish
	end
end

