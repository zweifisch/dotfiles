PATH=/bin:/usr/bin:/usr/local/bin 
VERBOSE=off
DEFAULT=/var/mail/#{user}
MAILDIR=/home/#{user}/mail
LOGFILE=/home/#{user}/.procmaillog  
# Recipes below this comment:

:0:
* ^TOmutt-user
mutt
