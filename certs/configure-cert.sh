#! /bin/bash 
# USAGE: configure-cert.sh ${USERID}
USERID=$1

# the batch, passphrase and pinentry-mode must be first before the quick-generate-key
# gpg --batch --passphrase-file passphrase --pinentry-mode loopback --quick-generate-key $USERID ed25519
