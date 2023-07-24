#!/bin/sh
shopt -s expand_aliases
source "$HOME/.zshrc"

# source "./simtype.sh"


# Simulate human typing on keyboard
# why: demo terminal script for a cli.
#  and cause faster to write it than to find an existing! - i tried for a few minutes.

# operation: given a string eg "l gs -s"
# output to the command line as if typed by a human. ie random delays between characters.
# note: for illusion to work must block -ie next command doesnt run until this is done.
# enhance: speed option.

# dir="$HOME/.shorttasks"
# source "$dir/aliases.sh"

# source ./colors.sh

# mac \x1B other \e

RCol='\x1B[0m'    # Text Reset

# Regular           Bold                Underline           High Intensity      BoldHigh Intens     Background          High Intensity Backgrounds
Bla='\x1B[0;30m';     BBla='\x1B[1;30m';    UBla='\x1B[4;30m';    IBla='\x1B[0;90m';    BIBla='\x1B[1;90m';   On_Bla='\x1B[40m';    On_IBla='\x1B[0;100m';
Red='\x1B[0;31m';     BRed='\x1B[1;31m';    URed='\x1B[4;31m';    IRed='\x1B[0;91m';    BIRed='\x1B[1;91m';   On_Red='\x1B[41m';    On_IRed='\x1B[0;101m';
Gre='\x1B[0;32m';     BGre='\x1B[1;32m';    UGre='\x1B[4;32m';    IGre='\x1B[0;92m';    BIGre='\x1B[1;92m';   On_Gre='\x1B[42m';    On_IGre='\x1B[0;102m';
Yel='\x1B[0;33m';     BYel='\x1B[1;33m';    UYel='\x1B[4;33m';    IYel='\x1B[0;93m';    BIYel='\x1B[1;93m';   On_Yel='\x1B[43m';    On_IYel='\x1B[0;103m';
Blu='\x1B[0;34m';     BBlu='\x1B[1;34m';    UBlu='\x1B[4;34m';    IBlu='\x1B[0;94m';    BIBlu='\x1B[1;94m';   On_Blu='\x1B[44m';    On_IBlu='\x1B[0;104m';
Pur='\x1B[0;35m';     BPur='\x1B[1;35m';    UPur='\x1B[4;35m';    IPur='\x1B[0;95m';    BIPur='\x1B[1;95m';   On_Pur='\x1B[45m';    On_IPur='\x1B[0;105m';
Cya='\x1B[0;36m';     BCya='\x1B[1;36m';    UCya='\x1B[4;36m';    ICya='\x1B[0;96m';    BICya='\x1B[1;96m';   On_Cya='\x1B[46m';    On_ICya='\x1B[0;106m';
Whi='\x1B[0;37m';     BWhi='\x1B[1;37m';    UWhi='\x1B[4;37m';    IWhi='\x1B[0;97m';    BIWhi='\x1B[1;97m';   On_Whi='\x1B[47m';    On_IWhi='\x1B[0;107m';



prompt="${Blu}${Gre}$ ${IYel}${Whi}"

function fakeprompt() {
    # echo ''
    printf "$prompt"
    # sleep 0.2
}

function fakewaitenter() {
    fakeprompt
    read -p "" </dev/tty
}
function fakewaitenternewline() {
    echo
    fakeprompt
    read -p "" </dev/tty
}


cls() {
    sleep 1.8
    clear
    sleep 0.8
}

function startdemo() {
    clear
    fakeprompt
    read -p "" </dev/tty
}

function enddemo() {
    fakewaitenter
}
function typeitclear(){
 clear
 typeit "$@"
}

simpaste() {
   topaste="$1" 
   printf "%s" "$1"
}

function typeit(){
    word="$1"
    # fast human speed:
    #  delays=(0.13 0.063 0.057 0.041 0.026 0.012 1.23 0.011 0.029 0.1 0.1 0.05 0.03 0.06 0.09 0.045 0.03 0.06 0.08 0.03 )
    delays=( 0.01 0.02 0.04 0.03 0.027 0.02 0.01 )
    # for dev, quicker:
    #  delays=(0.1 0.08 0.2  0.06 0.05) 
   
     fakeprompt
     sleep 0.7
    # printf  "$prompt"
    for i in $(seq 1 ${#word})
    do
        l="${word:i-1:1}"
        printf "%s" "$l"
        var=$RANDOM
        var=$(( $var % 13 )) 
        sleep ${delays[(i+var)%${#delays[@]}]}  

        # pause a bit longer on punctuation.
          if [ "$l" == '.' ] || [ "$l" == ',' ] || [ "$l" == '!' ]; then 
          sleep 0.14
          fi
        if [ "$l" == ' ' ] || [ "$l" == '-' ]; then 
          sleep 0.07 
          fi
        [ "$l" == '(' ] || [ "$l" == ')' ] && sleep 0.06  
    done
    # simulate paste 
    printf "%s" "$2"
   sleep 0.4
   printf "${Whi}"
   echo ''
   
}

fake() {
    # fakewaitenter
    typeit "$1"
    sleep 0.4
    eval "$1"
    sleep 0.45
}
fakeclear() {
    clear
    fake "$@"
}

yarnprogbar() {
 echo ' success Saved lockfile.'
 echo ' ✨  Done in 0.32s.'
}
################################

setup() {
    mkdir demo_temp
    cd "demo_temp"
    cls
    sleep 2
}

teardown() {
    rm -rf demo_temp #poly-ex apps packages kish
}

demo() {

    cls
    fake "ki"
    sleep 3
    cls

    typeit "# Lets grab the demonstration poly repo:"
    fake "git clone https://github.com/ki-sh/poly-ex.git"
    sleep 2

    cls
    typeit "and quiclky 'l' just to make sure its there!"
    fake "l"

    cls
    typeit "# here we go - no cd poly_ex, cd .. after. good riddance cd!"
    fake "nr poly-ex clone:all"

    cls
    typeit "# we now have multiple repos cloned to apps/ and packages/. Take a look:"
    fake "l apps/* packages/*"
    sleep 1

    cls
    typeit "# lets checkout a new branch called 'setup' on them all:"
    fake "gcob setup  apps/* packages/*"
    sleep 0.75

    cls
    typeit "# and lets see the new branch has been created:"
    fake "gb apps/* packages/*"
    sleep 0.6

    cls
    typeit "# say we want each of them to have npm package:"
    fake "n init -y apps/* packages/*"
    sleep 0.45

    cls
    typeit "# say you wanted to run all the tests in all the repos in one go:"
    fake "nr apps/* packages/* test"
    sleep 0.35
    typeit "# as expected, the default 'test' action - 'no tests specified' is run on all the targets."

    cls
    typeit "# lets do some source control..."
    typeit "# you can git add files:"
    fake "ga apps/w*/package.json"

    cls
    typeit "# or add whole directories (and their sub dirs):"
    fake "ga apps/* packages/*"

    cls
    typeit "#let's check git status added what we expected:"
    fake "gs apps/* packages/*"

    cls
    typeit "# commiting:"
    fake "gc 'npm initialised' apps/* packages/*"

    cls
    typeit "# you wont have access to push since this is a demo and was checked out with http,"
    typeit " but if you did have remote access ,can simply gpu dirs to push:"
    typeit "gpu apps/* packages/*"

    cls
    typeit "# Weve just scratched the surface with this intro demo."
    typeit "# We hope you get an idea of how powerful and easy ki is. hf && enjoy!"
    sleep 3
    cls
}

teardown
setup
demo
teardown


