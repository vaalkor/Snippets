#!/bin/bash
#shellcheck disable=SC1091

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

#Sourcing scripts into your current bash session. source and '.' are equivalent.
source scripts/utils.sh
. scripts/utils.sh

#Getting directory name of path
dirname scripts/crap/script1.sh # => scripts/crap

# A demonstration of locally scoped variables! 
declare -i count=0
recurse_local()
{
  ((count++))
  local x=$count
  echo "x_before: $x"
  if [ "$count" -eq 5 ]; then
    echo "Done lad!"
  else
    recurse_local
  fi
  echo "x after: $x"
}

declare -i count=0
recurse()
{
  ((count++))
  x=$count
  echo "x_before: $x"
  if [ "$count" -eq 5 ]; then
    echo "Done lad!"
  else
    recurse
  fi
  echo "x after: $x"
}