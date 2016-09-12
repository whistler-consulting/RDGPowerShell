Function New-RDGResourceGroup {
    [CmdletBinding()]

    param (
        [parameter(Mandatory=$true)]
        [string]
        $Name,

        [parameter(Mandatory=$false)]
        [string]
        $Description = "",

        [parameter(Mandatory=$true)]
        [string]
        $Resources,

        [parameter(Mandatory=$true)]
        [string]
        $ComputerName
    )


    $args = @($Description,$Name,$Resources)

    $a = @{
     ComputerName = $ComputerName
     Namespace = "Root\CIMv2\TerminalServices"
     Name = "Create"
     ArgumentList = $args
     Authentication = "PacketPrivacy"

     Class = "Win32_TSGatewayResourceGroup"
    }
    
    Invoke-WmiMethod @a
}
