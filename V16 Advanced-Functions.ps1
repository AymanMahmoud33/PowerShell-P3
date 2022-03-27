
# help
Get-Help about_Functions_Advanced

# syntax
function Test-Function {
    [CmdletBinding()]
    #[CmdletBinding(SupportShouldProcess=$true)] unlocks parameters -Whatis and -Confirm
    #[CmdletBinding(SupportPaging=$true)] unlocks parameters like -First, -Skip, and -IncludeTotalCount parameters
    param 
        (
        [Parameter(Mandatory=$true)]
        $ComputerName
        )
    Begin {} # Optional, happens once, used for tasks such connecting to a database, of defining variables 
    process {} # Mandataroy, runs once for each object piped into the function
    end {} # Optional, cleanup or disconnect from a database, etc..
}

# simple function
function Get-BootTimesSimple {
    param(
        [string[]]$ComputerName
    )
    
    $result = @()
  
    foreach($computer in $ComputerName){        
                
        $os = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $computer

        [PSCustomObject]$stats = @{
            ComputerName = $computer
            LastBoot = $os.LastBootUpTime
            UpTime = (Get-Date) - $os.LastBootUpTime
        }

        $result += $stats
    }
 
    $result | 
        Select-Object ComputerName, LastBoot, Uptime |
            Sort-Object LastBoot -Descending

}

Get-BootTimesSimple -ComputerName 'DC1','DC2','Client1'


# advanced function
function Get-BootTimesAdvanced {
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
        $result | 
            Select-Object ComputerName, LastBoot, Uptime |
                Sort-Object LastBoot -Descending
    }
}

# usage
'DC1','DC2' | Get-BootTimesAdvanced
Get-BootTimesAdvanced 'Client1'
Get-BootTimesAdvanced -ComputerName 'DC1','DC2'
Get-ADComputer -Filter * | Select-Object -ExpandProperty Name | Get-BootTimesAdvanced