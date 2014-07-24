<#

Before running this script on Customers server please first try to run below command to
find what is the current script execution policy on the server.

In the powershell command prompt type.

PS C:\> Get-ExecutionPolicy

Please carefully note down the policy.

If the results is as it shows below then go ahead and run the script.
 PS C:\> Get-ExecutionPolicy
Unrestricted

********************

If the result is as it shows below restricted then you need to change
the policy to remotesigned, run the script and then change the policy back 
to restricted.

PS C:\> Get-ExecutionPolicy
restricted

PS C:\> set-ExecutionPolicy remotesigned
************************

After running the script change the Exexcution Policy to restricted again.

PS C:\> set-ExecutionPolicy restricted


**********************



$computer = $env:computername
$lastboot = (Get-WmiObject -Class Win32_OperatingSystem).LastBootUpTime
$lastboottime = [System.Management.ManagementDateTimeconverter]::ToDateTime($lastboot)
$boot = (get-date) - [System.Management.ManagementDateTimeconverter]::ToDateTime($lastboot)

""
Write-Host "Checking for Server Uptime Details: "
""
write-host "Servername" $computer;write-host "Current Date & Time = " (get-date);Write-Host "Last Boot Date & Time = " $lastboottime
Write-Host "Server has been up for: " $boot.days "days" $boot.hours "hours" $boot.minutes  "minutes";


Write-Host -fore Yellow "Running Step 1 out of 3 and Looking for user initiated restarts"

$Userrestart=get-eventlog -logname system |where-object {$_.eventid -eq 1074} |select-object Timewritten, UserName -first 3 | ft -autosize

if (!$Userrestart) {write-host -fore Red "No matching system log events found for user initiated restart..."}
else {Write-host -Fore Green "Last three User restarts"; $userrestart}

Write-Host -fore Yellow "Running Step 2 out of 3 and looking for Unexpected Shutdowns"

$unexpectedshutdown=get-eventlog -logname system |where-object {$_.eventid -eq "6008" -or $_.eventid -eq "41" } |select-object message, Timewritten -first 3 | ft -autosize
$crash = get-eventlog -logname system |where-object {$_.eventid -eq 41} |select-object Message -first 3| format-list


if (!$unexpectedshutdown) {write-host -fore Red "No matching system log events found for unexpected shutdown...."}
else {Write-host -Fore Green "Last three unexpected Shutdowns"; $unexpectedshutdown}


[void] [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Web.Administration")
$iis = New-Object Microsoft.Web.Administration.ServerManager
$iis =Import-Module webadministration

Write-Host -fore Yellow "List and Number of websites under IIS"
get-childitem iis:\sites
(get-childitem iis:\sites).count

Write-Host -fore Yellow "List and Number of Stopped Websites"
get-childitem iis:\sites |where-object {$_.state -eq "stopped"}
(get-childitem iis:\sites |where-object {$_.state -eq "stopped"}).count


Write-host -fore Yellow "List and Number of Application Pools under IIS Manager"
get-childitem iis:\apppools
(get-childitem iis:\apppools |where-object {$_.state -eq "stopped"}).count
