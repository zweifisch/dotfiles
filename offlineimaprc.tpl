[general]
accounts = Primary

[Account Primary]
localrepository = Local
remoterepository = Remote
maxage = 5

[Repository Local]
type = Maildir
localfolders = ~/mail
nametrans = lambda folder: {'archive': '[Gmail]/All Mail',
                            }.get(folder, folder)

[Repository Remote]
# type = IMAP
# remotehost = imap.gmail.com
type = Gmail
remoteuser = #{email}
remotepass = #{passwd}
sslcacertfile = /etc/ssl/certs/ca-certificates.crt
nametrans = lambda folder: {'[Gmail]/All Mail': 'archive',
                            }.get(folder, folder)
folderfilter = lambda folder: folder == '[Gmail]/All Mail'
