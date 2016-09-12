Function Get-RDGResourceGroup {
    [CmdletBinding()]

    param (

        [parameter(Mandatory=$true)]
        [string]
        $ComputerName,

        [parameter(Mandatory=$false)]
        [string]
        $Name = ""
    )

    Begin{}
    
    Process{
        $a = @{
         ComputerName = $ComputerName
         Namespace = "Root\CIMv2\TerminalServices"
         Authentication = "PacketPrivacy"
         Class = "Win32_TSGatewayResourceGroup"
         ErrorAction = "Stop"
        }

        if ($Name -ne "") 
            {          
            $a.Add("Filter","name=""$Name""") 
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

        if ($RG -ne $null -and $RG.Length -ge 1) {
        
            Write-Verbose "Found WMI object $RG"

           $RG 

         
        } else {
            Write-Verbose "WMI Object not found"
        }


    }

    End{}

}
