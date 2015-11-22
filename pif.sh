#pbpaste | vim -
#!/bin/bash
# Argument = -t test -r server -p password -v

printUsage() {
cat << EOF
usage for $0

This script uses the clipboard content and pipes it into different outputs.

OPTIONS:
   [ filename ] paste clipboard content in a new file called as the name passed
   [ -h ] [ --help ]        Show this message
   [ -v ] [ --vim ]         open inside vim buffer
   [ -e ] [ --editor ]      open inside your default env EDITOR
   [ -g ] [ --github ] [ filename ] if clipboard content is a github file url (copy link adreess from right click menu is a great example) download preserving the name.
   If a parameter is specified, thi will be used as the filename insted.
EOF
}

getRawGithubUrl() {
    if [[ $(pbpaste) != *"raw."* ]]; then
      original_url=$(pbpaste)
      raw_url="${original_url/github.com/raw.githubusercontent.com}"
      final_url="${raw_url/\/blob\///}"
      echo $final_url
    else
      echo $(pbpaste)
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
            if [[ $(pbpaste) ]] && [[ $(pbpaste) = *"github.com"* ]]; then
              url=$(getRawGithubUrl);
               if [[ -z $1 ]]; then
                 filename=$(basename $url)
                 curl $url -o $filename
               else
                 curl $url -o $1
               fi
           else
             echo "not a github file link"
           fi
           exit;;
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

if [[ $1 ]]; then
  pbpaste > $1
  exit 0
else
  printUsage
  exit 0
fi
