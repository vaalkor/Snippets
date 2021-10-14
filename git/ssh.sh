chmod 700 ~/.ssh
chmod 600 ~/.ssh/key.pem

eval `ssh-agent -s`
ssh-add ~/.ssh/key.pem