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
    $hour = Get-Date -Format "HH:mm:ss"
    if ((Get-History).count -ge 1)
    {
        $executionTime = ((Get-History)[-1].EndExecutionTime - (Get-History)[-1].StartExecutionTime).Totalmilliseconds
        $time = [math]::Round($executionTime, 0)
        $basePrompt = "PS $time ms | $hour | $($executionContext.SessionState.Path.CurrentLocation)> "
    } else {
        $basePrompt = "PS $hour | $($executionContext.SessionState.Path.CurrentLocation)> "
    }

    $hasError = -not $?
    $exitCode = if ($null -ne $LASTEXITCODE) { $LASTEXITCODE } else { 0 }

    if ($hasError -or ($exitCode -ne 0)) {
        Write-Host $basePrompt -ForegroundColor Red -NoNewline
    } else {
        Write-Host $basePrompt -NoNewline
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

So we can write something similar to the `su` command:

```powershell
function su {
	Start-Process pwsh -Verb runAs
}
```

## Set and show environment variables

```powershell
$env:MY_VAR=xx
dir env:
```
