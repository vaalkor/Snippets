quit_with_success_code() { exit 0; }
trap quit_with_success_code ERR # Always exit with a success status

find / -iname "blah"
find / -type d
du -sh dirname # Filesize for a directory



