<#
    .SYNOPSIS
    Generates a pre-signed URL for uploading a file to a specified endpoint using a JWT token.

    .DESCRIPTION
    This function generates a pre-signed URL for uploading a file to a specified endpoint using a JWT token.

    .PARAMETER EndpointUrl
    The URL of the endpoint where the file will be uploaded. Example https://some-part.sitecorecloud.io/sitecore/api/authoring/graphql/v1/

    .PARAMETER JWT
    The JWT token to use for authentication. Call Request-JWT.ps1 from Security folder for obtaining the one

    .PARAMETER UploadPath
    The Sitecore path of the file to be uploaded, relative to /sitecore/media library item (ie. "Default Website/new media")

    .OUTPUTS
    It returns the URL as a string value.

    .AUTHOR
    Martin Miles    
    #>
[CmdletBinding()]
Param (
    [Parameter(Mandatory=$true, HelpMessage="The URL of the endpoint where the file will be uploaded.")]
    [string]$EndpointUrl,
    [Parameter(Mandatory=$true, HelpMessage="The JWT token to use for authentication.")]
    [string]$JWT,
    [Parameter(Mandatory=$true, HelpMessage="The path of the file to be uploaded.")]
    [string]$UploadPath
)

$query = @"
mutation
{
  uploadMedia(input: { itemPath: "$UploadPath" }) {
    presignedUploadUrl
  }
}
"@

$body = @{ query = $query} | ConvertTo-Json
$headers = @{
    "Content-Type" = "application/json"
    "Authorization" = "Bearer $JWT"
}

# Invoke the GraphQL endpoint using Invoke-RestMethod and pass in the query and headers
$response = Invoke-RestMethod -Method POST -Uri $EndpointUrl -Headers $headers -Body $body
$result = $response.data.uploadMedia
return $result.presignedUploadUrl