$results = @()
$DataPath = "$env:USERPROFILE\Desktop\AzureResources.csv"
$subscriptions = Get-AzureRmSubscription
 
foreach($sub in $subscriptions){
Select-AzureRmSubscription -SubscriptionName $sub.SubscriptionName
$SubResources = Get-AzureRmResource
 
    foreach($SubResource in $SubResources){
 
    $x = new-object psObject | select SubName, Name, ResourceName, ResourceType, ResourceGroupName, Location, SubscriptionId, ResourceId
 
        $x.SubName = $sub.SubscriptionName
        $x.Name = $SubResource.Name
        $x.ResourceName = $SubResource.ResourceName
        $x.ResourceType = $SubResource.ResourceType
        $x.ResourceGroupName = $SubResource.ResourceGroupName
        $x.Location = $SubResource.Location
        $x.SubscriptionId = $SubResource.SubscriptionId
        $x.ResourceId = $SubResource.ResourceId
            
        $Results += $x
 
    }
 
}
$Results.Count
$Results | Export-Csv -notypeinformation -Path $DataPath