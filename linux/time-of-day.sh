#!/usr/bin/env bash

function take_input {
	read -p "Enter the time of day in 24 hrs time format: " time
	echo $time

	IFS=':' read -a atime <<< "$time"
	hour="${atime[0]}"
	mins="${atime[1]}"

	validate_time
}

function validate_time
{
	if [ `echo "$time" | grep -c ":" ` -lt 0 ] || [ `echo "$hour" | tr -d [:digit:] | wc -w` -ne 0 ] || [ `echo "$mins" | tr -d [:digit:] | wc -w` -ne 0 ]
	then
		echo "Please enter valid time..."
		take_input
	elif [ $hour -gt 23 ]
	then
		echo "Hour cannot be string or greater than 23."
		take_input
	elif [ $mins -gt 59 ]
	then
		echo "Minutes cannot be string or greater than 59."
		take_input
	fi
}

take_input

if ( [ $hour -ge 0 ] && [ $hour -le 5 ] && [ $mins -ge 0 ] && [ $mins -le 59 ] ) || ( [ $hour -eq 6 ] && [ $mins -eq 0 ] )
then
	echo $'\nEarly Morning'

elif ( [ $hour -ge 6 ] && [ $hour -le 12 ] && [ $mins -ge 0 ] && [ $mins -le 59 ] ) || ( [ $hour -eq 12 ] && [ $mins -eq 0 ] )
then
	echo $'\nMorning'

elif ( [ $hour -ge 13 ] && [ $hour -le 18 ] && [ $mins -ge 0 ] && [ $mins -le 59 ] ) || ( [ $hour -eq 18 ] && [ $mins -eq 0 ] )
then
	echo $'\nAfternoon'

elif ( [ $hour -ge 18 ] && [ $hour -le 23 ] && [ $mins -ge 0 ] && [ $mins -le 59 ] ) || ( [ $hour -eq 23 ] && [ $mins -eq 59 ] )
then
	echo $'\nLate Night'
fi
