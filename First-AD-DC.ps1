# Variables
$DomainName = "kopicloud.local"
$DomainNetbiosName = "KOPICLOUD"
$DomainMode = "Win2012R2"
$DatabasePath = "C:\Windows\NTDS"
$SysvolPath = "C:\Windows\SYSVOL"
$LogPath = "C:\Windows\NTDS"
$SafeModeAdministratorPassword = "S3cr3t0"

# Import ServerManager 
Import-Module ServerManager 
 
# Install AD & DNS Features
Install-WindowsFeature AD-Domain-Services -IncludeAllSubFeature -IncludeManagementTools 
Install-WindowsFeature DNS -IncludeAllSubFeature -IncludeManagementTools 

# Import Management Modules
Import-Module ADDSDeployment 
Import-Module DnsServer 
 
# Install and Configure AD
Install-ADDSForest `
-DomainName $DomainName `
-DomainNetbiosName $DomainNetbiosName `
-DomainMode $DomainMode `
-ForestMode $DomainMode `
-DatabasePath $DatabasePath `
-SysvolPath $SysvolPath `
-LogPath $LogPath `
-InstallDns:$true `
-NoRebootOnCompletion:$false `
-Force:$true `
-SafeModeAdministratorPassword `
    (ConvertTo-SecureString $SafeModeAdministratorPassword -AsPlainText -Force)
