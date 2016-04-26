[user]
	email = #{email}
	name = #{fullname}
[alias]
	st = status -sb
	ci = commit
	br = branch
	co = checkout
	amend = commit --amend -C HEAD
	d = difftool
	purr = pull --rebase
	standup = !git log --since yesterday --author `git config user.email` --pretty=short
	unstage = reset HEAD --
	lol = log --graph --decorate --oneline
	lola = log --graph --decorate --oneline --all
	lg = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit
[http]
[color]
	ui = true
[push]
	default = simple
[diff]
	tool = vimdiff
[difftool]
	prompt = false
