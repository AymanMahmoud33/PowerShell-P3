
<#
1) Transform into script
2) Fix issue (access denied error) 
3) Fix issue (grandtotal is cumulative when dot sourcing)
4) Add help and verbose support
5) Test and execute!
#>
<#
.SYNOPSIS
    Short description
.DESCRIPTION
    Long description
.EXAMPLE
    PS C:\> <example usage>
    Explanation of what the example does
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
# variables
$Path = @("C:\Program Files","\\DC1\Stuff","\\DC1\Backups")
$IncludeGrandTotal = $true

# array for storing output objects
$alldirinfo = @()

# loop through directories
foreach ($dir in $Path) {

    # get directory size
    $dirsize = Get-ChildItem -Path $dir -Recurse -Force |
        Measure-Object -Property Length -Sum

    # create custom object
    $dirinfo = @{
        DirectoryName   = $dir
        SizeBytes       = $dirSize.Sum
        SizeMB          = "{0:n2} MB" -f ($dirSize.Sum / 1MB)
        SizeGB          = "{0:n2} GB" -f ($dirSize.Sum / 1GB)
    }

    # add to output object array
    $alldirinfo += $dirinfo   
}

# include grand totals
if ($IncludeGrandTotal) {
    
    # sum up sizes for all objects
    $alldirinfo | ForEach-Object {
        $grandtotal += $_.SizeBytes
    }

    # create custom object
    $grandtotalinfo = @{
        DirectoryName   = "Grand Total"
        SizeBytes       = $grandtotal
        SizeMB          = "{0:n2} MB" -f ($grandtotal / 1MB)
        SizeGB          = "{0:n2} GB" -f ($grandtotal / 1GB)
    }
    
    # add to output object array
    $alldirinfo += $grandtotalinfo
}

# output results
$alldirinfo | 
    Select-Object DirectoryName, SizeBytes, SizeMB, SizeGB | 
        Sort-Object SizeBytes | 
            Format-Table -AutoSize