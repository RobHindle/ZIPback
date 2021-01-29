Welcome to ReadMe.txt ReadMeZIPbackup.txt for ZIPbackup2E tool.

Disclaimer:  Use these tools at your own choosing and risk.

ZIPbackup2E.txt is provided if your organization is uncomfortable with transfering in .ps1 files.

ZIPbackup2E tool provide for crude manifest backup capability that:
      Can backup files as plain files
      Can backup through the ZIP compression
      Can backup through a first level of Children ZIP compression files.

This backup function can be programmed into ShortCuts or ScheduledTasks like: 
%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -executionpolicy Bypass -Windowstyle Hidden -file "<FullPath>\ZIPbackup2E.ps1" 
Backups are dateed into folders of Bkup<Date-Time> so you know what your backup points are.

You will see a HashProfile<Date-Time>.txt that has Hash value confirmations of the untampered file in this project.
	Independantly you will see this same file published at https://web.ncf.ca/bv178/HashChecks.html
Hash Confirmations only provide comfort to mitigate tampering.