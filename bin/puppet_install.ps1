<#
# Derived from https://github.com/hashicorp/puppet-bootstrap/blob/master/windows.ps1

.SYNOPSIS
    Installs Puppet on this machine.
.DESCRIPTION
    Downloads and installs the Puppet-agent MSI package.
    This script requires administrative privileges.
    You can run this script from an old-style cmd.exe prompt using the
    following:
      powershell.exe -ExecutionPolicy Unrestricted -NoLogo -NoProfile -Command "& '.\puppet_install.ps1'"
.PARAMETER MsiUrl
    This is the URL to the Puppet MSI file you want to install. This defaults
    to a version from PuppetLabs.
.PARAMETER PuppetVersion
    This is the version of Puppet that you want to install. If you pass this it will override the version in the MsiUrl.
    This defaults to $null.
.PARAMETER PuppetMaster
    This is the hostname of the Puppet Master to use.
    This defaults to puppet.
.PARAMETER PuppetCertname
    This is the certname to use for the client.
    This defaults to puppet.
#>
param(
   [string]$MsiUrl = "https://downloads.puppetlabs.com/windows/puppet-agent-x64-latest.msi"
   ,[string]$PuppetVersion = $null
   ,[string]$PuppetMaster = "puppet"
   ,[string]$PuppetCertname = $null
)

if ($PuppetVersion) {
  $MsiUrl = "https://downloads.puppetlabs.com/windows/puppet-agent-x64-$($PuppetVersion).msi"
  Write-Host "Puppet version $PuppetVersion specified, updated MsiUrl to `"$MsiUrl`""
}
if ($PuppetCertname) {
  $CertnameArg = "PUPPET_AGENT_CERTNAME=$PuppetCertname"
} else {
  $CertnameArg = " "
}

$PuppetInstalled = $false
try {
  $ErrorActionPreference = "Stop";
  Get-Command puppet | Out-Null
  $PuppetInstalled = $true
  $PuppetVersion=&puppet "--version"
  Write-Host "Puppet $PuppetVersion is installed. This process does not ensure the exact version or at least version specified, but only that puppet is installed. Exiting..."
  Exit 0
} catch {
  Write-Host "Puppet is not installed, continuing..."
}

if (!($PuppetInstalled)) {
  $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
  if (! ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))) {
    Write-Host -ForegroundColor Red "You must run this script as an administrator."
    Exit 1
  }

  # Install it - msiexec will download from the url
  $install_args = @("/qn", "/norestart","/i", $MsiUrl, "PUPPET_MASTER_SERVER=$PuppetMaster", $CertnameArg)
  Write-Host "Installing Puppet. Running msiexec.exe $install_args"
  $process = Start-Process -FilePath msiexec.exe -ArgumentList $install_args -Wait -PassThru
  if ($process.ExitCode -ne 0) {
    Write-Host "Installer failed."
    Exit 1
  }

  # Stop the service that it autostarts
  Write-Host "Stopping Puppet service that is running by default..."
  Start-Sleep -s 5
  Stop-Service -Name puppet

  Write-Host "Puppet Agent successfully installed."
}
