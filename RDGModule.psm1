. $psScriptRoot/RDGResource.ps1

. $psScriptRoot/RDGResourceGroup.ps1

. $psScriptRoot/RDGResourceGroupResources.ps1

. $psScriptRoot/RDGConnectionAuthorizationPolicy.ps1

. $psScriptRoot/new-RDGLab.ps1

. $psScriptRoot/RDGResourceAuthorizationPolicy

. $psScriptRoot/RDGResourceGroup.ps1

. $psScriptRoot/RDGCredential.ps1



New-Alias -Name New-RDGRAP -Value New-RDGResourceAuthorizationPolicy
New-Alias -Name New-RDGCAP -Value New-RDGConnectionAuthorizationPolicy



