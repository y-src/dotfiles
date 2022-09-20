# remove the fish welcome message
set fish_greeting ""

# aliases
alias lla "ll -A"
alias g git

# add homebrew to $PATH
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# run fish script based on operating system name
switch (uname)
	case Darwin
		source (dirname (status --current-filename))/config-macOS.fish
end
