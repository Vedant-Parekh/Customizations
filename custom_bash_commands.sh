create(){
    echo "Creating Files"
    while (( "$#" )); do
        text="$1"
        IFS='.'
        read -a strarr <<< "$text"
        extension=${strarr[1]}
        touch "$text"
        cp /home/vedant/ubuntu/customizations/Boilerplates/boilerplate."$extension" ./"$text" 2>/dev/null
        shift
    done
}

cses(){
    cd /mnt/c/Users/vedan/Home/Hobbies/CP/CSES
    code .
}

CP(){
    cd /mnt/c/Users/vedan/Home/Hobbies/CP/codeforces
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
alias sql='sudo service mysql restart; sudo mysql'
alias python='python3'
