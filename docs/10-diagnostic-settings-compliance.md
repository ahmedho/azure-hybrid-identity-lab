# Step 10: Diagnostic Settings & Log Analytics

## What I built
Created a Log Analytics Workspace, manually enabled Diagnostic Settings 
on the VM and Key Vault to route logs there, then automated this going 
forward using a built-in DeployIfNotExists (DINE) Azure Policy with 
remediation for existing resources.

## Log Analytics Workspace
| Property | Value |
|---|---|
| Name | `law-lab-chn-01` |
| Resource Group | `rg-monitoring` |
| Region | Switzerland North |

## Diagnostic settings configured
| Resource | Data sent | Destination |
|---|---|---|
| VM (`vm-addc-prod-chn-01`) | AllMetrics (platform-level) | `law-lab-chn-01` |
| Key Vault (`kv-lab-<initials>01`) | AuditEvent (every secret/key access) | `law-lab-chn-01` |

## Key distinction: VM vs. PaaS diagnostic depth
For IaaS resources like VMs, Diagnostic Settings capture host-level 
platform metrics only (CPU, disk, network) — deep OS/application log 
collection requires the Azure Monitor Agent, a separate configuration. 
For PaaS resources like Key Vault, Diagnostic Settings directly expose 
rich resource-level logs (e.g., every access attempt), no additional 
agent required.

## Automating with Policy: DeployIfNotExists
Used a built-in "Deploy Diagnostic Settings for Key Vault to Log 
Analytics workspace" policy, assigned at the `rg-identity` scope, with 
remediation enabled for existing resources.

Unlike the Deny-effect policies from Day 9 (which block non-compliant 
resources outright), this is a **DeployIfNotExists (DINE)** policy — 
rather than blocking, it automatically deploys the missing diagnostic 
configuration. DINE policies require a system-assigned Managed Identity 
with deployment permissions, created automatically during assignment.

## Verification
Queried the workspace directly using KQL:

```kql
AzureDiagnostics
| where ResourceProvider == "MICROSOFT.KEYVAULT"
| take 20
```

Confirmed Key Vault audit events were successfully flowing into the 
workspace.

## Forward link to SC-200
This Log Analytics Workspace and the Key Vault audit logs flowing into 
it are directly reusable for the SC-200 phase of the roadmap — Microsoft 
Sentinel is built on top of Log Analytics, and this same KQL query 
interface is what the future KQL Detection Library project will build on.

## Note: Boot Diagnostics vs. Diagnostic Settings
The Azure Portal's VM blade has two similarly-named but distinct 
features: **Boot Diagnostics** (captures boot screenshots/serial 
console, requires a Storage Account) and **Diagnostic Settings** (the 
Azure Monitor platform feature used here, sends metrics/logs to Log 
Analytics without requiring storage). When the Portal appeared to 
require a storage account, the diagnostic setting was instead created 
via Azure CLI, which only requires the target Log Analytics workspace ID.