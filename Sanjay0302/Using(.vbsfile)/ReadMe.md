#### Trying Silent update using .vbs file and .ps1 file

So This [folder](https://github.com/Sanjay0302/galaxybook_mask/new/main/Sanjay0302/Using(.vbsfile)) conatins one method of Changing the registry values

`.bat` always calls a cmd prompt whenever the device starts and the user dont want to see that popup even it is for small amount of time


So i tried to use two diffrent files here
1. The .ps1 file consist of Registry changes commands (But they need administrator privilages manually that pop's up when device starts)
2. And to run this .ps1 file without popping up the terminal - I included .vbs file as runner for the .ps1 file
  - `Note I only tried to add the method we can use`
  - So we need to mention the Path for the .ps1 file in .vbs file
3. Note that these 2 files has to be moved to manually `C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp` to run at startup as i have not included any logic to copy these files to the startup folder i mentioned. Ofcource we can add that commands for copying if we want.

`This Popup will be shown instead of terminal every time the device startup `

<img src="https://github.com/Sanjay0302/galaxybook_mask/assets/90672297/11e670e2-6117-42d8-beca-14ea0992f63b" alt="Admin confirmation window" width="300" height="200" />

`So using this method the terminal popup is avoided but the Administrator confirmation UAC will be popped up that askes yes or no evrytime the system starts `

`SamsungMask.ps1`

```pwsh
# SamsungMask.ps1
# Set registry values using reg.exe
Start-Process reg -ArgumentList 'add "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v SystemProductName /t REG_SZ /d "NP960XFG-KC4UK" /f' -Verb RunAs -Wait
Start-Process reg -ArgumentList 'add "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v SystemManufacturer /t REG_SZ /d "Samsung" /f' -Verb RunAs -Wait
```

`runner.vbs`

```vbs
Set objShell = CreateObject("WScript.Shell")
objShell.Run "powershell.exe -NoProfile -ExecutionPolicy Bypass -File ""path\to\SamsungMask.ps1""", 0, True
```
Dont Forget to change the path of `SamsungMask.ps1` in `runner.vbs`




`ChatGpt Explaination below`
If the UAC (User Account Control) prompt is persisting, it means that the operation requires administrative privileges, and UAC is configured to prompt for confirmation. Unfortunately, completely bypassing UAC prompts programmatically is generally not recommended for security reasons.

However, if you want to minimize the UAC prompts, you can consider creating a scheduled task to run the PowerShell script with the highest privileges. This way, the task scheduler may handle the elevation without prompting. Here's how you can modify your approach:

1. **Create a PowerShell script (`SetRegistryValues.ps1`):**
   ```powershell
   # Set registry values using PowerShell cmdlets
   New-ItemProperty -Path 'HKLM:\HARDWARE\DESCRIPTION\System\BIOS' -Name 'SystemProductName' -Value 'NP960XFG-KC4UK' -PropertyType 'String' -Force
   New-ItemProperty -Path 'HKLM:\HARDWARE\DESCRIPTION\System\BIOS' -Name 'SystemManufacturer' -Value 'Samsung' -PropertyType 'String' -Force
   ```

2. **Create a scheduled task PowerShell script (`RunPowerShellTask.ps1`):**
   ```powershell
   $Action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument '-ExecutionPolicy Bypass -File "C:\Path\To\SetRegistryValues.ps1"'
   $Trigger = New-ScheduledTaskTrigger -AtStartup
   $Principal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount
   Register-ScheduledTask -Action $Action -Trigger $Trigger -Principal $Principal -TaskName "SetRegistryValuesTask" -Force
   ```

   Replace `"C:\Path\To\SetRegistryValues.ps1"` with the actual path to your PowerShell script.

3. **Run the scheduled task script as administrator:**
   Open an elevated PowerShell prompt and run the following command:
   ```powershell
   .\RunPowerShellTask.ps1
   ```

This approach creates a scheduled task to run the PowerShell script at startup with elevated privileges. The task scheduler may handle the elevation without prompting for user confirmation. Please note that creating scheduled tasks requires administrative rights.

Remember that bypassing UAC prompts may have security implications, and it's important to understand the risks associated with such actions.

