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

## Powershell prompt
Here is a function to customise your powershell prompt. Put it into `$home\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`:

```powershell
function prompt {
    $hasError = -not $?
    $exitCode = if ($null -ne $LASTEXITCODE) { $LASTEXITCODE } else { 0 }

    if ($hasError -or ($exitCode -ne 0)) {
        Write-Host "PS $($executionContext.SessionState.Path.CurrentLocation)> " -ForegroundColor Red -NoNewline
    } else {
        Write-Host "PS $($executionContext.SessionState.Path.CurrentLocation)> " -NoNewline
    }

    return " "
}
```

## Show full commands history

```powershell
cat (Get-PSReadlineOption).HistorySavePath
```

## Run as administrator

```powershell
Start-Process pwsh -Verb runAs
```

## Set and show environment variables

```powershell
$env:MY_VAR=xx
dir env:
```
