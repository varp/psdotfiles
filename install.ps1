param([string]$Action = "install-all")

Set-StrictMode -Version 3

function Reload-Profile {
    & $profile;
}


# Set execution policy to unrestricted for LocalMachine
Set-ExecutionPolicy -Scope LocalMachine -ExecutionPolicy Unrestricted
Reload-Profile


# Configre PowerShell Environment

## Instal PSGet
function Install-PsGet() {
    (new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
}

## Install Chocolately
function Install-Choco {
    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
}

## Install packages

function Install-PsGetPackages() {

    ### PsReadLine
    Install-Module PSReadLine

    ### PowerLs
    Install-Module PowerLS

    ### Go
    Install-Module go

    ### PowerShell Commnunity Extensions
    Install-Module pscx

    ### PsColor
    Install-Module PsColor

}

# copy profile script
function Install-NewProifle() {
    Remove-Item -Path $profile -ErrorAction SilentlyContinue
    New-Symlink -Target .\Microsoft.PowerShell_profile.ps1 -Path $profile
    Reload-Profile
}

function Install-GitConfig() {
    Remove-Item $env:USERPROFILE\.gitconfig
    New-Symlink -Target .\gitconfig -Path $env:USERPROFILE\.gitconfig
    Reload-Profile
}

# install system core packages
function Install-CoreApps() {
    choco install dotnet4.5 git poshgit sublimetext3.app sublimeText3.packagecontrol sublimeText3.powershellalias jivkok.sublimetext3.packages totalcommander 7zip powershell putty --force --yes
}

# install additional packages
function Install-AdditionalApps() {
    Get-Content .\packages.txt | %{ choco install $_ }
}


function Install-All() {
    Install-PsGet; Install-PsGetPacakages; Install-Choco; Install-CoreApps Install-NewProfile; Install-GitConfig
}


function Usage() {
    Write-Host "Usage: config_profile.ps1 [target]"
    Write-Host "Targets: reload-profile install-pget install-choco install-profile install-core-apps install-additional-apps install-gitconfig"
}

# main
Switch ($Action)
{
    reload-profile { Reload-Profile }
    install-psget { Install-PsGet; Install-PsGetPackages }
    install-choco { Install-Choco }
    install-profile { Install-NewProifle }
    install-core-apps { Install-CoreApps }
    install-additional-apps { Install-AdditionalApps }
    install-gitconfig { Install-GitConfig }
    help { Usage }
    default { Install-All }
}
