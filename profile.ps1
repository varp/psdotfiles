Set-Alias gh Get-Help
Set-Alias less more

Function Set-Profile 
{
 Ise $profile
}

$Shell = $Host.UI.RawUI
$size = $Shell.WindowSize
$size.width=120
$size.height=40
$Shell.WindowSize = $size
$size = $Shell.BufferSize
$size.width=120
$size.height=5000
$Shell.BufferSize = $size


$shell.BackgroundColor = “Black”
$shell.ForegroundColor = “Yellow”

Import-Module PSReadLine
