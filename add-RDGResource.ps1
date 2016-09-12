Function Add-RDGResource {
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
                Write-Verbose "Resource list for group $Name already contains $Resource"
            } else {
                Write-Verbose "Resource list for group $Name does not already contain $Resource and attempting to add"
            
                if ($PSCmdlet.ShouldProcess($Name, "Add $Resource")) { 
                    $result = $RG.AddResources($Resource) 
                    Write-Verbose "AddResources returned $($result.ReturnValue)"
                }
            }
        } else {
            Write-Verbose "WMI Object not found"
        }
    }

    End{}

}
