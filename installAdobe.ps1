# Trying to install Adobe via winget
$Log = "$env:temp\winget.log"

Write-host "$(Get-Date): Los gehts..." | Out-File -FilePath $Log
Write-host "$(Get-Date):  Proxy setzen" | Out-File -FilePath $Log
# Lab-Proxy
[string]$userName = 'markus.zehnle@adm.braincon.cloud'
[string]$userPass = 'fnov8588'
# Convert to SecureString
[securestring]$secStringPassword = ConvertTo-SecureString $userPass -AsPlainText -Force
[pscredential]$credObject = New-Object System.Management.Automation.PSCredential ($userName, $secStringPassword)

[system.net.webrequest]::defaultwebproxy = new-object system.net.webproxy('http://proxy.lab.braincon.de:3128')
$proxycredentials = $credObject
[system.net.webrequest]::defaultwebproxy.credentials = $proxycredentials
$null = [system.net.webrequest]::defaultwebproxy.BypassArrayList.Add("*.lab.braincon.de")
$null = [system.net.webrequest]::defaultwebproxy.BypassArrayList.Add("lab.braincon.de")
$null = [system.net.webrequest]::defaultwebproxy.BypassArrayList.Add("10.*")
$null = [system.net.webrequest]::defaultwebproxy.BypassArrayList.Add("192.168.*")
[system.net.webrequest]::defaultwebproxy.BypassProxyOnLocal = $true
Write-host "$(Get-Date):  Proxy gesetzt" | Out-File -FilePath $Log

Write-host "$(Get-Date):  Installation Adobe Reader DC via winget" | Out-File -FilePath $Log
# Install Adobe Reader DC
#winget install -e --id Adobe.Acrobat.Reader.64-bit
winget install "Adobe Acrobat Reader DC" --source msstore --accept-package-agreements --accept-source-agreements --silent
Write-host "$(Get-Date):  winget fertig" | Out-File -FilePath $Log
Write-host "$(Get-Date): Fertig..." | Out-File -FilePath $Log
