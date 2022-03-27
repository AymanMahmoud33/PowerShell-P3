
# get last day of month
function Get-LastDayOfMonth {
[CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline=$true)]
        [datetime[]]$Date = (Get-Date)
    )
       
    process {
        foreach ($d in $Date){
            $lastday = [datetime]::DaysInMonth($d.Year, $d.Month)
            [datetime]"$($d.Month), $lastday, $($d.year)"
        }
    }
}

# last day of current month
Get-LastDayOfMonth

# last day of previous month
Get-LastDayOfMonth -Date (Get-Date).AddMonths(-1)

# last day of next 12 months
0..11 | ForEach-Object { (Get-Date).AddMonths($_) } | Get-LastDayOfMonth


# difference between two dates
function Get-DateDifference {
    param (
        [datetime]$StartDate,
        [datetime]$EndDate
    )
        
    (New-TimeSpan -Start $StartDate -End $EndDate).TotalDays
}

Get-DateDifference -StartDate '01/01/2020' -EndDate '04/01/2020'
