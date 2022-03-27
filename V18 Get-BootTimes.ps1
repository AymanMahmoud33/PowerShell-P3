## Best Practices for writing functions

# Single purpose 
# Naming convention 
# Go for advanced fucntions
# Document your code and add comments
# Output objects
# Test

function Get-BootTimes {
<#
.SYNOPSIS
Get the boot time and total uptime of machines.
.DESCRIPTION
This function will retrieve the last time a machine was booted and calculate total uptime.
.PARAMETER ComputerName
Array of one or more machine names.
.PARAMETER Path
Array of one or more machine names.
.INPUTS
System.String. You can pipe string objects to Get-BootTimes.
.OUTPUTS
Array of PSCustom objects
.EXAMPLE
Get-BootTimes -ComputerName 'DC1','DC2'
.EXAMPLE
'DC1','DC2' | Get-BootTimes
.EXAMPLE
Get-ADComputer -Filter * | Select-Object -ExpandProperty Name | Get-BootTimes
#>
[CmdletBinding()]
param(
    [Parameter(
        Mandatory=$true,
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true,
        Position=0)]  
        [string[]]$ComputerName
)
    # optional pre-processing block (initialization)
    begin {     
        $result = @()
    }

    # mandatory processing block (executes for each object in pipeline)
    process {    
        foreach($computer in $ComputerName){        

            $os = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $computer

            [PSCustomObject]$boot = @{
                ComputerName = $computer
                LastBoot = $os.LastBootUpTime
                UpTime = (Get-Date) - $os.LastBootUpTime
            }

            $result += $boot
        }
    }

    # optional post-processing block (cleanup)
    end { 
return $result
    }
}