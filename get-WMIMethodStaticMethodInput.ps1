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
        $Method = ""
    )


    $c = Get-WmiObject -ComputerName $ComputerName -Namespace $Namespace -List -Authentication PacketPrivacy  | Where-Object {$_.Name -eq $Class}

    $c.psbase.GetMethodParameters($Method) 
}

