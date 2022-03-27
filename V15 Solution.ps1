function Get-MachineType
{
    param
        (
        [string]$ComputerName="localhost"
        )
    $os = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $ComputerName

    $type = switch ($os.ProductType) {
        1 { "Workstation" }
        2 { "Domain Controller" }
        3 { "Server" }
    }

    "$ComputerName is a $type."
}

