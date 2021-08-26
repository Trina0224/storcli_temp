#!/bin/bash
storcli /c0 set batterywarning=off
storcli /c0 set bios Mode=IE
storcli /c0 set bgirate=10
storcli /c0 set ccrate=10
storcli /c0 set prrate=10

storcli /c0/fall delete

storcli /c0 add vd type=raid5 drives=251:0-15 awb Strip=64
sleep 1
storcli /c0/v239 start init Force


#Delet a vd is:
#storcli /c0/v239 del
#list all vd:
#storcli /c0/vall show

#list all disks:
#storcli /c0 /eall /sall show