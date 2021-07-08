#! /bin/bash 
# USAGE: configure-cert.sh 
 
git config --global user.signingkey $(gpg --list-secret-keys --keyid-format 0xlong | awk 'match($0,/0x/) {id =  substr($0, RSTART+2, 16)}END{print id}')
git config --global gpg.program $(which gpg2)
git config --global commit.gpgSign true
git config --global tag.gpgSign true
