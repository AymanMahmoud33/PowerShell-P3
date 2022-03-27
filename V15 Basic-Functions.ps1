
# help
Get-Help about_Functions

# syntax
# function [<scope:>]<name> [([type]$parameter1[,[type]$parameter2])]{  
#     param([type]$parameter1 [,[type]$parameter2]) 
#     dynamicparam {<statement list>}
#     begin {<statement list>}  
#     process {<statement list>}  
#     end {<statement list>}
# }


# basic inline function
function Get-FilesByExtension ($Path, $Extension) {
    Get-ChildItem -Path $Path |
        Where-Object -Property Extension -eq $Extension
}

Get-FilesByExtension -Path "\\DC1\Stuff\Images" -Extension ".jpg"
Get-FilesByExtension -Path "\\DC1\Stuff\Images" -Extension ".png"
Get-FilesByExtension -Path "\\DC1\Stuff\Images" -Extension ".gif"

# basic function
function Get-FilesByExtension {
    param (
        [string]$Path,
        [string]$Extension = ".jpg"
    )
    
    Get-ChildItem -Path $Path |
        Where-Object -Property Extension -eq $Extension
}


# let's turn this into a function!
function Get-SystemType {
    param (
        $ComputerName = "DC1"
    )
    
    $os = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName 'DC1'
$type = switch ($os.ProductType) {
    1 { "Workstation" }
    2 { "Domain Controller" }
    3 { "Server" }
}

"DC1 is a $type."
}



