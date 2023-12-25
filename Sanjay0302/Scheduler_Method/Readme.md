The method using  `.vbs` file always requires admin confirmation maually whenever the system starts

But to avoid this confirmation every time we can use task scheduler application of windows
That takes the task of running the .ps1 file with high priority which even wont ask for confirmation

So first save the SamsungMask.ps1 file where ever user require
SamsungMask.ps1
```pwsh
# Set registry values using PowerShell cmdlets
New-ItemProperty -Path 'HKLM:\HARDWARE\DESCRIPTION\System\BIOS' -Name 'SystemProductName' -Value 'NP960XFG-KC4UK' -PropertyType 'String' -Force
New-ItemProperty -Path 'HKLM:\HARDWARE\DESCRIPTION\System\BIOS' -Name 'SystemManufacturer' -Value 'Samsung' -PropertyType 'String' -Force
```
Or we can make use of commands that can copy this .ps1 to specific location, once we know the path of the file we can schedule the task for this file  

To schedule the task manually we can run the below commands in Powershell with administrator privillage one by one

First command set the action where we should specify the path of the .ps1 file (which we can get by manually moving the file and copying the file path `or` we can implement logic inside .ps1 file to move the file to specific location inside the windows computer and then to use that path)
```pwsh
$Action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument '-ExecutionPolicy Bypass -File "C:\Path\To\SamsungMask.ps1"'
```

Second command:
```pwsh
$Trigger = New-ScheduledTaskTrigger -AtStartup
```
Third Command:
```pwsh
$Principal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount
```

Fourth Command will set the task name as `SamsungMask`:
```pwsh
Register-ScheduledTask -Action $Action -Trigger $Trigger -Principal $Principal -TaskName "SamsungMask" -Force
```
This task can be viewed inside task scheduler software
<img src="path/to/your/image.jpg" alt="Your Image" width="300" height="200" />
