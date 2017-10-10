
. .\apiconfig.ps1

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", " ExtraHop apikey="+$apikey)
$headers.Add("Accept", "application/json") 


$result = Invoke-RestMethod -Method Get -Uri "https://extrahop.channeladvisor.com/api/v1/devices?limit=100&search_type=name&value=rdu-svc-999" -Headers $headers