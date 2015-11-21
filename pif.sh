#pbpaste | vim -
#!/bin/bash
# Argument = -t test -r server -p password -v

usage() {
cat << EOF
usage for $0

This script uses the clipboard content and pipes it into different outputs.

OPTIONS:
   -p      prepend clipboard content to supplied file
   -a      append clipboard content to supplied file
   -h      Show this message
   -v      opens the clipboard inside vim
   -e      tries to open the clipboard content with $EDITOR
EOF
}


while [[ $# -gt 0 ]] && [[ ."$1" = .-* ]] ;
do
    opt="$1";
    shift;
    case "$opt" in
        "-h" | "--help" )
           usage;
           exit 0;;
        "-v" | "--vim"  )
           pbpaste | vim -;;
        "-e" | "--editor")
           if [[ -z $EDITOR ]] ; then
             echo "EDITOR env variable not set"
           elif [[ $EDITOR = "vim" ]] || [ $EDITOR = "vi" ]]; then
             pbpaste | vim -
           else
             echo "trying to pipe clipboard content to $EDITOR"
             pbpaste | $EDITOR
           fi
           exit 0;;
        "-"*) echo >&2 "Invalid option: use $0 -h for a list of possible options"; exit 1;;
   esac
done

if [[ $(pbpaste) ]] && [[ $(pbpaste) = *"github"* ]]; then
  if [[ $(pbpaste) = *"raw."* ]]; then
    echo "raw"
  else
    original_url=$(pbpaste)
    raw_url="${original_url/github.com/raw.githubusercontent.com}"
    final_url="${raw_url/\/blob\///}"
    echo $(curl $final_url) > $1
  fi
elif [[ $1 ]] ; then
  pbpaste > $1
fi
