$ErrorActionPreference = 'Stop'

$storeId = '9N7JSXC1SJK6'   # Blip: Send Files in a Click

# Windows 10 Version 1809 (Build 17763) or later
if ([Environment]::OSVersion.Version.Build -lt 17763) {
  throw 'winget requires at least Windows 10 version 1809 (Build 17763).'
}

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
  throw 'winget (App Installer) was not found.'
}

winget install --id $storeId --source msstore --exact --accept-package-agreements --accept-source-agreements --silent

# Exit codes that indicate success:
#   0x8A150061 (-1978335135) = Package is already installed
#   0x8A15002B (-1978335189) = App is already installed; no update available
$okCodes = @(0, -1978335135, -1978335189)
if ($okCodes -notcontains $LASTEXITCODE) {
  throw "winget was terminated with exit code $LASTEXITCODE."
}
