Function New-RDGConnectionAuthorizationPolicy {
    [CmdletBinding()]

    param (
        [parameter(Mandatory=$true)]
        [string]
        $Name,

        [parameter(Mandatory=$true)]
        [string]
        $ComputerGroupName = "",

        [parameter(Mandatory=$true)]
        [string]
        $UserGroupName = "",

        [parameter(Mandatory=$true)]
        [string]
        $ComputerName
    )


    $args = @(0,0,$ComputerGroupName,0,0,0,1,0,$Name,1,1,1,0,1,0,0,0,$UserGroupName)


    $a = @{
     ComputerName = $ComputerName
     Namespace = "Root\CIMv2\TerminalServices"
     Name = "Create"
     ArgumentList = $args
     Authentication = "PacketPrivacy"

     Class = "Win32_TSGatewayConnectionAuthorizationPolicy"
    }
    
    Invoke-WmiMethod @a
}
