
config.bind('t', 'set-cmd-text -s :open -t')

config.bind('O', 'set-cmd-text :open {url:pretty}')

config.bind('h', 'tab-prev')
config.bind('gT', 'tab-prev')
config.bind('l', 'tab-next')
config.bind('gt', 'tab-next')

config.bind('b', 'set-cmd-text -s :buffer')

config.bind('gi', 'hint inputs')

config.bind('<Ctrl-i>', 'open-editor', mode='insert')
# config.bind('<Ctrl-u>', 'rl-unix-line-discard', mode='insert')
# config.bind('<Ctrl-a>', 'rl-beginning-of-line', mode='insert')
# config.bind('<Ctrl-e>', 'rl-end-of-line', mode='insert')
# config.bind('<Ctrl-w>', 'rl-end-word-rubout', mode='insert')

c.content.proxy = 'socks://localhost:13659'

c.url.searchengines = {
    "DEFAULT": "https://www.google.com/search?q={}",
    "d": "https://duckduckgo.com/?q={}"
}

c.auto_save.session = True

c.content.headers.user_agent = 'Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Firefox/52.0'
c.tabs.show = 'never'
c.tabs.background = True
