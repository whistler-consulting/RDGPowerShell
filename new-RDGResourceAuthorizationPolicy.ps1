Function New-RDGResourceAuthorizationPolicy {
    [CmdletBinding()]

    param (
        [parameter(Mandatory=$true)]
        [string]
        $Name,

        [parameter(Mandatory=$true)]
        [string]
        $Description,

        [parameter(Mandatory=$true)]
        [string]
        $ResourceGroupName,

        [parameter(Mandatory=$true)]
        [string]
        $ResourceGroupType,

        [parameter(Mandatory=$true)]
        [string]
        $UserGroupNames,

        [parameter(Mandatory=$true)]
        [string]
        $ComputerName
    )


    $args = @($Description,1,$Name,3389,"RDP",$ResourceGroupName,$ResourceGroupType,$UserGroupNames)

    $a = @{
     ComputerName = $ComputerName
     Namespace = "Root\CIMv2\TerminalServices"
     Name = "Create"
     ArgumentList = $args
     Authentication = "PacketPrivacy"

     Class = "Win32_TSGatewayResourceAuthorizationPolicy"
    }
    
    Invoke-WmiMethod @a
}
