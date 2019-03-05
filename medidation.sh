#! /bin/bash

########################################
#    meditation.sh                     #
#    By: n0beard                       #
#                                      #
#  A simple bash script that plays a   #
#  simple gong sound at random         #
#  intervals between two and four      #
#  minutes.                            #
#                                      #
#  If the gong doesn't exist in the    #
#  script's directory, it              #
#  automatically downloads it to play. #
########################################


### Get the start time to use with the timer
start=$SECONDS


### Clear the screen
clear


### If the gong / bell isn't there, download it
if [ ! -e "Bell.mp3" ];
then
   wget -O Bell.mp3 http://soundbible.com/grab.php?id=1477&type=mp3
fi


### Begin the loop
while [ true ]
do
   ### Clear the screen and give exit / break instructions
   clear
   echo "Press CTRL+C to exit."
   echo "---------------------------"

   ### Calculate the timer
   duration=$(( SECONDS - start ))

   ### Display total time meditating
   if (( $duration > 3600 )) ; then
       let "hours=$duration/3600"
       let "minutes=($duration%3600)/60"
       let "seconds=($duration%3600)%60"
       echo "Total medidation: $hours hour(s), $minutes minute(s) and $seconds second(s) at last sound." 
   elif (( $duration > 60 )) ; then
       let "minutes=($duration%3600)/60"
       let "seconds=($duration%3600)%60"
       echo "Total medidation: $minutes minute(s) and $seconds second(s) at last sound."
   else
       echo "Total medidation: $duration seconds at last sound."
   fi

   ### Play the gong / bell
   mpg123 -q Bell.mp3

   ### Choose a random number of seconds and then sleep
   n=$((RANDOM%240+120))
   sleep $n
done

