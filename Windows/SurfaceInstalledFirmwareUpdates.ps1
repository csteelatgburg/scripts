#This script will find the Firmware updates installed via Windows Update
#Designed for use on a Microsoft Surface
#Credit to Kurt Hudson and Peter Geelen
#http://social.technet.microsoft.com/wiki/contents/articles/4197.how-to-list-all-of-the-windows-and-software-updates-applied-to-a-computer.aspx
#
# Specify -outputPath parameter to set the path or change the default value below

param (
    [string]$OutputPath = "C:\Dickinson\",
    [string]$silent = "false"
 )

$Session = New-Object -ComObject "Microsoft.Update.Session"
$Searcher = $Session.CreateUpdateSearcher()

$historyCount = $Searcher.GetTotalHistoryCount()
$Updates = $Searcher.QueryHistory(0, $historyCount) | Where-Object {$_.Title -like "*Firmware*" -or $_.Title -like "*Hardware*"} | Select-Object Title, Date

$pattern = '[^a-zA-z0-9/ ]' #There is a special character in the firmware update date that we need to remove

$CleanUpdates = $Updates -replace $pattern, ''

if($silent -eq "true") {
    New-Item -ItemType Directory -Force -Path $OutputPath > $null
    $Updates | Out-File "$OutputPath\firmwareupdates.txt"
} else {
    Foreach ($Update in $Updates)
    {
        $Update -replace [char]0x200e, ""
    }
}
