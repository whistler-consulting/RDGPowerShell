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
        $Resource,

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
        $a.Add("Filter", "name=""$Name""")
        
        if ($Credential -ne $null) { 
            $a.Add("Credential",$Credential) 
        } else {
            if (Test-Path Variable:Global:RDGCredential) { $a.Add("Credential",$RDGCredential) }
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
        $Resource,

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
        $a.Add("Filter", "name=""$Name""")

        if ($null -ne $Credential) {
            $a.Add("Credential", $Credential)
        } else {
            if (Test-Path Variable:Global:RDGCredential) { $a.Add("Credential", $RDGCredential) }
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
