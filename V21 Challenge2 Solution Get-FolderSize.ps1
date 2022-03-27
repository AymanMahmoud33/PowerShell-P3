
<#
.SYNOPSIS
Returns the size of one or more directories.
.DESCRIPTION
The Get-FolderSize script will return the total size of directories in Bytes, MBs, and GBs.
.PARAMETER Path
Pass in one or more directories using the mandatory Path parameter.
.PARAMETER IncludeGrandTotal
Specifying the IncludeGrandTotal parameter will add a Grand Total record to the output.
.INPUTS
System.String. You can pipe a string array to Get-FolderSize.
.OUTPUTS
None.
.EXAMPLE
.\Get-FolderSize.ps1 -Path @("C:\Program Files","\\DC1\Stuff","\\DC1\Backups")
.EXAMPLE
.\Get-FolderSize.ps1 -Path @("C:\Program Files","\\DC1\Stuff","\\DC1\Backups") -IncludeGrandTotal
#>
function Get-FolderS {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true,Position=1)]
        [ValidateScript({Test-Path $_})]
        [string[]]$Path,
        [Parameter()]
        [switch]$IncludeGrandTotal    
    )
    
    # array for storing output objects
    $alldirinfo = @()
    
    # loop through directories
    foreach ($dir in $Path) {
    
        Write-Verbose -Message "Calculating size for $dir."
    
        # get directory size (silently continue on error)
        $dirsize = Get-ChildItem -Path $dir -Recurse -Force -ErrorAction SilentlyContinue |
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
        
        Write-Verbose -Message "Calculating Grand Totals."
    
        # initialize variable (fix)
        $grandtotal = 0
    
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
}

