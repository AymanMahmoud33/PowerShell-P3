Get-AzSubscription | Where-Object name -like "msdn*" | Select-AzSubscription
Write-host "$(get-date): Printing list of RGs"

Get-AZResourceGroup
$rg = Read-Host -Prompt "Which Resource Group do you want to check?"
$rgContext = Get-AzResourceGroup -name $rg
Write-Host "$(Get-Date): Getting VMs"

$vms = Get-AzVM -ResourceGroupName $rgContext.ResourceGroupName -Status
foreach($vm in $vms) 
    {
        if ($vm.PowerState -like "*running*")
            {
            Write-Host "$(Get-date): $($vm.Name) is running. Performing Stop!"
            $vm | Stop-AzVM -Force -Nowait
            Write-Host "$(Get-date): $($vm.Name) is stopping"
            }
    }
