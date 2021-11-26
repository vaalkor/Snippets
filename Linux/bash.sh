quit_with_success_code() { exit 0; }
trap quit_with_success_code ERR # Always exit with a success status

find / -iname "blah"
find / -type d
du -sh dirname # Filesize for a directory

# Absolutely awesome CLI text editor for windows n00bs like myself that can't be arsed to learn VIM and don't like nano.
curl https://getmic.ro | bash && sudo mv micro /usr/bin
micro myFile.txt

ssh -i "KeyPairName.pem" username@servername.com

find . -type f -exec zip my_zip {} +

#print special characters. <<< is a here-string https://tldp.org/LDP/abs/html/x17837.html
cat -etv <<<"$IFS"