Function Get-RDGResourceGroupResources {
    [CmdletBinding()]

    param (

        [parameter(Mandatory=$true)]
        [string]
        $ComputerName,

        [parameter(Mandatory=$true)]
        [string]
        $Name,

        [parameter(Mandatory=$false)]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    Begin{}
    
    Process{

        $a = @{}
        $a.Add("ComputerName", $ComputerName)
        $a.Add("Namespace", "Root\CIMv2\TerminalServices")
        $a.Add("Authentication", "PacketPrivacy")
        $a.Add("Class", "Win32_TSGatewayResourceGroup")
        $a.Add("ErrorAction", "Stop")
        $a.Add("Filter", "name=""$Name""" )
        
        if ($Credential -ne $null) { 
            $a.Add("Credential",$Credential) 
        } else {
            if (Test-Path Variable:Global:RDGCredential) { $a.Add("Credential",$RDGCredential) }
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