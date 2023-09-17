    <#
    .SYNOPSIS
    Uploads the media from a local file using a JWT token for authentication, the actual path is dictated from $url

    .DESCRIPTION
    This function uploads a file to the specified URL using a JWT token for authentication. It returns an object containing the Id, name and path of uploaded media.

    .PARAMETER UploadUrl
    The URL to upload the file to.

    .PARAMETER JWT
    The JWT token to use for authentication.

    .PARAMETER FilePath
    The path to the file to be uploaded.

    .OUTPUTS
    An object containing the Id, name and path of uploaded media.

    .AUTHOR
    Martin Miles
    #>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true, HelpMessage="The URL to upload the file to.")]
        [string]$UploadUrl,
        [Parameter(Mandatory=$true, HelpMessage="The JWT token to use for authentication.")]
        [string]$JWT,
        [Parameter(Mandatory=$true, HelpMessage="The path to the file to be uploaded.")]
        [string]$FilePath
    )

if (-not (Test-Path $FilePath)) {
    Write-Error "The specified file '$FilePath' does not exist."
    return
}

#  cinst curl
# "c:\ProgramData\chocolatey\lib\curl\tools\curl-8.3.0_1-win64-mingw\bin\curl.exe"
$result = & curl --request POST $UploadUrl --header "Authorization: Bearer $JWT" --form =@"$FilePath" -s
$result = $result | ConvertFrom-Json
return $result 