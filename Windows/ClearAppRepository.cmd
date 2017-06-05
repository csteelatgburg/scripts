@echo off
rem This script will clear the AppRepository for the listed applications
rem The AppRepository folder is only accessible as the SYSTEM account
rem due to this security it should be run as SYSTEM using a tool like psexec.exe
rem Created by Chuck Steel

cd "\ProgramData\Microsoft\Windows\AppRepository"
for /d %%G in ("Packages\*Microsoft.3DBuilder*") do rd /s /q "%%G"
for /d %%G in ("Packages\*Twitter*") do rd /s /q "%%G"
for /d %%G in ("Packages\*CandyCrushSodaSaga*") do rd /s /q "%%G"
for /d %%G in ("Packages\*Advertising*") do rd /s /q "%%G"
for /d %%G in ("Packages\*Bing*") do rd /s /q "%%G"
for /d %%G in ("Packages\*BioEnrollment*") do rd /s /q "%%G"
for /d %%G in ("Packages\*ConnectivityStore*") do rd /s /q "%%G"
for /d %%G in ("Packages\*ContactSupport*") do rd /s /q "%%G"
for /d %%G in ("Packages\*Getstarted*") do rd /s /q "%%G"
for /d %%G in ("Packages\*Messaging*") do rd /s /q "%%G"
for /d %%G in ("Packages\*MicrosoftOfficeHub*") do rd /s /q "%%G"
for /d %%G in ("Packages\*MicrosoftSolitaireCollection*") do rd /s /q "%%G"
for /d %%G in ("Packages\*MiracastView*") do rd /s /q "%%G"
for /d %%G in ("Packages\*OneNote*") do rd /s /q "%%G"
for /d %%G in ("Packages\*ParentalControls*") do rd /s /q "%%G"
for /d %%G in ("Packages\*People*") do rd /s /q "%%G"
for /d %%G in ("Packages\*PurchaseDialog*") do rd /s /q "%%G"
for /d %%G in ("Packages\*PrintDialog*") do rd /s /q "%%G"
for /d %%G in ("Packages\*SkypeApp*") do rd /s /q "%%G"
for /d %%G in ("Packages\*WindowsAlarms*") do rd /s /q "%%G"
for /d %%G in ("Packages\*WindowsMaps*") do rd /s /q "%%G"
for /d %%G in ("Packages\*WindowsPhone*") do rd /s /q "%%G"
for /d %%G in ("Packages\*Xbox*") do rd /s /q "%%G"
for /d %%G in ("Packages\*Zune*") do rd /s /q "%%G"

del /q *Microsoft.3DBuilder*.xml
del /q *Twitter*.xml
del /q *CandyCrushSodaSaga*.xml
del /q *Advertising*.xml
del /q *Bing*.xml
del /q *ConnectivityStore*.xml
del /q *Getstarted*.xml
del /q *Messaging*.xml
del /q *MicrosoftOfficeHub*.xml
del /q *MicrosoftSolitaireCollection*.xml
del /q *OneNote*.xml
del /q *People*.xml
del /q *SkypeApp*.xml
del /q *WindowsAlarms*.xml
del /q *WindowsMaps*.xml
del /q *WindowsPhone*.xml
del /q *XboxApp*.xml
del /q *ZuneMusic*.xml
del /q *ZuneVideo*.xml
