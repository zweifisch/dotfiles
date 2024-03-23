
config.bind('t', 'set-cmd-text -s :open -t')

config.bind('O', 'set-cmd-text :open {url:pretty}')

config.bind('h', 'tab-prev')
config.bind('gT', 'tab-prev')
config.bind('l', 'tab-next')
config.bind('gt', 'tab-next')

config.bind('b', 'set-cmd-text -s :tab-select')

config.bind('gi', 'hint inputs')

config.bind('<Ctrl-i>', 'open-editor', mode='insert')
# config.bind('<Ctrl-u>', 'rl-unix-line-discard', mode='insert')
# config.bind('<Ctrl-a>', 'rl-beginning-of-line', mode='insert')
# config.bind('<Ctrl-e>', 'rl-end-of-line', mode='insert')
# config.bind('<Ctrl-w>', 'rl-end-word-rubout', mode='insert')

# c.content.proxy = 'socks://localhost:13659'
# c.content.proxy = 'socks://localhost:1086'
c.content.proxy = 'system'

c.url.searchengines = {
    "g": "https://www.google.com/search?q={}",
    "d": "https://duckduckgo.com/?q={}",
    "b": "https://bing.com/search?q={}",
    "DEFAULT": "https://www.google.com/search?q={}",
}

c.tabs.position = 'left'

c.auto_save.session = True

# c.content.headers.user_agent = 'Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101 Firefox/99.0'
# c.content.headers.user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.0.0 Safari/537.36'
# c.content.headers.user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36'

c.tabs.show = 'never'
c.tabs.background = True

c.aliases['np'] = 'set content.proxy none'
c.aliases['p'] = 'set content.proxy "socks://localhost:13659"'
c.aliases['readability'] = 'spawn --userscript readability-js'

c.colors.webpage.darkmode.enabled = True

# c.load_autoconfig(False)
