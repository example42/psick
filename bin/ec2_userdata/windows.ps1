<powershell>
<#
  Sample ec2_userdata script for installation of Puppet Enterprise agent
  on Windows instances on AWS
  Change URL of the Puppet Server (here: puppet.aws.psick.io)
  Default client certname is $instanceID.aws.psick.io, adapt as needed.
#>

Set-ExecutionPolicy Unrestricted
$id = (Invoke-WebRequest -Uri http://169.254.169.254/latest/meta-data/instance-id).content
[Net.ServicePointManager]::ServerCertificateValidationCallback = {$true};
$webClient = New-Object System.Net.WebClient;
$webClient.DownloadFile('https://puppet.aws.psick.io:8140/packages/2017.1.1/install.ps1', 'install.ps1');
powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -File .\install.ps1 agent:certname=$id.aws.psick.io  extension_requests:pp_role=norole extension_requests:pp_environment=production extension_requests:pp_preshared_key=
</powershell>

