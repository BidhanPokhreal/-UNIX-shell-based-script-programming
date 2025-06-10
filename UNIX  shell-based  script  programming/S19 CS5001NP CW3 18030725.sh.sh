#!/bin/bash
 

function login {
	clear
	echo "Fill your login details"
	echo "-----------------------"
	#for validation of program name input
	validProgramName=false
	#while program name is invalid
	while [ $validProgramName == false ]
	do 
		#ask program name	
		echo -n "Enter Program name: "
		read programName
		if [[ -z $programName ]]
		then 
			echo "------------------------------"
			echo "Program name is empty"
			echo "Please enter your program name"
			echo "------------------------------"
		else
			validProgramName=true 
		fi
	done
	
	validUserName=false
	#while user name is invalid
	while [ $validUserName == false ]
	do 
		#ask user name	
		echo -n "Enter user name: "
		read username
		if [[ -z $username ]]
		then 
			echo "---------------------------"
			echo "user name is empty"
			echo "Please enter your user name"
			echo "---------------------------"
		else
			validUserName=true 
		fi
	done

	validId=false
	#until id is invalid
	while [ $validId == false ]
	do 
		#ask id	
		echo -n "Enter ID: "
		read id
		if [[ -z $id ]]
		then 
			echo "--------------------"
			echo "ID is empty"
			echo "Please enter your id"
			echo "--------------------"
		else
			validId=true 
		fi
	done
}

function password {
	#hold for 0.5 seconds
	sleep 0.5
	#clear the screen
	clear
	echo "5 chances to guess secret key"
	echo "-----------------------------"
	num_of_login=1
	login_left=4
	while [ $num_of_login -lt 6 ]
	do 
		#ask secret key
		echo "Enter secret key: "
		read -s key
		#if secret key is correct
		if [ "$key" = "bdn" ] 
		then
			echo "-------------------------------"
			#logged in successful
			echo "You are logged in successfully"
			echo "-------------------------------"
			break
		else 
			#try again
			echo "---------------------------------"
		        echo "Please try again"
			echo "You have $login_left chances left"
			echo "---------------------------------"
		 	((login_left--))
		fi
		((num_of_login++))
	done
	#if number of login left equals to 0
	if [ $num_of_login -eq 6 ]
	then
		#inform user cannot login more
		echo "-----------------------"
		echo "You cannot log in more"
		echo "-----------------------"
		#exit the system
		exit 0
	fi 
}

function welcome {
	sleep 0.5	
	clear
	#welcome username displaying its id and date of execution
	echo "-----------------------------------------"
	echo "Welcome to the World Cup Prediction Board"
	echo 
	echo "                 ID: $id"
	echo "               Username:$username"
	echo	
	echo "Date of execution: $(date)"
	echo "-----------------------------------------"
}

function best_country {
	while [ true ]
	do
		#display menu
		echo "-------------------------------------------"
		echo "|    Code            |       Country      |"
		echo "-------------------------------------------"
		echo "|    AUS             |       Australia    |"
		echo "|    BAN             |       Bangladesh   |"
		echo "|    NEP             |       Nepal        |"
		echo "|    IND             |       India        |"
		echo "|    ENG             |       England      |"
		echo "-------------------------------------------"
		#ask user best cricket team	
		echo -n "Enter code of best cricket team: "
		read code
		case $code in			
			BAN) 
			echo "Correct"
			echo "
Bangladesh is a country in Southern Asia and is located on the Bay of Bengal bordered by India on all sides except for a small border with Burma. Bangladesh has flat plains, and most of the country is situated on deltas of large rivers flowing from the Himalayas."
			break
			;;
			AUS | NEP | IND | ENG)
			echo "Wrong!!!"
			echo "Guess again"
			echo			
			;;
			*) 
			echo "Enter code  above table next time"
			;;
		esac
		sleep 0.5
		clear
	done
}

function player {
	sleep 0.5	
	clear	
	echo "The names and codes of five star players of Bangladesh are:"
	echo "-------------------------------------------"
	echo "|    Code            |   Player Name      |"
	echo "-------------------------------------------"
	echo "|    PK             |     Paras Khadka    |"
	echo "|    VK             |     Virat Kholi     |"
	echo "|    DW             |     David Warner    |"
	echo "|    BS             |     Ben Stokes      |"
	echo "|    RT             |     Ross Taylor     |"
	echo "-------------------------------------------"
	playerList=('PK' 'VK' 'DW' 'BS' 'RT')
	while :

	do
		emptyPlayerFound=false
		playerFound=false
		playerItemCount=0
		read -p "Choose Three Players: " playerInputs[0] playerInputs[1] playerInputs[2]

		for (( i=0; i<3; i++ ))
		do
			for (( j=0; j<5; j++ ))
			do
				if [[ ${playerInputs[$i]} = ${playerList[$j]} ]]

				then
					(( playerItemCount++ ))

				fi
			done

		done
		

		if [ $playerItemCount -eq 3 ]
		then
			playerFound=true
		fi

		for (( i=0; i<3; i++ ))

		do
			if [[ -z ${playerInputs[i]} ]]
			then
				emptyPlayerFound=true
				break
			fi

		done

		if [[ $emptyPlayerFound == true ]]
		then
			echo "Please enter three  Players"

		elif [[ $playerFound == true ]]
		then
			selectOnePlayer
			break
		else
			echo "Player Not Found"
		fi
	done

}

function selectOnePlayer {
	echo "Choose one of the players code: "
	select player_selected in ${playerInputs[0]} ${playerInputs[1]} ${playerInputs[2]}
	do
		case $player_selected in 
		${playerInputs[0]}|${playerInputs[1]}|${playerInputs[2]})
			chooseFile
			break
			;;
		*)
			echo "---------------------------------"
			echo "|   Please enter 1 or 2 or 3.   |"	
			echo "---------------------------------"
			;;
		esac	
	done 	
}


function chooseFile {
	#extract content of specified file
	playerDetails=$(find . -name "$player_selected")
	#check if the file is matched
	if [ -f "$playerDetails" ]
	then
		#display the content of the file
		cat $playerDetails
	else
		echo "Sorry, we are unable to open the specified file." 
	fi
	echo ""
}

#running the program
login
password
welcome
while [ true ]
do
	best_country
	player
	#ask user to repeat above steps
	echo -n "Do you want to execute program again?(enter yes or no) " 
	read choice
	if [[ "$choice" = "YES" || "$choice" = "yes" ]]
	then 
		echo "Executing the program again"
		sleep 0.5
		clear
	else 
		echo "-----------------------------------------"
		echo "|      Thanks for using my program      |"
		echo "-----------------------------------------"
		break
	fi
done




