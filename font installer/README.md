
# GOAL 🎯: 


This command will install all fonts exist in a folder tree 📁. in other words,  it will search for font files  in a folder and its subfolders recursively and then install them .


# Steps 📓 :  
1. open your Windows PowerShell (**Run it as an Administrator**)
2. Navigate to the folder where the font files are located 
use `cd` command to change directory 
   - for example, if the fonts exist in the `Downloads` file : 
```ps1
cd C:\Users\dell\Downloads
```
3. Copy Paste the Command code into your Windows PowerShell  in the [command.ps1](./command.ps1) file 

# Notes 🗒️ : 
- the command will install only font files with `.otf` extension 
- you can add more extenstions if you want to in front of `*.otf` .
```ps1
$fontFiles = Get-ChildItem -Filter *.otf *.ttf  -Recurse
```
- any existed font will be re-installed (since we use `-Force`)
