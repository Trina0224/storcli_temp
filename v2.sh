#!/bin/bash

storcli /c0 set batterywarning=off
storcli /c0 set bios Mode=IE
storcli /c0 set bgirate=10
storcli /c0 set ccrate=10
storcli /c0 set prrate=10

storcli /c0/fall delete

#EID=`storcli /c0 /eall show | grep -i "EID State" -A2 | tail -1`
IFS=', ' read -r -a array <<< `storcli /c0 /eall show | grep -i "EID State" -A2 | tail -1`
EID=${array[0]}
DISKCount=${array[3]}
DiskMaxIndex=$(($DISKCount - 1))
#echo $DiskMaxIndex

#storcli /c0 add vd type=raid5 drives=251:0-15 awb Strip=64
storcli /c0 add vd type=raid5 drives=$EID:0-$DiskMaxIndex awb Strip=64


sleep 1

#VDTarget=`storcli /c0 /vall show | grep -i RAID5`
IFS=', ' read -r -a array2 <<< `storcli /c0 /vall show | grep -i RAID5`
Target=${array2[0]}
IFS='/' read -r -a array3 <<< `echo $Target`
VDNumber=${array3[1]}

#storcli /c0/v239 start init Force
storcli /c0/v$VDNumber start init Force


#Delet a vd is:
#storcli /c0/v239 del
#list all vd:
#storcli /c0/vall show

#list all disks:
#storcli /c0 /eall /sall show