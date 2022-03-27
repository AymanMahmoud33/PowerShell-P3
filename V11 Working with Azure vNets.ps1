Get-AzVirtualNetwork -ResourceGroupName $rg.ResourceGroupName
$vnet =  Get-AzVirtualNetwork -ResourceGroupName $rg.ResourceGroupName
$vnet.subnets
# write host the prefix of a subnet:
Write-Host "$($vnet.Subnets.Name) Prefix: $($vnet.Subnets.AddressPrefix)"
