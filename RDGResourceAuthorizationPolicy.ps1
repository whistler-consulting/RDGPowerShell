Function Get-RDGResourceAuthorizationPolicy {
    [CmdletBinding()]

    param (
        [parameter(Mandatory=$true)]
        [string]
        $ComputerName,

        [parameter(Mandatory=$false)]
        [string]
        $Name,

        [parameter(Mandatory=$false)]
        [System.Management.Automation.PSCredential]
        $Credential

    )

    Begin {}

    Process {

    $a = @{}
    $a.Add("ComputerName",$ComputerName)
    $a.Add("Namespace", "Root\CIMv2\TerminalServices")
    $a.Add("Authentication", "PacketPrivacy")

    if ([string]::IsNullOrEmpty($Name)) { 

        $a.Add("Class","Win32_TSGatewayResourceAuthorizationPolicy")

    } else {

        $a.Add("Query","select * from Win32_TSGatewayResourceAuthorizationPolicy where name=""$Name""")

    }
    

    if ($Credential -ne $null) { 
        $a.Add("Credential",$Credential) 
    } else {
        if (Test-Path Variable:Global:RDGCredential) { $a.Add("Credential",$RDGCredential) }
    }
    
    Get-WmiObject @a

    }

    End {}
}

Function Remove-RDGResourceAuthorizationPolicy {
    [CmdletBinding()]

    param (
        [parameter(Mandatory=$true)]
        [string]
        $ComputerName,

        [Parameter(Mandatory=$true,
                    ValueFromPipeline=$true)]
        [string[]]
        $Names,

        [parameter(Mandatory=$false)]
        [System.Management.Automation.PSCredential]
        $Credential

    )

    Begin {}

    Process { 

        Write-Verbose "In Remove-RDGResourceAuthorizationPolicy"

        $Names | ForEach-Object {

            $Name = $_ 


            $a = @{}
            $a.Add("ComputerName",$ComputerName)
            $a.Add("Name", $Name)

            if ($Credential -ne $null) { 
                $a.Add("Credential",$Credential) 
            } else {
                if (Test-Path Variable:Global:RDGCredential) { 
                    Write-Verbose "..Get-RDGResourceAuthorizationPolicy Using RDGCredential"
                    $a.Add("Credential",$RDGCredential) 
                }
            }
    
            $RAP = Get-RDGResourceAuthorizationPolicy @a

            if ($null -ne $RAP) { 
            
                Write-Verbose "Found ResourceAuthorizationPolicy ""$Name"" on server $ComputerName" 
            } else {
                Write-Error "ResourceAuthorizationPolicy Named ""$Name"" NOT found on server $ComputerName"
            }

            $RAP | Where-Object {$_.Name -eq $Name} | ForEach-Object { $_.Delete() }

        }

    }

    End {}
}

Function New-RDGConnectionAuthorizationPolicy {
    [CmdletBinding()]

    param (
        [parameter(Mandatory=$true)]
        [string]
        $Name,

        [parameter(Mandatory=$true)]
        [string]
        $ComputerGroupName = "",

        [parameter(Mandatory=$true)]
        [string]
        $UserGroupName = "",

        [parameter(Mandatory=$true)]
        [string]
        $ComputerName
    )

    Begin {}

    Process {

        $args = @(0,0,$ComputerGroupName,0,0,0,1,0,$Name,1,1,1,0,1,0,0,0,$UserGroupName)


        $a = @{
         ComputerName = $ComputerName
         Namespace = "Root\CIMv2\TerminalServices"
         Name = "Create"
         ArgumentList = $args
         Authentication = "PacketPrivacy"

         Class = "Win32_TSGatewayConnectionAuthorizationPolicy"
        }

    
        if ($Credential -ne $null) { 
            $a.Add("Credential",$Credential) 
        } else {
            if (Test-Path Variable:Global:RDGCredential) { $a.Add("Credential",$RDGCredential) }
        }
    
    
        Invoke-WmiMethod @a
    }

    End {}
}


