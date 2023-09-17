# parse the sitecore.json file for the XM Cloud plugin version
[CmdletBinding(DefaultParameterSetName = 'FromArgs')]
param (
    [Parameter(Mandatory)]
    [string]$JsonFile
)


$userJson = "$PSScriptRoot/../../.sitecore/$JsonFile"

if (-not (Test-Path $userJson)) {
    Write-Error "The specified file '$userJson' does not exist."
    return
}

$userJson = Get-Content $userJson | ConvertFrom-Json

if ($userJson){
    return $userJson
}

Write-Error "Failed to read and parse /.sitecore/user.json file"

# $clientId = $userJson.endpoints.xmCloud.clientId
# $clientSecret = $userJson.endpoints.xmCloud.clientSecret
# $authorityUrl = $userJson.endpoints.xmCloud.authority
# $audience = $userJson.endpoints.xmCloud.audience
# $grantType = "client_credentials"