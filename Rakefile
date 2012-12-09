
def dotfile_path(name)
	"#{ENV["HOME"]}/.#{name}"
end

def dotfile_exists?(name)
	full_path = dotfile_path name
	File.exists?(full_path) || File.symlink?(full_path)
end

def link_file(file, target)
	if File.exists?(target) and ! File.symlink?(target)
		`mv "#{target}" "#{target}.backup"`
	end

	if not File.exists? File.dirname(target)
		`mkdir -p "#{File.dirname target}"`
	end

	`ln -nsf "#{file}" "#{target}"`
end

def get_pair()
	blacklist = ['Rakefile','etc','README.md'] 
	linkable_dir = ['bin']

	files = Dir['*'].select{|x| File.file?(x) and ! blacklist.include?(x)}
	files += linkable_dir

	dirs = Dir['*/'] - linkable_dir.map{|x| "#{x}/"} - blacklist.map{|x| "#{x}/"}

	dirs.each do |dir|
		files += Dir["#{dir}*"]
	end

	files.each do |file|
		yield "#{Dir.getwd}/#{file}", "#{ENV["HOME"]}/.#{file}"
	end
end

def is_linked(file,target)
	`readlink #{target}`.chomp == file
end

def get_unlinked_pair()
	get_pair {|file,target| yield file,target if not is_linked file,target}
end

desc "Hook our dotfiles into system-standard positions."
task :install do
	get_unlinked_pair {|file,target| link_file file, target }
end

desc "Preview conflicts"
task :preview do
	get_unlinked_pair {|file,target|
		if File.exists?(target) and ! File.symlink?(target)
			puts "!!! #{file} => #{target}"
		else
			puts "#{"Dir " if File.directory? target}#{file} => #{target}"
		end
	}
end

task :default => 'preview'

def oh_my_zsh()
	`git clone ? .oh-my-zsh`
	`mkdir -p ~/.zsh`
	# history-substring-search, zaw, syntax
end

desc "init"
task :init do
	puts `git clone https://github.com/robbyrussell/oh-my-zsh ~/.oh-my-zsh`
end

desc "update"
task :update do
	# puts `wget https://raw.github.com/jeremyFreeAgent/oh-my-zsh-powerline-theme/master/powerline.zsh-theme -O ~/.zsh/powerline.zsh-theme`
	puts `git --work-tree ~/.oh-my-zsh --git-dir ~/.oh-my-zsh/.git pull`
end

