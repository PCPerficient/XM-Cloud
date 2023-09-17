# Set up variables with your Vercel project and Sitecore XM Cloud environment details
$vercelProjectName = ""
$vercelToken = ""

# Set up the path to the Next.js project subfolder
$nextjsSubfolderPath = "../src/sxastarter"
$currentDir = Get-Location
# Check if the Vercel CLI is installed
if (-not (Get-Command vercel -ErrorAction SilentlyContinue)) {
    # Install the Vercel CLI using npm
    npm install -g vercel
}

# Change to the Next.js project subfolder
cd $nextjsSubfolderPath

# Log in to your Vercel account
vercel login 

# Set the Vercel project context to your project
#vercel switch $vercelProjectName

# Deploy the project using the Vercel CLI
vercel deploy --prod  --token $vercelToken

# Change back to the original directory
cd $currentDir 