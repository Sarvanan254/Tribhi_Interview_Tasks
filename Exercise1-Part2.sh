#!/bin/bash
echo "****************Script for CPU, File and Network Usage details*******************************************"
echo "***********************************************************"
echo "Disk Usage"
echo "$(df -h)"
echo "***********************************************************"
echo "CPU Usage"
echo "$(top -bn1)"
echo "***********************************************************"
## Before implement this script, should install iftop.command
sudo apt install iftop 
echo "Network Usage"
echo "$(sudo iftop -P -t -s 5 -n -N)"
