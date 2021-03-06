Function New-RDGCredential {
    [CmdletBinding(DefaultParameterSetName = "byNothing")]

    param (
        [parameter(Mandatory=$true, ParameterSetName = "ByUsername")]
        [ValidateNotNullorEmpty()]
        [string]
        $UserName,

        [parameter(Mandatory=$true, ParameterSetName = "ByCred")]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    Begin {}

    Process {


        switch ($PSCmdlet.ParameterSetName) {

        "ByUsername" { 
            Write-Debug "ParameterSetName is ByUsername" 

            if (Test-Path Variable:Global:RDGCredential) { Remove-Variable -Name RDGCredential }
        
            New-Variable -Name RDGCredential -Scope GLOBAL -Value (Get-Credential $UserName)
            }

        "ByCred" { 
        
            Write-Debug "ParameterSetName is ByCred" 

            if (Test-Path Variable:Global:RDGCredential) { Remove-Variable -Name RDGCredential }

            New-Variable -Name RDGCredential -Scope Global -Value $Credential
            }

        "ByNothing" { 
            Write-Debug "ParameterSetName is ByNothing"

            #need to call function help and stop
            }

        }
    }

    End {}

}
