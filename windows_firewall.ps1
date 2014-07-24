$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey("LocalMachine",$computer)
$DomainfirewallEnabled = $reg.OpenSubKey("System\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile").GetValue("EnableFirewall")
$StandardfirewallEnabled = $reg.OpenSubKey("System\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile").GetValue("EnableFirewall")
$PublicfirewallEnabled = $reg.OpenSubKey("System\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile").GetValue("EnableFirewall")


if ($DomainfirewallEnabled -eq 0) 
{Write-Host "Windows Firewall Domain Profile is disabled"}
else 
{Write-Host "Windows Firewall Domain Profile is enabled"}

if ($StandardfirewallEnabled -eq 0)
{Write-Host "Windows Firewall Private Profile is disabled"}
else
{Write-Host "Windows Firewall Private Profile is enabled"}

if ($PublicfirewallEnabled -eq 0)
{Write-Host "Windows Firewall Public Profile is Disabled"}
else
{Write-Host "Windows Firewall Public Profile is Enabled"}
