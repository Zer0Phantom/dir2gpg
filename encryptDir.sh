
#!/bin/bash

##Usage: encryptDir.sh dirname/ 'chunksize in Megabytes' ex. encryptDir.sh TestFolder/ 500

DIR="$(realpath "$1")"
CHUNK_SIZE=$2

echo -n Password: 
read -s PASSWORD_0
echo
echo -n Repeat Password: 
read -s PASSWORD_1
echo

if [ "$PASSWORD_0" = "$PASSWORD_1" ]

then

        tar -cf "$DIR.tar" "$DIR" &&

        #zip "$DIR".tar.zip "$DIR".tar

        gpg --cipher-algo CAMELLIA256 --digest-algo SHA512 --passphrase "$PASSWORD_0" --batch -c "$DIR".tar &&

        split --bytes="$CHUNK_SIZE"M "$DIR".tar.gpg "$DIR".tar.gpg_2018_ &&

        rm "$DIR".tar &&
        rm "$DIR".tar.gpg

else

        echo -n "passwords do not match!"

fi
