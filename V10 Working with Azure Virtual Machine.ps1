$rg = Get-AzResourceGroup -Name "variiance"
New-AzVM -Name TestVM `
    -ResourceGroupName $rg.ResourceGroupName `
    -Credential (Get-Credential) `
    -Location 'francecentral' `
    -Image UbuntuLTS
$vm = Get-AzVm -Name TestVM -ResourceGroupName variiance
$vm 
$vm | Stop-AzVm -Force -NoWait
$vm | Remove-AzVm -Force -NoWait
$rg | Remove-AzResourceGroup -Force -NoWait
<#
Other useful cmdlets
Start-AzVm
Restart-AzVm
#>