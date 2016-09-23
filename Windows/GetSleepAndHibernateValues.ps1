$plan = Get-WmiObject -Class win32_powerplan -Namespace root\cimv2\power | Where-Object {$_.IsActive -eq "True"}
$regex = [regex]“{(.*?)}$” 
$planGuid = $regex.Match($plan.instanceID.Tostring()).groups[1].value 
$power = powercfg -query $planGuid 238c9fa8-0aad-41ed-83f4-97be242c8f20
$sleep = powercfg -query $planGuid SUB_SLEEP STANDBYIDLE
$sleepValue = $sleep  | Select-String "Current AC Power Setting Index"
$hibernate = powercfg -query $planGuid SUB_SLEEP HIBERNATEIDLE 
$hibernateValue = $hibernate| Select-String "Current AC Power Setting Index"
Write-Host "Sleep After:" $sleepValue.ToString().Split(":")[1]
Write-Host "Hibernate After:" $hibernateValue.ToString().Split(":")[1]