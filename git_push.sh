#!/bin/bash
echo Enter commit message

read commit_message
echo do you want to push your commit? type 'y' for yes, type anythink for no
read is_pushed

if [[ $is_pushed == 'y' ]]; then
  env -i git add . && git commit -m "$commit_message" && git push
else
  env -i git add . && git commit -m "$commit_message"
fi
