$userJson = ..\Security\Read-UserJson.ps1 -JsonFile "user.json"
$automationJson = ..\Security\Read-UserJson.ps1 -JsonFile "automation.json"

$clientId = $automationJson.endpoints.xmCloud.automationClientId
$clientSecret = $automationJson.endpoints.xmCloud.automationClientSecret
$audience = $userJson.endpoints.xmCloud.audience

$uri = "https://auth.sitecorecloud.io/oauth/token"

$json = & curl.exe --request POST $uri --header "content-type: application/x-www-form-urlencoded" --data audience=$audience --data grant_type=client_credentials --data client_id=$clientId --data client_secret=$clientSecret -s
$response = $json | ConvertFrom-Json
return $response.access_token








# $uri = "https://edge.sitecorecloud.io/api/admin/v1"
# $JWT = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InpnbnhyQk9IaXJ0WXp4dnl1WVhNZyJ9.eyJodHRwczovL2F1dGguc2l0ZWNvcmVjbG91ZC5pby9jbGFpbXMvb3JnX2lkIjoib3JnX3NaeDFDYWNqZ2o1WURJS3IiLCJodHRwczovL2F1dGguc2l0ZWNvcmVjbG91ZC5pby9jbGFpbXMvb3JnX25hbWUiOiJwZXJmaWNpZW50IiwiaHR0cHM6Ly9hdXRoLnNpdGVjb3JlY2xvdWQuaW8vY2xhaW1zL29yZ19kaXNwbGF5X25hbWUiOiJQZXJmaWNpZW50IiwiaHR0cHM6Ly9hdXRoLnNpdGVjb3JlY2xvdWQuaW8vY2xhaW1zL29yZ19hY2NvdW50X2lkIjoiMDAxMU4wMDAwMVV0VVhiUUFOIiwiaHR0cHM6Ly9hdXRoLnNpdGVjb3JlY2xvdWQuaW8vY2xhaW1zL29yZ190eXBlIjoicGFydG5lciIsImh0dHBzOi8vYXV0aC5zaXRlY29yZWNsb3VkLmlvL2NsYWltcy9jbGllbnRfbmFtZSI6IkxhYmVsIiwiaXNzIjoiaHR0cHM6Ly9hdXRoLnNpdGVjb3JlY2xvdWQuaW8vIiwic3ViIjoiQkx6U0RmY0FMeExZSWRWaWN1UWdjTXgyeDEzT05kS0lAY2xpZW50cyIsImF1ZCI6Imh0dHBzOi8vYXBpLnNpdGVjb3JlY2xvdWQuaW8iLCJpYXQiOjE2Nzg4NjExNjksImV4cCI6MTY3ODg2MjA2OSwiYXpwIjoiQkx6U0RmY0FMeExZSWRWaWN1UWdjTXgyeDEzT05kS0kiLCJzY29wZSI6InhtY2xvdWRkZXBsb3kub3JnYW5pemF0aW9uczptYW5hZ2UgeG1jbG91ZGRlcGxveS5wcm9qZWN0czptYW5hZ2UgeG1jbG91ZGRlcGxveS5lbnZpcm9ubWVudHM6bWFuYWdlIHhtY2xvdWRkZXBsb3kuZGVwbG95bWVudHM6bWFuYWdlIHhtY2xvdWRkZXBsb3kuY2xpZW50czptYW5hZ2UgeG1jbG91ZGRlcGxveS5zb3VyY2Vjb250cm9sOm1hbmFnZSB4bWNsb3VkLmNtOmFkbWluIiwiZ3R5IjoiY2xpZW50LWNyZWRlbnRpYWxzIn0.BZ_Bv7Nwo9LIF2j4BrtcnVMKD0-0S89ru3yGwlXpZ3f_xquoOGMLUfqese2IOJ-_cwV7weQbBcLA3vNEHpNv1rdhe8EUAHMtcTuq3zM212RLDTW2Vu38MJBIFTw8iNcoRqs_Vb4OtWvS8G7_6I0KcDhrpwxzHNCJmWkkJM2vzRzJ-uZd20ojyn2Bvlpi1gE3wIFFC5ljQvMwdf9xUVlzU_aEHTg2EnAE3peKkZE4wIDaoMG5fhONt6jT05sTHzdxlyP1alW89I9oulT6HhcclaNRno0aOK7tnodD0eE51TeaZAfTw8tUw6Y9HTsEMTKIO5VRYP1W161UfOgXK8lGKA"

# $body = @{
#     label = "My new webhook"
#     uri = "https://www.mysite.com/hooks/edge-hook"
#     method = "POST"
#     headers = @{ "x-header" = "bar" }
#     body = '{"rebuild":"true"}'
#     createdBy = "anco"
#     executionMode = "OnEnd"
# } | ConvertTo-Json

# $headers = @{
#     Authorization = "Bearer $JWT"
#     ContentType = "application/json"
# }

# $response = Invoke-RestMethod -Uri $uri -Method POST -Headers $headers -Body $body
# Write-Output $response
