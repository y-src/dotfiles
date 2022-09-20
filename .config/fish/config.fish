# remove the fish welcome message
set fish_greeting ""

# add homebrew to $PATH
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin

# aliases
alias lla "ll -A"
alias g git

if status is-interactive
	# Commands to run in interactive sessions can go here
end

switch (uname)
	case Darwin
		source (dirname (status --current-filename))/config-macOS.fish
end
