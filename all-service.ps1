$computer = $env:computername
$lastboot = (Get-WmiObject -Class Win32_OperatingSystem).LastBootUpTime
$lastboottime = [System.Management.ManagementDateTimeconverter]::ToDateTime($lastboot)
$boot = (get-date) - [System.Management.ManagementDateTimeconverter]::ToDateTime($lastboot)

""
Write-Host -fore Green  "Checking for Server Uptime Details: "
""
write-host "Servername" $computer;write-host "Current Date & Time = " (get-date);Write-Host "Last Boot Date & Time = " $lastboottime
Write-Host "Server has been up for: " $boot.days "days" $boot.hours "hours" $boot.minutes  "minutes";

function All-service {

Write-Host -fore Yellow "Checking System Logs:"



$events = get-eventlog -logname system |where-object {$_.eventid -eq 1074 -or $_.eventid -eq "6008" -or $_.eventid -eq "41"}

$Userrestart = $events | where-object {$_.eventid -eq 1074} | select-object Timewritten, UserName -first 3 | ft -autosize

$unexpectedshutdown = $events | where-object {$_.eventid -eq "6008" -or $_.eventid -eq "41" } |select-object message, Timewritten -first 3 | ft -autosize

$bluescreen = Get-EventLog -LogName application -Newest 100 -Source 'Windows Error*' |
select timewritten, message | where message -match 'bluescreen' |  ft -auto -wrap

if (!$Userrestart) 
{write-host -fore Green "No matching system log events found for user initiated restart..."}
else {Write-host -Fore Green "Last three User restarts"; $userrestart}

if(!$unexpectedshutdown)
{Write-Host -fore Green "No matching system log events found for unexpected shutdown..."}
else {Write-Host -fore Red "Last three unexpected shutdowns"; $unexpectedshutdown}
}

if(!$bluescreen)
{Write-host -fore Green "No matching logs found for BSOD...."}
else {Write-Host -fore Red "BSOD details"; $bluescreen}

function windows-update {

$windows_update = Get-hotfix |select-object description, installedon, hotfixid -last 5 |ft
$windows_update
}

All-service
windows-update
