Function Get-RDGResourceGroupResources {
    [CmdletBinding()]

    param (

        [parameter(Mandatory=$true)]
        [string]
        $ComputerName,

        [parameter(Mandatory=$true)]
        [string]
        $Name
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
            # force results into collection
            $RG = @(Get-WmiObject @a)
            }

        catch [System.Runtime.InteropServices.COMException]
        {
            if ($_.FullyQualifiedErrorId.StartsWith("GetWMICOMException"))
            {
                #Write-Error "Error Connecting to RPC Server"
            }
            else { throw }
        }

        if ($RG -ne $null -and $RG.Length -eq 1) {
        
            Write-Verbose "Found WMI object $RG"

			$Resources = @($RG[0].Resources.Split(";"))

            $Resources

         
        } else {
            Write-Verbose "WMI Object not found"
        }


    }

    End{}

}