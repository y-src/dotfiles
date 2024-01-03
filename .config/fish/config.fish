# remove the fish welcome message
function fish_greeting
end

# remove fish mode prompt
function fish_mode_prompt
end

# emulate vim bindings and cursor
fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore

# aliases
alias lla "ll -A"
alias g git
alias cd.dotf "cd $HOME/dotfiles"
alias cd.conf "cd $HOME/.config"
alias cd.proj "cd $HOME/projects"
alias vi nvim

# set default version of node
if type -q nvm
	nvm use lts &> /dev/null
end

if status is-interactive
	# Commands to run in interactive sessions can go here
end

switch (uname)
	case Darwin
		source (dirname (status --current-filename))/config-macOS.fish
#	case Linux
#		source (dirname (status --current-filename))/config-linux.fish
end

