# before starting, make sure env variable "Sitecore_GraphQL_ExposePlayground" is set to "true"
# IDE for testing your quesries is available at: https://xmcloudcm.localhost/sitecore/api/authoring/graphql/ide

$Hostname = "xmcloudcm.localhost"

# First, obtain JWT using authorized data from user.json
$JWT = ..\Security\Request-JWT.ps1

$query = @"
mutation {
    createItem(
      input: {
        name: "Sitecore Authoring and Management API"
        templateId: "{76036F5E-CBCE-46D1-AF0A-4143F9B557AA}"
        parent: "{0DE95AE4-41AB-4D01-9EB0-67441B7C2450}"
        language: "en"
        fields: [
          { name: "title", value: "Sitecore Authoring and Management API" }
          { name: "text", value: "This item was created with Sitecore Authoring and Management API" }
        ]
      }
    ) {
      item {
        itemId
        name
        path
        fields(ownFields: true, excludeStandardFields: true) {
          nodes {
            name
            value
          }
        }
      }
    }
  }
"@

$body = @{ query = $query} | ConvertTo-Json
$headers = @{
    "Content-Type" = "application/json"
    "Authorization" = "Bearer $JWT"
}

# Invoke the GraphQL endpoint using Invoke-RestMethod and pass in the query and headers
$response = Invoke-RestMethod -Method POST -Uri "https://$Hostname/sitecore/api/authoring/graphql/v1/"  -Headers $headers -Body $body

if($response.errors){
    $response.errors.message
}
else {
    "New item created:"
    "ID:   " + $response.data.createItem.item.itemId
    "Name: " + $response.data.createItem.item.name
    "Path: " + $response.data.createItem.item.path
}
