#!/bin/bash

ssh-keygen -t ed25519 -C "your_email@example.com"

chmod 700 ~/.ssh
chmod 600 ~/.ssh/key.pem

eval "$(ssh-agent -s)"

ssh-add ~/.ssh/key.pem