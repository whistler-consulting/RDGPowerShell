. $psScriptRoot/rdgresource.ps1

. $psScriptRoot/rdgresourcegroup.ps1

. $psScriptRoot/rdgresourcegroupresources.ps1

. $psScriptRoot/get-wmimethodstaticmethodinput.ps1

. $psScriptRoot/RDGConnectionAuthorizationPolicy.ps1

. $psScriptRoot/new-RDGLab.ps1

. $psScriptRoot/RDGResourceAuthorizationPolicy

. $psScriptRoot/rdgresourcegroup.ps1

#. $psScriptRoot/test-wmiobject.ps1

. $psScriptRoot/RDGCredential.ps1



New-Alias -Name New-RDGRAP -Value New-RDGResourceAuthorizationPolicy
New-Alias -Name New-RDGCAP -Value New-RDGConnectionAuthorizationPolicy



