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
        $ComputerName
    )

    $TestCollection = @(Get-WmiObject -Class $class -Namespace $Namespace -ComputerName $ComputerName -Authentication PacketPrivacy | Where-Object {$_.Name -eq $Name} )

    if ($TestCollection.Length -eq 0) { return $false }
    else { return $true }
}
