#This script is used to download a PPTX file from a website and display it
#The intent is to use this as a basic information display kiosk environment
#The script can be set to run at startup with the computer set to restart daily

#specify directory to store the file
$storageDir = "C:\slideshow"

#specify URL to download the file
#Use a PPSX file (PowerPoint slideshow) to automatically show the slides
$url = "http://server/path/to/DigitalDisplay.ppsx"


#specify location to save the file
$file = "$storageDir\slideshow.ppsx"

$webclient = New-Object System.Net.WebClient
$webclient.DownloadFile($url,$file)
Invoke-Item $file
