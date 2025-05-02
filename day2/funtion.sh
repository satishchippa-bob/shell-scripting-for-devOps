#!/bin/bash


<<task
this is just for infotainment purpose
task

# this is function defination

function is_loyal()
{
read -p "$1 enter the bandi : " bandi
read -p "$1 enter pyarr %" pyarr
if [[ $bandi == "vidya" ]];
then
        echo "$1 jeths is loyal"
elif [[ $pyarr -ge 100 ]];
then
     echo " $1 jetha is loyal"
else
        echo "$1 jetha is not loyal"
fi
}

# this is function call
is_loyal "tom"
