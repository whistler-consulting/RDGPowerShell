Import-Module C:\Users\MikeJenne\Documents\GitHub\RDGPowerShell\RDGModule.psm1 -Verbose -Force

if (Test-Path Variable:Global:RDGCredential) { Remove-Variable -Name RDGCredential }


New-RDGCredential -UserName jenne\mjenne

New-RDGResourceGroup -Name RG01 -Description "RG01 Description" -ComputerName 10.0.0.208 -Resources "10.0.0.201"

New-RDGRAP -Name "RAP01" -Description "RAP01 Description" -ResourceGroupName "RG01" -ResourceGroupType RG -UserGroupNames "jenne\domain users" -ComputerName 10.0.0.208

New-RDGRAP -Name RAP02 -Description "RAP02 Description" -ResourceGroupName "RG01" -ResourceGroupType RG -UserGroupNames "jenne\domain users" -ComputerName 10.0.0.208

Add-RDGResource -ComputerName 10.0.0.208 -Name RG01 -Resource 10.0.0.101 -Verbose

Add-RDGResource -ComputerName 10.0.0.208 -Name RG02 -Resource 10.0.0.100 -Verbose

Get-RDGResourceAuthorizationPolicy -ComputerName 10.0.0.208 -Name RAP01

Get-RDGResourceAuthorizationPolicy -ComputerName 10.0.0.208 | ft name










