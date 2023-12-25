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
![WhatsApp Image 2023-12-25 at 16 05 11_34fa92da](https://github.com/Sanjay0302/galaxybook_mask/assets/90672297/11e670e2-6117-42d8-beca-14ea0992f63b)

`So using this method the terminal popup is avoided but the Administrator confirmation UAC will be popped up that askes yes or no calling is `

SamsungMask.ps1
```pwsh
# Set registry values using reg.exe
Start-Process reg -ArgumentList 'add "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v SystemProductName /t REG_SZ /d "NP960XFG-KC4UK" /f' -Verb RunAs -Wait
Start-Process reg -ArgumentList 'add "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v SystemManufacturer /t REG_SZ /d "Samsung" /f' -Verb RunAs -Wait
```

runner.vbs
```vbs
Set objShell = CreateObject("WScript.Shell")
objShell.Run "powershell.exe -NoProfile -ExecutionPolicy Bypass -File ""path\to\SamsungMask.ps1""", 0, True
```
Dont Forget to change the path for `SamsungMask` in runner.vbs

