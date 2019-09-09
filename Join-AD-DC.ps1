# Variables
$DomainName = "kopicloud.local"
$DomainNetbiosName = "KOPICLOUD"
$DatabasePath = "C:\Windows\NTDS"
$SysvolPath = "C:\Windows\SYSVOL"
$LogPath = "C:\Windows\NTDS"
$SafeModeAdministratorPassword = "S3cr3t0"
$ADAdmin = "kopiadmin"
$ADPassword = "Ch@ng3M3N0w"

# Import ServerManager 
Import-Module ServerManager 
 
# Install AD & DNS Features
Install-WindowsFeature AD-Domain-Services -IncludeAllSubFeature -IncludeManagementTools 
Install-WindowsFeature DNS -IncludeAllSubFeature -IncludeManagementTools 

# Import Management Modules
Import-Module ADDSDeployment 
Import-Module DnsServer 

# Credentials
$User = $DomainNetbiosName + "\" + $ADAdmin
$PWord = ConvertTo-SecureString -String $ADPassword -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
 
# Install and Configure AD
Install-ADDSDomainController `
-DomainName $DomainName `
-Credential $Credential `
-InstallDns:$true `
-DatabasePath $DatabasePath `
-SysvolPath $SysvolPath `
-LogPath $LogPath `
-Force:$true `
-NoRebootOnCompletion:$false `
-SafeModeAdministratorPassword `
    (ConvertTo-SecureString $SafeModeAdministratorPassword -AsPlainText -Force)
