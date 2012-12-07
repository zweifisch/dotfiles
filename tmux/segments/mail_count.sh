#!/usr/bin/env bash
# Return the number of new mails in a maildir.

inbox="/var/spool/mail/$(id --name --user)"

# cd "$(dirname $0)"
# 
# if [ ! -d "$inbox" ]; then
# 	exit 1
# fi

# nbr_new=$(ls "$inbox" | wc -l)

nbr_new=$(mail -H | grep -c '^.[NU]')

if [ "$nbr_new" -gt "0" ]; then
	echo "✉ ${nbr_new}"
fi

exit 0;
