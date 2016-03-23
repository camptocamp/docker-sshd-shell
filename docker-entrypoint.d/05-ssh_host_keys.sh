#!/bin/sh -e

for format in rsa dsa ecdsa ed25519; do
  ssh-keygen -f "/etc/ssh/ssh_host_${format}_key" -N '' -t $format
  ssh-keygen -l -f "/etc/ssh/ssh_host_${format}_key.pub"
done
