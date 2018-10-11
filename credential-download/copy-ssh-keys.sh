#Temp file to work with
FILE=github_keys.txt

#Authorized_keys file on machine
SSHFILE=~/.ssh/authorized_keys

#Grabs keys from Github API
python get-ssh-keys.py | (tee $FILE;)

#Appends already authorized keys to downloaded file
cat $SSHFILE >> $FILE
#Removes all duplicate lines
sort -u -o $FILE $FILE
#Removes lines containing only whitespace
sed -i "/^\s*$/d" $FILE
#copies downloaded file to ~/.ssh/authorized_keys
cp $FILE $SSHFILE