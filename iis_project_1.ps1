#$number_of_websites = Get-Website
#$number_of_appPools = Get-WebAppPoolState

[void] [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Web.Administration")
$iis = New-Object Microsoft.Web.Administration.ServerManager
$iis =Import-Module webadministration
$iis
Write-Host  "Number of websites under IIS Manager"
(get-childitem iis:\sites).count
Write-Host "Details of Stopped Websites"
(get-childitem iis:\sites |where-object {$_.status -eq "stopped"}).count

