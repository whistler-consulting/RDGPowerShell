$co = New-CimSessionOption -Impersonation Impersonate -PacketIntegrity -PacketPrivacy 

$cs = New-CimSession -ComputerName 10.0.0.208 -Credential (Get-Credential jenne\mjenne) -SessionOption $co -Authentication NtlmDomain


#Get-CimInstance -CimSession $cs -ClassName "Win32_operatingsystem" -Verbose

Get-CimClass -CimSession $cs -ClassName "Win32_TSGatewayConnectionAuthorizationPolicy" -Namespace "Root\CIMv2\TerminalServices" -Verbose

Get-CimInstance -CimSession $cs -ClassName "Win32_TSGatewayConnectionAuthorizationPolicy" -Namespace "Root\CIMv2\TerminalServices" -Verbose

#Get-CimClass -CimSession $cs -Namespace "Root\CIMv2\TerminalServices" 





