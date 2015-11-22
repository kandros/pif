## This is Pif, P(aste)I(n)F(ile).

A small terminal utility to allow a fast way to paste content from clipboard to a file or editor.

## install
- add the folder containing pif.sh to your path

#### copy form clipboard
![copy to file](https://cloud.githubusercontent.com/assets/4562878/11323252/28ee530a-910e-11e5-808f-b0796d0faa11.gif)

#### copy from github url
![ingithub](https://cloud.githubusercontent.com/assets/4562878/11323307/076148d0-9110-11e5-8b29-c84d7936f46e.gif)

OPTIONS:
   - [ filename ] paste clipboard content in a new file called as the name passed
   - [ -h ] [ --help ]        Show this message
   - [ -v ] [ --vim ]         open inside vim buffer
   - [ -e ] [ --editor ]      open inside your default env EDITOR if it accepts stdin
   - [ -g ] [ --github ] [ filename ] if clipboard content is a github file url (copy link address from right click menu is a great example) download preserving the name.
   If a parameter is specified, thi will be used as the filename insted.

##### dependencies
- **curl** for github integration

##### support
- currenty Osx only
- linux soon
