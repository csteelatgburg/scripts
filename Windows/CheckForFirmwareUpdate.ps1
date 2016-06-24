#This script will check is the firmware update for the given date is installed
#Creates a marker file in the given path if the update is installed
#Designed for use on a Microsoft Surface
#Credit to Kurt Hudson and Peter Geelen
#http://social.technet.microsoft.com/wiki/contents/articles/4197.how-to-list-all-of-the-windows-and-software-updates-applied-to-a-computer.aspx
#
# A list of Surface firmware updaets is available from Microsoft for each model
# https://www.microsoft.com/surface/en-us/support/install-update-activate/surface-update-history
#
# Takes a date parameter to match if a selected firmware update for that date has been installed
# Optional OutputPath argument can be used to specify where to put the marker file

param (
    [string]$date =  $(throw "-date is required."),
    [string]$OutputPath = "C:\Dickinson\Surface\FirmwareChecks\",
    [string]$debug = "false"
 )
New-Item -ItemType Directory -Force -Path $OutputPath > $null
$date = [datetime]$date
$d = Get-Date -date $date -format d
$outFileDate = Get-Date -date $date -format "yyyyMMdd"
$outFile = $OutputPath + $outFileDate

if($debug -eq "true") {
    echo "Checking for $d"

}

$Session = New-Object -ComObject "Microsoft.Update.Session"
$Searcher = $Session.CreateUpdateSearcher()

$historyCount = $Searcher.GetTotalHistoryCount()
if($debug -eq "true") {
    echo "historycount = $historyCount"

}

if($historyCount -eq 0) {
    #no updates installed, exit with error code 3
   $exitcode=3
   exit $exitcode
}

#$Searcher.QueryHistory(0, 1)
$Updates = $Searcher.QueryHistory(0,$historyCount) | Where-Object {$_.Title -like "*Firmware*" -or $_.Title -like "*Hardware*"} | Select-Object Title, Date
if($debug -eq "true") {
    #$Updates
}


$CleanUpdates = $Updates -replace [char]0x200e, ""
if($debug -eq "true") {
    $CleanUpdates
}
if ($CleanUpdates -like  "*$d*") {
    if($debug -eq "true") {
        echo "Update from $d found"
    }

    #Update is found, exit with code 0 and put updates in specified file
    $Updates | Out-File -filepath $outFile
    $exitcode=0
} else {
    # Update not installed, exit with error code 1
    $exitcode = 1
}
exit $exitcode
