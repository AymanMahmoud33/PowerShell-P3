
# help
Get-Help about_Profiles

# profiles #

## PowerShell Console ##
# All Users, All Hosts       = $PSHOME\Profile.ps1
# All Users, Current Host    = $PSHOME\Microsoft.PowerShell_profile.ps1
# Current User, All Hosts    = $Home\My Documents\PowerShell\Profile.ps1
# Current User, Current Host = $Home\My Documents\PowerShell\Microsoft.Profile_profile.ps1

## VSCode ##
# All Users, Current Host    = $PSHOME\Microsoft.VSCode_profile.ps1
# Current User, Current Host = $Home\My Documents\PowerShell\Microsoft.VSCode_profile.ps1

# create a profile
notepad $PROFILE.CurrentUserCurrentHost