$JWT = .\Request-EdgeOAuthJWT.ps1

$uri = "https://edge.sitecorecloud.io/api/admin/v1/webhooks"

$body = @{
    label = "My new webhook"
    uri = "https://www.mysite.com/hooks/edge-hook"
    method = "POST"
    body = '{"rebuild":"true"}'
    createdBy = "anco"
    executionMode = "OnEnd"
} | ConvertTo-Json

$headers = @{
    Authorization = "Bearer $JWT"
    ContentType = "application/json"
}

$response = Invoke-RestMethod -Uri $uri -Method POST -Headers $headers -Body $body
