[void] [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Web.Administration")
$iis = New-Object Microsoft.Web.Administration.ServerManager
$iis =Import-Module webadministration
$iisii

Write-Host -fore Yellow "List and Number of websites under IIS"
get-childitem iis:\sites
(get-childitem iis:\sites).count

Write-Host -fore Yellow "List and Number of Stopped Websites"
get-childitem iis:\sites |where-object {$_.state -eq "stopped"}
(get-childitem iis:\sites |where-object {$_.state -eq "stopped"}).count


Write-host -fore Yellow "List and Number of Application Pools under IIS Manager"
get-childitem iis:\apppools
(get-childitem iis:\apppools |where-object {$_.state -eq "stopped"}).count
