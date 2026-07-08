# create-users.ps1
# Creates test users for the Hybrid Identity Lab, distributed across OUs

$domain = "ahmed-lab.local"
$domainDN = "DC=ahmed-lab,DC=local"

# Default password for all test users (lab only - never do this in production!!!)
$defaultPassword = ConvertTo-SecureString "LabPass2026!" -AsPlainText -Force

$users = @(
    @{ FirstName = "Anna";  LastName = "Weber";    SamAccountName = "aweber";    OU = "OU=Sales,$domainDN" },
    @{ FirstName = "Tom";   LastName = "Fischer";   SamAccountName = "tfischer";  OU = "OU=Sales,$domainDN" },
    @{ FirstName = "Lisa";  LastName = "Meier";     SamAccountName = "lmeier";    OU = "OU=IT,$domainDN" },
    @{ FirstName = "Jonas"; LastName = "Klein";     SamAccountName = "jklein";    OU = "OU=IT,$domainDN" },
    @{ FirstName = "Sara";  LastName = "Hoffmann";  SamAccountName = "shoffmann"; OU = "OU=Security,OU=IT,$domainDN" },
    @{ FirstName = "Max";   LastName = "Bauer";     SamAccountName = "mbauer";    OU = "OU=Security,OU=IT,$domainDN" }
)

foreach ($user in $users) {
    $fullName = "$($user.FirstName) $($user.LastName)"
    $upn = "$($user.SamAccountName)@$domain"

    # Define parameters cleanly using a Splatting Hashtable
    $userParams = @{
        Name                  = $fullName
        GivenName             = $user.FirstName
        Surname               = $user.LastName
        SamAccountName        = $user.SamAccountName
        UserPrincipalName     = $upn
        Path                  = $user.OU
        AccountPassword       = $defaultPassword
        Enabled               = $true
        ChangePasswordAtLogon = $true
    }

    # Pass the parameters using @ instead of $
    New-ADUser @userParams

    Write-Host "Created user: $fullName ($($user.SamAccountName))" -ForegroundColor Green
}