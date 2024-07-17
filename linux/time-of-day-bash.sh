#!/usr/bin/env bash

take_input() {
	read -p "Enter the time of day in 24 hrs time format: " time
	#echo $time

#	IFS=':' read -a atime <<< "$time"
#	hour="${atime[0]}"
#	mins="${atime[1]}"

	hour=`echo $time | cut -d':' -f1`
	mins=`echo $time | cut -d':' -f2`

	validate_time
}

check_colon()
{
	if [ `echo "$time" | grep ':'` ]
	then
		echo 1;
	else
		echo 0;
	fi
}

check_number()
{
	if [ `echo "$hour" | tr -d [:digit:] | wc -w` -ne 0 ]; then
		echo 0;
	elif [ `echo "$mins" | tr -d [:digit:] | wc -w` -ne 0 ]; then
		echo 0;
	else
		echo 1;
	fi
}

validate_time()
{
#	if [ `echo "$time" | grep -c ":" ` -lt 0 ] || [ `echo "$hour" | tr -d [:digit:] | wc -w` -ne 0 ] || [ `echo "$mins" | tr -d [:digit:] | wc -w` -ne 0 ]

	#check_colon
	hasColon=$(check_colon)
	#echo $hasColon

	isNumber=$(check_number)
	#echo $isNumber

	if [ $hasColon -eq 0 ] || [ $isNumber -eq 0 ]
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
	echo "\nEarly Morning\n"

elif ( [ $hour -ge 6 ] && [ $hour -le 12 ] && [ $mins -ge 0 ] && [ $mins -le 59 ] ) || ( [ $hour -eq 12 ] && [ $mins -eq 0 ] )
then
	echo "\nMorning\n"

elif ( [ $hour -ge 13 ] && [ $hour -le 18 ] && [ $mins -ge 0 ] && [ $mins -le 59 ] ) || ( [ $hour -eq 18 ] && [ $mins -eq 0 ] )
then
	echo "\nAfternoon\n"

elif ( [ $hour -ge 18 ] && [ $hour -le 23 ] && [ $mins -ge 0 ] && [ $mins -le 59 ] ) || ( [ $hour -eq 23 ] && [ $mins -eq 59 ] )
then
	echo "\nLate Night\n"
fi
