Function Get-RDGResourceGroup {
    [CmdletBinding()]

    param (

        [parameter(Mandatory=$true)]
        [string]
        $ComputerName,

        [parameter(Mandatory=$false)]
        [string]
        $Name = "",

        [Parameter(Mandatory=$false)]
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

        if ($Name -ne "") {          
            $a.Add("Filter","name=""$Name""") 
        }

        if ($Credential -ne $null ) {
            $a.Add("Credential", $Credential)
        } else {
            if (Test-Path Variable:Global:RDGCredential) { $a.Add("Credential", $RDGCredential) }
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
        $ComputerName,

        [parameter(Mandatory=$false)]
        [System.Management.Automation.PSCredential]
        $Credential

    )

    Begin {}

    Process {


        $args = @($Description,$Name,$Resources)

        $a = @{}
 
        $a.Add("ComputerName", $ComputerName)
        $a.Add("Namespace", "Root\CIMv2\TerminalServices")
        $a.Add("Name", "Create")
        $a.Add("ArgumentList", $args)
        $a.Add("Authentication", "PacketPrivacy")
        $a.Add("Class", "Win32_TSGatewayResourceGroup")
    
        if ($Credential -ne $null) { 
            $a.Add("Credential",$Credential) 
        } else {
            if (Test-Path Variable:Global:RDGCredential) { $a.Add("Credential",$RDGCredential) }
        }
        
        Invoke-WmiMethod @a
    }

    End {}
}
