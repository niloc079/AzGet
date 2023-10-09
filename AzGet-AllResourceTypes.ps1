$Path = Get-Location

$resources = @()
Get-AzSubscription | ForEach-Object {
    $_ | Set-AzContext
    $subscriptionName = $_.Name
    $subscriptionId = $_.SubscriptionId
    Get-AzResource | ForEach-Object {
        $resources += [PSCustomObject]@{
            SubscriptionName  = $subscriptionName
            SubscriptionId    = $subscriptionId
            ResourceGroupName = $_.ResourceGroupName
            ResourceName      = $_.ResourceName
            ResourceType      = $_.ResourceType
            Location          = $_.Location
        }
        
    }
}

$resources | Export-csv $Path\AllResourceTypes.csv