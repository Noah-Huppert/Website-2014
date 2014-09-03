#!/bin/bash
clear
echo "Set new root password"
echo "Add new user 'noah', only fill out 'Full Name' as 'Noah Huppert'"
read ok
sudo passwd
sudo adduser noah
echo "Install nano"
sudo apt-get install nano
echo "Change user 'noah's permissions with ssh"
echo "add 'noah ALL=(ALL:ALL) ALL' below 'root ALL...'"
read ok
sudo visudo
echo "Modify ssh setup"
echo "Change the following:"
echo "    Protocol 2"
echo "    PermitRootLogin no"
echo "At the bottom add"
echo "    UseDNS no"
echo "    AllowUsers noah"
read ok
sudo nano /etc/ssh/sshd_config
sudo reload ssh
