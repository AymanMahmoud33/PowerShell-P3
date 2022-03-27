<# V20: Error Handling and Debugging
Non terminating errors
	-Writes error to pipeline 
	-Does not terminate script
	-Can’t handle with try..catch
Terminating errors
	-Terminates script
	-Output error message
	-Handle with try..catch
#>

try { # code that could generate an error}
catch {# error handling code }
finally { # cleanup code }
# Open Organize-Image.ps1
$images = Get-ChildItem -Path $source -Include @("*.jpg","*.png","*.gif") -Recurse
<#
Could generate error if invalid path
put it in try block, and in catch block write-host a message, as there is no way to fix the user input for him
Run the script, but you will not get your message for the user, because this was non terminating error
If we add -ErrorAction stop # it will force consider it terminating error and from PowerShell to go for the catch block and execute it.

We can reduce the possibility of having error by proactively dealing with it
Using advanced parameters to validated the source location will help here
before the parameter $source add:
#>
# [ValidateScript({test-path $_})] # if the path from user input is not valid the user will get a message to fix this
# revert back (remove) the try catch changes.
# test..
# Now for the last part of the script
# remove source directories
if ($RemoveSource -eq $true) { 
    Write-Verbose -Message "Removing source directories."
    try {
        $Source | Remove-Item -Recurse -Confirm:$false
    }
    catch [System.UnauthorizedAccessException] {
        # handle exception 
    }
    catch [System.IO.IOException] {
        # handle exception
    }
}

# Mention the break point that you can put for debugging, it breaks the script so you can investigate the current running of the script.
