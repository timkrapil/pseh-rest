
. .\apiconfig.ps1
$EHclient = New-ExtraHopAPIClient -Host $ehHost -ApiKey $apikey



[string]$searchtype = "type"
[string]$name = 'node'
[int]$limit = 2000
[int]$activefrom = 0
[int]$activeuntil = 0
[int]$offset = 0

$devices = $EHclient.GetDevices($name, $searchtype, $activefrom, $activeuntil, $limit, $offset)

$EHclient = $null

