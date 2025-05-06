#!/usr/bin/fish

offlineimap &>/dev/null
if test $status -ne 0
    echo ERROR: Cannot fetch mails from server. 1>&2
    exit 1
end

notmuch new &>/dev/null
if test $status -ne 0
    echo ERROR: Cannot update notmuch database. 1>&2
    exit 1
end

exit 0
