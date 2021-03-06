Function New-RDGLab {
    [CmdletBinding()]

    param (

        [parameter(Mandatory=$true)]
        [string]
        $ComputerName,

        [parameter(Mandatory=$true)]
        [string]
        $POCIdentifier,

        [parameter(Mandatory=$true)]
        [string]
        $UserGroups,

        [parameter(Mandatory=$true)]
        [string]
        $Resources,

        [parameter(Mandatory=$true)]
        [string]
        $Description
    )


    #test to see if required resource Group exists:
    
    
    
    if (!(Test-WMIObject -Name $POCIdentifier -Class Win32_TSGatewayResourceGroup -Namespace "root\cimv2\terminalservices" -ComputerName $ComputerName))
        {
        $args = @{
            Name = $POCIdentifier.ToUpper()
            Description = "Auto-Provisioned: $Description"
            Resources = $Resources
            ComputerName = $ComputerName
            }

        $result = New-RDGResourceGroup @args
        }



    if (!(Test-WMIObject -Name $POCIdentifier -Class Win32_TSGatewayConnectionAuthorizationPolicy -Namespace "root\cimv2\terminalservices" -ComputerName $ComputerName))
        {
        $args = @{
            Name = $POCIdentifier.ToUpper()
            ComputerGroupName = ""
            UserGroupName = $UserGroups
            ComputerName = $ComputerName
            }

        $result = New-RDGCAP @args
        }

    if (!(Test-WMIObject -Name $POCIdentifier -Class Win32_TSGatewayResourceAuthorizationPolicy -Namespace "root\cimv2\terminalservices" -ComputerName $ComputerName))
        {
        $args = @{
            Name = $POCIdentifier.ToUpper()
            Description = "Auto-Provisioned: $Description"
            ResourceGroupName = $POCIdentifier.ToUpper()
            ResourceGroupType = "RG"
            ComputerName = $ComputerName
            UserGroupNames = $UserGroups
            }

        $result = New-RDGRAP @args
        }
}
