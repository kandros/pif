#pbpaste | vim -
#!/bin/bash
# Argument = -t test -r server -p password -v

printUsage() {
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

getRawGithubUrl() {
  if [[ $(pbpaste) ]] && [[ $(pbpaste) = *"github.com"* ]]; then
    if [[ $(pbpaste) != *"raw."* ]]; then
      original_url=$(pbpaste)
      raw_url="${original_url/github.com/raw.githubusercontent.com}"
      final_url="${raw_url/\/blob\///}"
      echo $final_url
    else
      echo $(pbpaste)
    fi
  else
    echo "not a github file link"
  fi
}




while [[ $# -gt 0 ]] && [[ ."$1" = .-* ]] ;
do
    opt="$1";
    shift;
    case "$opt" in
        "-h" | "--help" )
           printUsage;
           exit 0;;
        "-g" | "--github" )
           url=$(getRawGithubUrl);
           if [[ -z $1 ]]; then
             filename=$(basename $url)
             curl $url -o $filename
           else
             curl $url -o $1
           fi
           exit 0;;
        "-v" | "--vim"  )
           pbpaste | vim -;
           exit 0;;
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
