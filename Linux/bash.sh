quit_with_success_code() { exit 0; }
trap quit_with_success_code ERR # Always exit with a success status

find / -iname "blah"
find / -type d
du -sh dirname # Filesize for a directory

# Absolutely awesome CLI text editor for windows n00bs like myself that can't be arsed to learn VIM and don't like nano.
curl https://getmic.ro | bash && sudo mv micro /usr/bin
micro myFile.txt

ssh -i "KeyPairName.pem" username@servername.com
