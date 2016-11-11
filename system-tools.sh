#! /bin/bash

echo "LLLLLLLLLLL             XXXXXXX       XXXXXXXFFFFFFFFFFFFFFFFFFFFFF                                                                                   
L:::::::::L             X:::::X       X:::::XF::::::::::::::::::::F                                                                                   
L:::::::::L             X:::::X       X:::::XF::::::::::::::::::::F                                                                                   
LL:::::::LL             X::::::X     X::::::XFF::::::FFFFFFFFF::::F                                                                                   
  L:::::L               XXX:::::X   X:::::XXX  F:::::F       FFFFFF                                                                                   
  L:::::L                  X:::::X X:::::X     F:::::F                                                                                                
  L:::::L                   X:::::X:::::X      F::::::FFFFFFFFFF                                                                                      
  L:::::L                    X:::::::::X       F:::::::::::::::F                                                                                      
  L:::::L                    X:::::::::X       F:::::::::::::::F                                                                                      
  L:::::L                   X:::::X:::::X      F::::::FFFFFFFFFF                                                                                      
  L:::::L                  X:::::X X:::::X     F:::::F                                                                                                
  L:::::L         LLLLLLXXX:::::X   X:::::XXX  F:::::F                                                                                                
LL:::::::LLLLLLLLL:::::LX::::::X     X::::::XFF:::::::FF                                                                                              
L::::::::::::::::::::::LX:::::X       X:::::XF::::::::FF                                                                                              
L::::::::::::::::::::::LX:::::X       X:::::XF::::::::FF                                                                                              
LLLLLLLLLLLLLLLLLLLLLLLLXXXXXXX       XXXXXXXFFFFFFFFFFF"

sleep 2
     
whiptail --title "LXF Raspberry Pi System Tools" --msgbox "Managing your Pi"\ "Since 2016" 10 40
until [ "$answer" == "Exit" ]; do
 answer=$(whiptail --title "Main Menu" --menu "Choose an option" --ok-button "Select" --cancel-button "Exit" 20 78 14 \
 "Shutdown" "Turn Off Your Pi." \
 "IP" "Check your IP address." \
 "Disk Space" "How much space does your SD card have?" \
 "System Update" "Update your Raspberry Pi software." \
 "Network Test" "Test that you can reach a website." \
 "Play Minecraft" "Play Minecraft, have fun!" \
 "Visit LXF" "Visit the Linux Format website!" ${value} 3>&1 1>&2 2>&3)
 exitstatus=$?
 echo "DEBUG"
 echo $exitstatus
 if [ $exitstatus = 0 ]; 
  then
  echo "Your chosen option:" $answer
 else
  echo "You chose Cancel."
  answer="Exit"
fi
 echo $answer
 if [ "$answer" == "Shutdown" ]
  then
   if (whiptail --title "System Shutdown" --yesno "Are you sure?" 10 60) then
    sudo sync && sudo poweroff
   else
    whiptail --title "Shutdown Cancelled" --msgbox "System Shutdown Averted!" 10 60
   fi
 elif [ "$answer" == "IP" ]
  then
  ip=$(hostname -I)
  echo $ip
  whiptail --title "Your IP Address is..." --msgbox "$ip" 10 30
 elif [ "$answer" == "Disk Space" ]
  then
  output="$(df -h)"
  whiptail --title "All disks mounted" --msgbox "${output}" 19 90 #Needed to preserve multi line output
 elif [ "$answer" == "System Update" ]
  then
  sudo apt update && sudo apt upgrade
 elif [ "$answer" == "Network Test" ]
  then
  address=$(whiptail --inputbox "What IP address shall I check?" --title "IP Address?" 19 90 3>&1 1>&2 2>&3)
  test="$(ping $address -c5)"
  whiptail --title "Test Results" --msgbox "${test}" 19 90
 elif [ "$answer" == "Play Minecraft" ]
  then
  minecraft-pi
 elif [ "$answer" == "Visit LXF" ]
  then
  chromium-browser http://linuxformat.com
 else
 echo "Exit"
 fi
done

