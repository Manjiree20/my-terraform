#!/bin/bash
for user in `more user-list.txt`
do
echo "$user"
sudo useradd $user
echo "1pay@123" | passwd --stdin "$user"
sudo chage -d 0 $user
done
