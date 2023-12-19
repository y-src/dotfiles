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
alias vi nvim

if status is-interactive
	# Commands to run in interactive sessions can go here
end

switch (uname)
	case Darwin
		source (dirname (status --current-filename))/config-macOS.fish
end

