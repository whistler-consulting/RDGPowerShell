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
        [ValidateSet("RG","CG","All")]
        [string]
        $ResourceGroupType,

        [parameter(Mandatory=$true)]
        [string]
        $UserGroupNames,

        [parameter(Mandatory=$true)]
        [string]
        $ComputerName,

        [parameter(Mandatory=$false)]
        [System.Management.Automation.PSCredential]
        $Credential

    )

    Begin {}

    Process {


    $args = @($Description,1,$Name,3389,"RDP",$ResourceGroupName,$ResourceGroupType,$UserGroupNames)

    $a = @{}
        $a.Add("ComputerName",$ComputerName)
        $a.Add("Namespace", "Root\CIMv2\TerminalServices")
        $a.Add("Name", "Create")
        $a.Add("ArgumentList", $args)
        $a.Add("Authentication", "PacketPrivacy")
        $a.Add("Class", "Win32_TSGatewayResourceAuthorizationPolicy")
    

    if ($Credential -ne $null) { 
        $a.Add("Credential",$Credential) 
    } else {
        if (Test-Path Variable:Global:RDGCredential) { $a.Add("Credential",$RDGCredential) }
    }
    
    Invoke-WmiMethod @a

    }

    End {}
}
