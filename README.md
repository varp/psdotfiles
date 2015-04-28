# PowerShell dotfiles

## Installation
To install psdotfiles you need to have Git installed on your system. You can download it and install from http://git-scm.com/. Don't forget to add git binary to your system PATH environment variable when you will be install Git.

To install PS dotfiles open PowerShell as administrator and run:
* `git clone https://github.com/varp/psdotfiles`
* `cd psdotfiles`
* `Unblock-File .\*`
* `Set-ExecutionyPolicy -Scope LocalMachine -ExecutionPolicy RemoteSigned`
* `.\install.ps1`

## Help 
For getting help run in PowerShell console: `.\install.ps1 help`.
