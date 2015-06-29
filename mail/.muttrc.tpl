#======================================================#

set realname = "#{fullname}"
set from = "#{email}"
set use_from = yes
set envelope_from ="yes"

# signature
# set signature="fortune -n 120 -s ~/.fortune/signature|"
             # fortune -n 120 -s ~/.fortune/signature
# set signature="curl --silent http://hackersays.com/quote | json c a|"

# Use msmtp rather than sendmail. Check that 
# the path is correct for your system:
set sendmail = /usr/bin/msmtp

set folder = $HOME/mail

set spoolfile = "+archive"

#======================================================#

# set record="+sent"           # Where to store sent messages
# set record="~/mail/=sent-mail-`date +%Y-%m`"
set record="+sent-mail-`date +%Y-%m`"
set postponed="+postponed"   # Where to store draft messages
# set mbox_type=mbox           # Mailbox type
set mbox_type=Maildir
set move=no                  # Don't move mail from spool

#======================================================#
# Watch these mailboxes for new mail, useful only if 
# Procmail or Maildrop is used to sort mail.
mailboxes ! +slrn +fetchmail +mutt
# set sort_browser=alpha    # Sort mailboxes by alpha(bet)

#======================================================#
# What to show and order of headers
ignore *
unignore Date: From: User-Agent: X-Mailer X-Operating-System To: \
         Cc: Reply-To: Subject: Mail-Followup-To:
hdr_order Date: From: User-Agent: X-Mailer X-Operating-System To: \
        Cc: Reply-To: Subject: Mail-Followup-To:
                       
#======================================================#

set editor="vim -c 'set tw=70 et' '+/^$' " 
set edit_headers=yes      # See the headers when editing

#======================================================#
# Aliases

set alias_file = ~/.mutt_aliases
source ~/.mutt_aliases
set sort_alias=alias                 # Sort alphabetically

#======================================================#

# source ~/.mutt-colors-solarized-dark-256.muttrc
source ~/.mutt-colors-solarized-dark-16.muttrc

#======================================================#
# Lists: An example using the mutt-users list:

lists mutt-users
subscribe mutt-users
set followup_to=yes        # Sets 'Mail-Followup-To' header
set honor_followup_to=yes  
fcc-hook mutt-user +mutt   # See your own posts using fcc

#======================================================#
# Odds and ends

set markers          # mark wrapped lines of text in the pager with a +
set smart_wrap       # Don't wrap mid-word
set pager_context=5  # Retain 5 lines of previous page when scrolling.
set status_on_top    # Status bar on top.
# push <show-version>  # Shows mutt version at startup


set fast_reply

set include
# set sort=score
# set sort=date-received
# set sort_aux=last-date-received

# set sort_aux=last-date-received       
# set sort=threads
# set sort_re

set sort = reverse-date-received

# set sort=threads
# set sort_browser=reverse-date
# set sort_aux=last-date-received

set pager_stop

macro index,pager I '<shell-escape> fetchmail -v<enter>'
# doesn't work with chinse
# macro pager \cb <pipe-entry>'urlview'<enter> 'Follow links with urlview'

macro index,pager \cb "<pipe-message> urlscan<Enter>" "call urlscan to extract URLs out of a message"
macro attach,compose \cb "<pipe-entry> urlscan<Enter>" "call urlscan to extract URLs out of a message"

# # extract_url.pl
# macro index,pager ,b "<enter-command> set my_pdsave=\$pipe_decode<enter>\
# <enter-command> unset pipe_decode<enter>\
# <pipe-message>extract_url.pl<enter>\
# <enter-command> set pipe_decode=\$my_pdsave<enter>" "get URLs"
# 
# # handle encrypted email
# macro index,pager ,B "<enter-command> set my_pdsave=\$pipe_decode<enter>\
# <enter-command> set pipe_decode<enter>\
# <pipe-message>extract_url.pl<enter>\
# <enter-command> set pipe_decode=\$my_pdsave<enter>" "decrypt message, then get URLs"
# 
# message-hook .  'macro index,pager \cb ,b "URL viewer"'
# message-hook ~G 'macro index,pager \cb ,B "URL viewer"'



auto_view text/html text/enriched application/x-gunzip application/postscript image/gif application/x-tar-gz

# new
score "~N" +4
# from
score "~f ogi" +2
# subject contain 
# score "~s huang" +3
# deleted
score "~D" -5
# unread
score "~O" +1

# set charset="utf-8"
# charset-hook ^us-ascii$ gb2312
# charset-hook ^iso-8859-1$ gb2312
# charset-hook !utf-8 gb2312
#
#
# message-hook ~A                                 'set pager="w3m"'
# message-hook ~A                                 'set pager="builtin"'
# message-hook '~f "foo@bar.org"'                 'set pager="w3m"'
# message-hook '~s "slashdot headlines"'          'set pager="w3m"'
# message-hook '~s "the register update"'         'set pager="w3m"'
# message-hook '~s "YOUR LINUX TODAY NEWSLETTER"' 'set pager="w3m"'

set beep_new=yes
set check_new=yes
set timeout=600
