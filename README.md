# Perficient XM Cloud JumpStart

Important: *please read the instructions below*

# Features

These featuers were implemented above the original starterkit:

- Multisite solution with a shared site for layouts, media, etc.
- Deployment CLI scripts included (*as well as for Vercel and Netlify*)
- SPE and Remoting enabled
- CM instance customiaztion
- Rendering Host customizations
- Authoring and Management GraphQL API sample (*create new item, media item upload, etc*)
- Sample XDT transform to alter you web.config
- Automation for JWT request to be used by multiple derived scripts
- Parametrized Up.ps1 script
- Documentation

# Git Branch

Please make sure to use `JumpStart` as our main branch for this development stream, as `main` is reserved for pulling up the data from the upstream repository of this fork. Use `JumpStart/feature/*` branches for your features pull requests.

## QUICK START

1. In an ADMIN terminal:

    ```ps1
    .\init.ps1 -InitEnv -LicenseXmlPath "C:\projects\license.xml" -AdminPassword "b"
    ```

2. Restart your terminal and run:

    ```ps1
    .\up.ps1
    ```

*** 

## About this Solution
This solution is designed to help developers learn and get started quickly
with XM CLoud + Headless SXA.


