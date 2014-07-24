#——————>Crash control values are enumerated here
$CrashControl=”hklm:\SYSTEM\CurrentControlSet\Control\CrashControl”
$CrashProp=$CrashControl | Get-ItemProperty
$CrashNo=$CrashProp.CrashDumpEnabled

#—————->Switch used over here.

Switch($CrashNo) {

0 { “Memory is NOT configured” }
1 {“Complete memory dump is configured” }
2 {“Kernel memory dump is configured”}
3 {“Small memory dump (64KB)”}

} 
Write-host Dump file location $CrashProp.DumpFile

$AutoNo=$CrashProp.AutoReboot
If ($AutoNo -eq 0) {write-host Auto Reboot is not enabled} else {write-host AutoReboot is enabled}

$CrashNo=$CrashProp.Overwrite
If ($CrashNo -eq 0) { write-host Overwrite Memory dump option is not enabled} else { write-host Overwrite Memory dump is enabled}
Write-Host “” 
