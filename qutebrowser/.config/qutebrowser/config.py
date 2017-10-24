
config.bind('t', 'set-cmd-text -s :open -t')

config.bind('O', 'set-cmd-text :open {url:pretty}')

config.bind('h', 'tab-prev')
config.bind('gT', 'tab-prev')
config.bind('l', 'tab-next')
config.bind('gt', 'tab-next')

c.content.proxy = 'socks://localhost:7070'

c.url.searchengines = {
    "DEFAULT": "https://www.google.com/search?q={}",
    "d": "https://duckduckgo.com/?q={}"
}
