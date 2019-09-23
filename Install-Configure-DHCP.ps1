// Variable
$DomainName = "kopicloud.local"
$DomainDNS1 = "10.10.64.5"
$DomainDNS2 = "10.10.64.6"
$DHCPServerName = "kopiaddc01" + "." + $DomainName
$DHCPServerIP = "10.10.64.6"
$DHCPScopeName = "Scope_50_to_150"
$DHCPScopeStart = "10.10.64.50"
$DHCPScopeEnd = "10.10.64.150"
$DHCPScopeSubnet = "255.255.254.0"

// Install DHCP Service
Install-WindowsFeature DHCP -IncludeManagementTools

// Authorize DHCP Server
Add-DhcpServerInDC -DnsName $DHCPServerDNS -IPAddress $DHCPServerIP

// Create DHCP Scope
Add-DhcpServerv4Scope -name $DHCPScopeName -StartRange $DHCPScopeStart -EndRange $DHCPScopeEnd -SubnetMask $DHCPScopeSubnet -State Active    

// Add DNS to Scope
Set-DhcpServerv4OptionValue -DnsDomain $DomainName -DnsServer $DomainDNS1,$DomainDNS2

// OPTIONAL - Add Exlusion to Scope
$DHCPScopeExclusionID = "10.10.64.0"
$DHCPScopeExclusionStart = "10.10.64.60"
$DHCPScopeExclusionEnd = "10.10.64.70"
Add-DhcpServerv4ExclusionRange -ScopeID $DHCPScopeExclusionID -StartRange $DHCPScopeExclusionStart -EndRange $DHCPScopeExclusionEnd
