Function Test-WMIObject {
    [CmdletBinding()]

    param (
        [parameter(Mandatory=$true)]
        [string]
        $Name,

        [parameter(Mandatory=$true)]
        [string]
        $Class,

        [parameter(Mandatory=$true)]
        [string]
        $Namespace,

        [parameter(Mandatory=$true)]
        [string]
        $ComputerName,

        [parameter(Mandatory=$false)]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    Begin {}

    Process {

        $a = @{}
        $a.Add("ComputerName", $ComputerName)
        $a.Add("Namespace", $Namespace)
        $a.Add("Authentication", "PacketPrivacy")
        $a.Add("Impersonation", "Impersonate")
        $a.Add("Class", $Class)
        $a.Add("ErrorAction", "Stop")

        if ($null -ne $Credential) {
            $a.Add("Credential",$Credential) 
        } else {
            if (Test-Path Variable:Global:RDGCredential) { $a.Add("Credential",$RDGCredential) }
        }
  
        $TestCollection = @(Get-WmiObject @a | Where-Object {$_.Name -eq $Name} )

        if ($TestCollection.Length -eq 0) { 
            return $false 
        
        } else {
            return $true 
        }
    }

    End {}
}
