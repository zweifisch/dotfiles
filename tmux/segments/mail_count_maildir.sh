#!/usr/bin/env bash
# Return the number of new mails in a maildir.

inbox="$HOME/.mail/inbox/new"

exit 0

cd "$(dirname $0)"

if [ ! -d "$inbox" ]; then
	exit 1
fi

nbr_new=$(ls "$inbox" | wc -l)

if [ "$nbr_new" -gt "0" ]; then
	echo "✉ ${nbr_new}"
fi

exit 0;
