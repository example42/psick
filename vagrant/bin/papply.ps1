<#

.SYNOPSIS
    Runs puppet apply from within a Vagrant VM
.DESCRIPTION
    Runs puppet apply command using Puppet code and data mounted in c:\vagrant_puppet.
.PARAMETER Manifest
    The name of the manifest to apply.
    Default is C:\vagrant_puppet\manifests\site.pp
.PARAMETER Options
    Optional options to pass to puppet command (ie: --debug).
    This defaults to $null.
#>
param(
   [string]$Manifest = "C:\vagrant_puppet\manifests\site.pp"
   ,[string]$Options = $null
)

$BaseDir="C:\vagrant_puppet\"
$env:Path += ";C:\Program Files\Puppet Labs\Puppet\puppet\bin"

Write-Host "Running Puppet apply on $Manifest."

$InstallArgs = @("apply", "--test", "--report", "--summarize", "--modulepath", "$BaseDir/site:$BaseDir/modules:/etc/puppet/modules", "--environmentpath", "C:\", "--environment", "vagrant_puppet", "--detailed-exitcodes", "$Options", $Manifest)

$InstallArg = "apply --test --report --summarize --modulepath $BaseDir/site:$BaseDir/modules:/etc/puppet/modules --environmentpath C:\ --environment vagrant_puppet --detailed-exitcodes $Options $Manifest"

#$process = Start-Process -FilePath puppet $InstallArg -Wait -PassThru
#$process = Start-Process -FilePath puppet -ArgumentList "$InstallArg" -Wait -PassThru
Start-Process -FilePath puppet -ArgumentList "$InstallArg" -Wait -PassThru

#if ($process.ExitCode -ne 0 -and $process.ExitCode -ne 2) {
#  Write-Host "Errors in the Puppet run."
#  Exit 1
#}

