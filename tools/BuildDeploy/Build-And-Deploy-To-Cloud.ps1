# Execute a build and deploy of you project to an XM Cloud environment from the CLI.
# Configuration is done in the file tools\BuildDeploy\Build-And-Deploy-Config.json.
# Configuration should be in the following format:
# {
#     "XMCloud_OrganizationName": "MyOrganization",
#     "XMCloud_ProjectName": "MyProject",
#     "XMCloud_EnvironmentName": "MyEnvironment"
# }

$ClientId = ""
$ClientSecret = ""

$VerbosePreference = 'SilentlyContinue' # change to Continue to see verbose output
$DebugPreference = 'SilentlyContinue' # change to Continue to see debug output
$ErrorActionPreference = 'Stop'

Push-Location -Path $PSScriptRoot\..\..
if (-not (Test-Path -Path .\tools\BuildDeploy\Build-And-Deploy-Config.json)) {
    Write-Error "File .\tools\Build-And-Deploy-Config.json does not exist"
}
$config = Get-Content -Raw -Path .\tools\BuildDeploy\Build-And-Deploy-Config.json | ConvertFrom-Json

$organizationName = $config.XMCloud_OrganizationName
$projectName = $config.XMCLoud_ProjectName
$environmentName = $config.XMCLoud_EnvironmentName

Write-Host "Organization: $organizationName"
Write-Host "Project: $projectName"

$projectList = dotnet sitecore cloud project list --json | ConvertFrom-Json
$project = $projectList | Where-Object { $_.name -eq $projectName }
if (-not $project) {

    if ($ClientId -and $ClientSecret){
        dotnet sitecore cloud login --client-id $ClientId --client-secret $ClientSecret --client-credentials true --allow-write
    }
    else{
        dotnet sitecore cloud login # maybe not authenticated?
    }
    
    $projectList = dotnet sitecore cloud project list --json | ConvertFrom-Json
    $project = $projectList | Where-Object { $_.name -eq $projectName }
}
if (-not $project) {
    Write-Error "Project '$projectName' not found in organization '$organizationName'."
}
$projectId = $project.id
Write-Host "Project id: $projectId"

$environmentList = dotnet sitecore cloud environment list --project-id $projectId --json | ConvertFrom-Json
$environment = $environmentList | Where-Object { $_.name -eq $config.XMCloud_EnvironmentName }

if (-not $environment) {
    Write-Warning "Environment '$environmentName' not found. Creating new environment..."
    $output = dotnet sitecore cloud environment create --name $environmentName --project-id $projectId
    $environmentId = $output[6].Substring($output[6].IndexOf(":")+1).trim()
}
else{
    $environmentId = $environment.id
}

Write-Host "Environment id: $environmentId"
Write-Host "Environment host: $($environment.host)"
Write-Host "Environment last updated at: $($environment.lastUpdatedAt)"
Write-Host "Environment last updated by: $($environment.lastUpdatedBy)"
Write-Host "Environment provisioning status: $($environment.provisioningStatus)"

Write-Host "Creating and uploading a deployment package..." -NoNewline
$deployment = dotnet sitecore cloud deployment create --environment-id $environmentId --working-dir . --upload --no-watch --no-start --json | ConvertFrom-Json
if ($deployment.Status -eq "Operation Failed") {
    Write-Host ""
    Write-Error "Creation of deployment failed: $($deployment.Message)"
}
Write-Host " done."
$deploymentId = $deployment.id
Write-Host "Deployment is provisioned and queued. Deployment id: $deploymentId"
Write-Host "See deployment status at https://deploy.sitecorecloud.io/deployment/$deploymentId/details"
$deploymentStart = dotnet sitecore cloud deployment start --deployment-id $deploymentId --no-watch --json | ConvertFrom-Json
Write-Host "Deployment started. Deployment id: $deploymentId"
dotnet sitecore cloud deployment watch --deployment-id $deploymentId
Write-Host "Build and deploy completed."
Write-Host "Retrieving deployment logs..." -NoNewline
dotnet sitecore cloud deployment log --deployment-id $deploymentId --path deployment-logs
$currentLocation = (Get-Location).Path
$logFilePath = "$currentLocation\deployment-logs\Deployment_$($deploymentId)_logs.json"
Write-Host "The raw deployment log can be found at '$logFilePath'"

# Process the deployment log to create sensible information
if (-not (Test-Path -Path "$PSScriptRoot\buildanddeploy-processlog.ps1")) {
    Write-Error "Expected file '$PSScriptRoot\buildanddeploy-processlog.ps1' does not exist."
}
. "$PSScriptRoot\buildanddeploy-processlog.ps1" -deploymentId $deploymentId
Pop-Location