Function Get-DiskInfo {

Param (
[Parameter(Mandatory=$true)]
    [String]$ComputerName,
    [int]$DriveType = 3
)

Get-CimInstance -ClassName win32_logicaldisk -filter "DriveType=$DriveType" -computername $ComputerName |
 select @{n='ComputerName';e={$_.PSComputerName}},
        @{n='Drive';e={$_.DeviceID}},
        @{n='FreeSpace';e={$_.Freespace /1GB -as [int]}}

        }