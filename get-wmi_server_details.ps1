$objWMI = Get-WmiObject -Class win32_ComputerSystem -namespace "root\CIMV2"
"Computer "+ $objWMI.name + " is a: "

switch ($objWMI.domainRole)
  {
  0 {Write-Host "Stand alone workstation"}
  1 {Write-Host "Member workstation"}
  2 {Write-Host "Stand alone server"}
  3 {Write-Host "Member server"}
  4 {Write-Host "Back-up domain controller"}
  5 {Write-Host "Primary domain controller"}
  default {Write-Host "The role can not be determined"}
  }

  $objWMI = Get-WmiObject -CLASS win32_operatingsystem 

  switch ($objWMI.version)
    {
    
    6.1.7601 {Write-Host "Windows Server 2008"}
    6.2.9200 {Write-Host "Windows Server 2012"}
    default {Wriet-Host "Could not locate the operating system"}
    }
