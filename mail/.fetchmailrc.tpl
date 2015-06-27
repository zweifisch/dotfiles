poll pop.gmail.com
with proto POP3
user '#{email}'
there with password '#{passwd}'
is '#{user}' here                              
mda "/usr/bin/procmail -d %T"
options
no keep
ssl
sslcertck
sslcertpath /etc/ssl/certs/
