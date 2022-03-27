<#
Launching an Instance in a VPC
The following command creates a single m1.small instance in the specified private subnet.
The security group must be valid for the specified subnet.
#> 

New-EC2Instance `
    -ImageId ami-c49c0dac `
    -MinCount 1 -MaxCount 1 `
    -KeyName myPSKeyPair `
    -SecurityGroupId sg-5d293231 `
    -InstanceType m1.small `
    -SubnetId subnet-d60013bf
    
<#   Your instance is in the pending state initially, but is in the running state after a few minutes. 
To view information about your instance, use the Get-EC2Instance cmdlet. 
If you have more than one instance, you can filter the results on the reservation ID using the Filter parameter. 
First, create an object of type Amazon.EC2.Model.Filter. Next, call Get-EC2Instance that uses the filter, 
and then displays the Instances property.#>
 

$reservation = New-Object 'collections.generic.list[string]'
$reservation.add("r-b70a0ef1")
$filter_reservation = New-Object Amazon.EC2.Model.Filter -Property @{Name = "reservation-id"; Values = $reservation}
(Get-EC2Instance -Filter $filter_reservation).Instances
