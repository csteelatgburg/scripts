reg load HKU\Def c:\users\default\ntuser.dat

:CheckOS
IF "%PROCESSOR_ARCHITECTURE%"=="x86" (GOTO 32BIT) else (GOTO 64BIT)

:32BIT
reg import "excel-analysistoolpak-x86.reg"
GOTO END

:64BIT
reg import "excel-analysistoolpak-x64.reg"
GOTO END

:END
reg unload HKU\Def
