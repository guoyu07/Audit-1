# random snips

# When on the network

[System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()

[System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()

$ForestRootDomain = (([System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()).Forest).Name
([System.DirectoryServices.ActiveDirectory.Forest]::GetForest((New-Object System.DirectoryServices.ActiveDirectory.DirectoryContext(‘Forest’, $ForestRootDomain)))).GetAllTrustRelationships()

([System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()).GetAllTrustRelationships()

[System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest().GlobalCatalogs

#List of amin accounts
Get-ADUser -filter {AdminCount -eq 1} -Properties Name,AdminCount,ServicePrincipalName,PasswordLastSet,LastLogonDate,MemberOf

# Get password policy for domain logged into
Get-ADFineGrainedPasswordPolicy -Filter *

# ADSI

#Get domain details
$domainname = $env:userdomain
#connect to the $domain
[ADSI]$domain = "WinNT://$domainname"
$domain | select *

$domain | Select @{Name="Name";Expression={$_.name.value}},
@{Name="PwdHistory";Expression={$_.PasswordHistoryLength.value}},
@{Name="MinPasswordAge";Expression={New-Timespan -seconds $_.MinPasswordAge.value}},
@{Name="MaxPasswordAge";Expression={New-Timespan -seconds $_.MaxPasswordAge.value}}

# Count of users groups and computers on domain.
$domain.children | group {$_.schemaclassname}

# When not on the network


