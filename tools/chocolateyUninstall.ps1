$ErrorActionPreference = 'Stop'

$storeId = '9N7JSXC1SJK6'

# Windows 10 Version 1809 (Build 17763) oder neuer
if ([Environment]::OSVersion.Version.Build -lt 17763) {
  throw 'winget benoetigt mindestens Windows 10 Version 1809 (Build 17763).'
}

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
  throw 'winget (App Installer) wurde nicht gefunden.'
}

winget uninstall --id $storeId --source msstore --silent

# 0x8A150014 = Paket nicht gefunden (bereits entfernt)
if ($LASTEXITCODE -ne 0 -and $LASTEXITCODE -ne -1978335212) {
  throw "winget wurde mit Exit-Code $LASTEXITCODE beendet."
}
