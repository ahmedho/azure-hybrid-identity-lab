# create-resource-groups.ps1
# Creates the core Resource Groups for the Hybrid Identity Lab with consistent tagging and naming conventions.

$location = "westeurope"
$resourceGroups = @(
    @{ Name = "rg-identity";    Environment = "production"},
    @{ Name = "rg-monitoring";  Environment = "production"},
    @{ Name = "rg-workloads";   Environment = "development" }
)

foreach ($rg in $resourceGroups) {
    az group create `
        --name $rg.Name `
        --location $location `
        --tag "environment=$($rg.Environment)" "owner=ahmed.othman" "costcenter=lab-az104" "project=hybrid-identity-lab"

    Write-Host "Created: $($rg.Name)" -ForegroundColor Green

}