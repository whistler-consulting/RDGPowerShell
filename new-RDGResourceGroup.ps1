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
