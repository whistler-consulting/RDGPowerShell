Function Get-WMIMethodStaticMethodInput {
    [CmdletBinding()]

    param (
        [parameter(Mandatory=$false)]
        [string]
        $ComputerName = "localhost",

        [parameter(Mandatory=$false)]
        [string]
        $Namespace = "",

        [parameter(Mandatory=$true)]
        [string]
        $Class = "",

        [parameter(Mandatory=$true)]
        [string]
        $Method = "",

        [parameter(Mandatory=$false)]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    Begin {}

    Process {
    
        $a = @{}
        $a.Add("ComputerName",$ComputerName)
        $a.Add("Namespace",$Namespace)
        $a.Add("List","")
        $a.Add("Authentication","PacketPrivacy")
    
    
        if ($Credential -ne $null) { 
            $a.Add("Credential",$Credential) 
        } else {
            if (Test-Path Variable:Global:RDGCredential) { $a.Add("Credential",$RDGCredential) }
        }
  
        $c = Get-WmiObject @a | Where-Object {$_.Name -eq $Class}

        $c.psbase.GetMethodParameters($Method) 
    }

    End {}
}

