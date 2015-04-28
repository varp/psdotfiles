param([string]$Action = "install-all")

Set-StrictMode -Version 3

function Reload-Profile {
    . $profile;
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
function Install-NewProfile() {
    Remove-Item -Path $profile -ErrorAction SilentlyContinue
    Remove-Item -Path (Join-Path (Split-Path $profile) profile.ps1) -ErrorAction SilentlyContinue
    New-Symlink -Target .\Microsoft.PowerShell_profile.ps1 -Path $profile
    New-Symlink -Target .\profile.ps1 -Path (Join-Path (Split-Path $profile) profile.ps1)
    Reload-Profile
}

function Install-GitConfig() {
    Remove-Item $env:USERPROFILE\.gitconfig -ErrorAction SilentlyContinue
    New-Symlink -Target .\gitconfig -Path $env:USERPROFILE\.gitconfig
    Reload-Profile
}

# install system core packages
function Install-CoreApps() {   
   @("dotnet4.5"
     "sublimetext3.app"
     "sublimetext3.packagecontrol"
     "sublimetext3.powershellalias"
     "jivkok.sublimetext3.packages"
     "totalcommander"
     "7zip"
     "powershell"
     "putty") | %{ choco install $_ --force --yes }
}

# install additional packages
function Install-AdditionalApps() {
    Get-Content .\additional-apps.txt | %{ choco install $_ }
}


function Install-All() {
    Install-NewProfile; Install-GitConfig; Install-PsGet; Install-PsGetPacakages; Install-Choco; Install-CoreApps
}

function Install-Core {
    Install-PsGetPackages; Install-PsGet; Install-PsGetPacakages; Install-Choco
}

function Install-Config {
    Install-NewProfile; Install-GitConfig;
}


function Usage() {
    Write-Host "Usage: config_profile.ps1 [target]"
    Write-Host "Targets: profile pget choco profile core-apps additional-apps gitconfig core config"
}

# main
Switch ($Action)
{
    profile { Reload-Profile }
    psget { Install-PsGet; Install-PsGetPackages }
    choco { Install-Choco }
    profile { Install-NewProfile }
    core-apps { Install-CoreApps }
    additional-apps { Install-AdditionalApps }
    gitconfig { Install-GitConfig }
    
    core { Install-Core }
    config { Install-Config }

    help { Usage }
    default { Install-NewProfile }
}
