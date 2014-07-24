# sets the computer to local 
$strComputer="."

# Creates a variable called $colltems which contains the WMI Object
$colltems = Get-WmiObject -Class Win32_ComputerSystem -Namespace "root\cimv2"

# Use a foreach loop to iterate the $colltems(collection)
# Store the properties information 
foreach($objitem in $colltems)
{
#Use the Write-Host cmdlet to output required property information
Write-Host "Computer Manufcturer: " $objitem.Manufacturer
Write-Host "Computer Model: " $objitem.Model
Write-Host "Total Memory: " ($objitem.TotalPhysicalMemory / 1GB) "bytes"
}

$processor_details = Get-WmiObject -class win32_processor
foreach($item in $processor_details)
{
Write-Host "Processor Manufacturer: " $item.name
