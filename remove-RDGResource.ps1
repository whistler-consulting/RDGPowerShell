Function Remove-RDGResource {
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact="Medium")]

    param (
        [parameter(Mandatory=$true)]
        [string]
        $ComputerName,

        [parameter(Mandatory=$true)]
        [string]
        $Name,

        [parameter(Mandatory=$true)]
        [string]
        $Resource
    )

    Begin{}
    
    Process{

        $a = @{
         ComputerName = $ComputerName
         Namespace = "Root\CIMv2\TerminalServices"
         Authentication = "PacketPrivacy"
         Class = "Win32_TSGatewayResourceGroup"
         ErrorAction = "Stop"
         Filter = "name=""$Name"""
        }
    
        try { 
            $RG = Get-WmiObject @a  
            }

        catch [System.Runtime.InteropServices.COMException]
        {
            if ($_.FullyQualifiedErrorId.StartsWith("GetWMICOMException"))
            {
                #Write-Error "Error Connecting to RPC Server"
            }
            else { throw }
        }


        if ($RG -ne $null -and $RG.name -eq $Name) {
    
            Write-Verbose "Found WMI object $RG"
        
            if ($RG.Resources.Split(";") -contains $Resource) {
                Write-Verbose "Resource list for group $Name contains $Resource"
                Write-Verbose "Attempting to remove"
                
                if ($PSCmdlet.ShouldProcess($Name,"Remove $Resource")) {
                    $result = $RG.RemoveResources($Resource)
                    Write-Verbose "RemoveResources returned $($result.ReturnValue)"
                }
            } else {
                Write-Verbose "Resource list for group $Name does not contain $Resource"
            }
        } else {
            Write-Verbose "WMI Object not found"
        }
    }

    End{}
}
