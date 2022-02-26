#!/bin/bash

# Takes a single number from 0 to 100 as input and sets the maximum battery charge to that value
charge-limit(){
if [[ $# -eq 0 ]]
 then
    	echo "No arguments supplied"
else
	sudo cp ~/Customizations/Charge_Limit/sample-battery-charge-limit.service /etc/systemd/system/battery-charge-threshold.service
	sudo sed -i "s/CHARGE_STOP_THRESHOLD/$1/g" /etc/systemd/system/battery-charge-threshold.service
	sudo systemctl daemon-reload
	sudo systemctl restart battery-charge-threshold.service
fi	
}

# Creates multiple files and copies correct boilerplate in the files based on their extension
create(){
    echo "Creating Files"
    while (( "$#" )); do
        text="$1"
        IFS='.'
        read -a strarr <<< "$text"
        extension=${strarr[1]}
        touch "$text"
        cp ~/Customizations/Boilerplates/boilerplate."$extension" ./"$text" 2>/dev/null
        shift
    done
}

# For cses practice problems
cses(){
    cd ~/Hobbies/CP/CSES
    code .
}

# Creates a folder for a contest and adds files with boilerplates
# Use flag -c to specify number of files to be created
# Use flag -n to specify name of folder
# Use flag -f to overwrite folder with specified name
CP(){
    cd ~/Hobbies/CP/codeforces
    name_of_contest="contest"
    number_of_questions=5
    force=0
    while getopts ':n:c:f' options;
    do
    case $options in
        n) name_of_contest="$OPTARG" ;;
        c) number_of_questions="$OPTARG" ;;
        f) force=1 ;;
        : ) echo "Option -$OPTARG requires an argument. Using default value" >&2
        # \?) echo "Invalid option: -$OPTARG" >&2
    esac
    done

    if [ ! -d "./$name_of_contest" ]; then
        mkdir "$name_of_contest"
    elif [[ "$force" == 1 ]]; then
        rm -rf "$name_of_contest"
        mkdir "$name_of_contest"
    else
        echo "Contest of that name already exists, use flag -f to overwrite"
        number_of_questions=0
    fi

    cd "$name_of_contest"
    while (( "$number_of_questions" > 0 )); do
        create "$number_of_questions".cpp
        number_of_questions=$((number_of_questions-1))
    done
    OPTIND=1
    number_of_questions=""
    code .
}

#Aliases
alias open='xdg-open'
alias python='python3'

# clearing journal files more than two weeks old
alias clear-journal='journalctl --vacuum-time=3d'
