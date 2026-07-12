# Step 12: Defender for Cloud & Project Wrap-up

## What I did
Enabled Microsoft Defender for Cloud's free Foundational CSPM tier, 
reviewed the Secure Score and recommendations, remediated one finding, 
then performed final cleanup and cost review to close out the lab.

## Defender for Cloud
Confirmed all paid Defender plans remained set to "Free" tier 
(`az security pricing list`) to avoid unexpected charges, while 
Foundational CSPM (Secure Score, baseline recommendations) remained 
active — this tier is free and cannot be disabled.

## Secure Score review
Reviewed recommendations across Identity, Compute, and Data categories. 
Selected and remediated one finding: restricted RDP (port 3389) access 
on the domain controller VM's Network Security Group from "Any" source 
to a specific IP range, addressing the "Management ports should be 
closed" recommendation.

## Why not fix everything
In a real SOC/Cloud Security role, triaging which Secure Score 
recommendations to act on (based on risk and effort) is a routine task 
— not every recommendation is fixed immediately. This lab intentionally 
demonstrates that triage decision rather than exhaustively remediating 
every finding.

## Cleanup performed
- Deleted the VM (`vm-addc-prod-chn-01`) and associated disks/NICs/public IPs
- Purged the Key Vault
- Verified no orphaned resources remained (`az resource list`)
- Retained the Log Analytics Workspace and Resource Groups (no ongoing cost)

## Final cost
Total lab spend: approximately €[X], within the Azure for Students free credit.

## Project reflection
This 12-day build covered the AZ-104 Identity and Governance domain 
end-to-end with hands-on evidence for each concept, including two 
genuine real-world constraints handled along the way: a region 
restriction requiring adaptation, and an Entra ID P1 licensing 
limitation that shifted Conditional Access from live deployment to 
documented design. Both are realistic scenarios, not just clean 
textbook exercises.
