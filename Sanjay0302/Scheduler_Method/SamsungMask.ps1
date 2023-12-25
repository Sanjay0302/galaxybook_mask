# Set registry values using PowerShell cmdlets
New-ItemProperty -Path 'HKLM:\HARDWARE\DESCRIPTION\System\BIOS' -Name 'SystemProductName' -Value 'NP960XFG-KC4UK' -PropertyType 'String' -Force
New-ItemProperty -Path 'HKLM:\HARDWARE\DESCRIPTION\System\BIOS' -Name 'SystemManufacturer' -Value 'Samsung' -PropertyType 'String' -Force
