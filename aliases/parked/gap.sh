 st="ge"
 cmd="git add, commit, push"
 applicable=""
if [ "$1" = '-h' ]; then 
    printf "${IYel}"
    echo "gap git add, commit, push"
    echo "example"
    echo "gap my commit message with no need of quotes"
fi

 shift
 comment="'" 
 comment+="$@"
 comment+="'"
#  echo ''
 ~/.kish/ga.sh && ~/.kish/gc.sh "$comment" && ~/.kish/push.sh  