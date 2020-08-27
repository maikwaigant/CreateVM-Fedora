Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false | Out-Null

$VI_SERVER = (Get-ChildItem ENV:VI_SERVER).Value
$VI_USERNAME = (Get-ChildItem ENV:VI_USERNAME).Value
$VI_PASSWORD = (Get-ChildItem ENV:VI_PASSWORD).Value
$VI_VM = (Get-ChildItem ENV:VI_VM).Value
$VI_VMNAME = (Get-ChildItem ENV:VI_VMNAME).Value

Write-Host -ForegroundColor magenta "Variables from Docker Client ..."
Write-Host "VI_SERVER=$VI_SERVER"
Write-Host "VI_USERNAME=$VI_USERNAME"
Write-Host "VI_PASSWORD=$VI_PASSWORD"
Write-Host "VI_VM=$VI_VM"
Write-Host "VI_VMNAME=$VI_VMNAME"

Write-Host "`nConnecting to vCenter Server ..."
Connect-VIServer -Server $VI_SERVER -User $VI_USERNAME -password $VI_PASSWORD | Out-Null

Write-Host "Create VM ..."
New-VM -Name $VI_VMNAME -VMHost 10.133.250.201 -GuestId fedora64Guest `
-NumCpu 4 -MemoryMB 16384 -DiskMB 60000 -Datastore DataStoreHDD -Version v12 -NetworkName 'PG WAN 1'
Start-VM -VM $VI_VMNAME -Confirm -RunAsync

Write-Host "Disconnecting ...`n"
Disconnect-VIServer * -Confirm:$false
