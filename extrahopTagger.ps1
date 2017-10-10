. .\apiconfig.ps1


$csv = Import-Csv C:\SysOps\foocsv.csv



$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Accept", "application/json")
$headers.Add( "Authorization", "ExtraHop apikey="+$apikey)

#[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

function getExtrahopDevID ($name) {

    $result = Invoke-RestMethod -Uri ("https://extrahop.channeladvisor.com/api/v1/devices?limit=100&search_type=name&value="+$name) -Headers $headers
    return $result.id        
}
function tagEHDevice ($devid , $team) {
    
    #$devid
    #$team
    $EHTagID = getEHTagID $team

    #tag the dev id with the tag ID
    $json = @{"assign" = @($EHTagID)}
    $json = $json | ConvertTo-Json
    
    $result = Invoke-RestMethod -Uri ("https://extrahop.channeladvisor.com/api/v1/devices/"+$devid+"/tags") -Headers $headers -Method Post -Body $json 
    $result

}
function getEHTagID ($team) {
    #lookup the tag ID for the team text
    $tags = @{"test" = 1;
            "Business Intelligence" = 2;
            "Core Infrastructure" = 3;
            "eBay" = 4;
            "Emerging Marketplaces" = 5;
            "Inventory" = 6;
            "Marketplaces" = 7;
            "Orders" = 8;
            "Predictive Analytics" = 9;
            "Product Catalog" = 10;
            "Search" = 11;
            "Shopping" = 12
        }
        if($tags.Item($team) -eq $null){
        return 1
        }
        else{
        return $tags.Item($team)
        }
}



foreach ($dev in $csv) {
    $ehids = getExtrahopDevID $dev.server
    foreach ($devid in $ehids) {
        #$dev.team
        tagEHDevice $devid $dev.team
    }

}





