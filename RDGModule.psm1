. $psScriptRoot/add-rdgresource.ps1
. $psScriptRoot/remove-rdgresource.ps1

. $psScriptRoot/get-rdgresourcegroup.ps1

. $psScriptRoot/get-rdgresourcegroupresources.ps1

. $psScriptRoot/get-wmimethodstaticmethodinput.ps1

. $psScriptRoot/new-RDGConnectionAuthorizationPolicy.ps1

. $psScriptRoot/new-RDGLab.ps1

. $psScriptRoot/new-RDGResourceAuthorizationPolicy

. $psScriptRoot/new-rdgresourcegroup.ps1

. $psScriptRoot/test-wmiobject.ps1

. .\

New-Alias -Name New-RDGRAP -Value New-RDGResourceAuthorizationPolicy
New-Alias -Name New-RDGCAP -Value New-RDGConnectionAuthorizationPolicy



