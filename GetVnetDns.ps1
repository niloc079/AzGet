$Path = Get-Location

$resources = @()
Get-AzSubscription | Foreach-Object {
    $sub = Set-AzContext -SubscriptionId $_.SubscriptionId
    $vnets = Get-AzVirtualNetwork

    foreach ($vnet in $vnets) {
        [PSCustomObject]@{
            Subscription    = $sub.Subscription.Name
            Name            = $vnet.Name
            Vnet            = $vnet.AddressSpace.AddressPrefixes -join ', '
            Subnets         = $vnet.Subnets.AddressPrefix -join ', '
            DNS             = $vnet.DhcpOptions.dnsservers
        }
    }
}

$resources | Export-csv $Path\GetVnetDns