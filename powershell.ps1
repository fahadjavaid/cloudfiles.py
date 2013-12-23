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
the policy to unrestriected, run the script and then change the policy back 
to restricted.

PS C:\> Get-ExecutionPolicy
restricted

PS C:\> set-ExecutionPolicy remotesigned
************************

After running the script change the Exexcution Policy to restricted again.

PS C:\> set-ExecutionPolicy restricted


**********************



#>

$VerbosePreference = "Continue"
Write-Verbose "Running Step1 out of 3 and Looking for user initiated restarts"



$Userrestart=get-eventlog -logname system |where-object {$_.eventid -eq 1074} |select-object Timewritten, UserName -first 3 | ft -autosize

Write-host " "
Write-host -Fore Green "Last three User restarts"
if (!$Userrestart) {write-host -fore Red "No matching system log events found for user initiated restart..."}
else {$userrestart}

Write-Verbose "Running Step2 out of 3 and looking for Exexpected shutdowns"

$unexpectedshutdown=get-eventlog -logname system |where-object {$_.eventid -eq 6008} |select-object Timewritten -first 3 | ft -autosize

Write-host " "
Write-host -Fore Green "Last three unexpected Shutdowns"
if (!$unexpectedshutdown) {write-host -fore Red "No matching system log events found for unexpected shutdown...."}
else {$unexpectedshutdown}

Write-Verbose "Running Step3 out of 3 and looking for installed updates"
Write-host " "
Write-host -Fore Green "Details of last three installed updates"
get-hotfix | select InstalledOn, Description, HotFixID -last 3
