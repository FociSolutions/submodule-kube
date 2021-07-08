#! /bin/bash 
# USAGE: configure-cert.sh 

git config --global user.signingkey $(gpg --list-secret-keys --keyid-format 0xlong | awk 'match($0,/0x/) {print substr($0, RSTART+2, 16)}')
git config --global gpg.program $(which gpg)
git config --global commit.gpgSign true
git config --global tag.gpgSign true