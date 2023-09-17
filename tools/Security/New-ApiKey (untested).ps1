# Important: below IDs are for environmental edge administration
# These may get lost upon environment deletion so need to regenerate
# Authentication clients => Generate => Edge administration client

$clientId = ""
$clientSecret = ""

$body = @{
    client_id = $clientId
    client_secret = $clientSecret
    audience = 'https://api.sitecorecloud.io'
    grant_type = "client_credentials"
}

$response = Invoke-RestMethod -Uri "https://auth.sitecorecloud.io/oauth/token" -Method Post -Body $body
$jwt = $response.access_token

$apiUrl = "https://edge.sitecorecloud.io/api/apikey/v1"
$headers = @{
    "Authorization" = "Bearer $jwt"
    "Content-Type" = "application/json"
}

$body = @{
    CreatedBy = "ADN"
    Label = "Website token"
    Scopes = @("content-#everything#", "audience-delivery")
} | ConvertTo-Json


# $body = "{ `"CreatedBy`":`"ADN`", `"Label`":`"Website token`", `"Scopes`":[`"content-#everything#`", `"audience-delivery`"] }"
$response = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $body
"API_key=$response"
