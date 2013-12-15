[user]
	email = #{email}
	name = #{fullname}
[alias]
	st = status -sb
	ci = commit
	br = branch
	co = checkout
	df = diff
	d = difftool
	amend = commit --amend -C HEAD
	lol = log --graph --decorate --oneline
	lola = log --graph --decorate --oneline --all
	lg = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)%Creset' --abbrev-commit
	purr = pull --rebase
	standup = !git log --since yesterday --author `git config user.email` --pretty=short
	unstage = reset HEAD --
	ribbon = tag --force _ribbon origin/master
	catchup = log --patch --reverse --topo-order _ribbon..origin/master
[http]
[color]
	ui = true
[push]
	default = simple
[diff]
	tool = vimdiff
[difftool]
	prompt = false
