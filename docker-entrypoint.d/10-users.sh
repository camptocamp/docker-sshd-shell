#!/bin/sh -e

test -n "$USERLIST" || echo 'Not adding any users. You can pass a list of users with: --env USERLIST="..."'

for user in $USERLIST; do
  echo "adding user $user"
  getent passwd "${user}" > /dev/null || useradd --shell /bin/bash --create-home --user-group --no-log-init "${user}"
  mkdir -p "/home/${user}/.ssh/"
  curl --max-time 15 -s "https://github.com/${user}.keys" > "/home/${user}/.ssh/authorized_keys"
done
