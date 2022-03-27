install-module  AZ 
Connect-AzAccount
Get-AzSubscription | Where-Object name -Like "msdn*"
Get-AzSubscription | Where-Object name -Like "msdn*" | Select-AzSubscription
Get-AzResourceGroup
New-AzResourceGroup -Name "Variiance" -Location "francecentral"
Get-AzResourceGroup | Where-Object {$_.ResourceGroupName -eq “variiance”} | Format-Table
