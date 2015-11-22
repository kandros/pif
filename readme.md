## This is Pif, P(aste)I(n)F(ile).

A little utility to allow a fast way to paste content from clipboard to a file or editor.

## install
- add the folder containing pif.sh to your path

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
