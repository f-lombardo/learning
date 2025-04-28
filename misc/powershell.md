# PowerShell and bat related scripts

## How to upgrade Powershell

```powershell
winget upgrade --id Microsoft.PowerShell
```

## How to delete all files in a directory and its subdirectories based on file name

When you copy files from Mac to Windows, some files with prefix `._` appear. To remove them use:

```powershell
Get-ChildItem -Path .\ -Filter "._*" -Recurse -Force |
    Where-Object {$_.PSIsContainer -eq $false} |
    Remove-Item -Force -Verbose
```

To see which files will be removed before running the above script use:

```powershell
Get-ChildItem -Path .\ -Filter "._*" -Recurse -Force |
    Where-Object {$_.PSIsContainer -eq $false} |
    Select-Object -ExpandProperty FullName
```
