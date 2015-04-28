Set-Alias gh Get-Help
Set-Alias less more

Function Set-Profile 
{
 Ise $profile
}

$Shell = $Host.UI.RawUI
$shell.BackgroundColor = “Black”
$shell.ForegroundColor = “Yellow”

Import-Module PSReadLine
