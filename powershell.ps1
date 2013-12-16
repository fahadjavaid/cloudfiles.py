#####EventID VARIABLES:


#start-transcript -path c:\eventlogs.txt
$event_system_error = "error"
$event_application_error = "error"
$event_id_1 = 1074
$event_id_2 = 6008
$event_id_3 = 19



$check_event_log_1 = get-eventlog -logname system |where-object {$_.eventid -eq 1074} |select-object -First 3
$check_event_log_2 = get-eventlog -logname system |where-object {$_.eventid -eq 6008} |select-object -First 3
$check_event_log_3 = get-eventlog -logname system |where-object {$_.eventid -eq 19}   |select-object -First 3

if ($check_event_log_1)
    {$check_event_log_1}
else
    {"No matching system log events found for user initiated restart..."}
if ($check_event_log_2)
    {$check_event_log_2}
else
    {"No matching system log events found for unexpected shutdown...."}
if ($check_event_log_3)
    {$check_event_log_3}
else
    {"No matching system log events found for Windows updates"}

$check_hotfix = get-hotfix |select-object -last 3
$check_hotfix
