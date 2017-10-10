. .\apiconfig.ps1
$EHclient = New-ExtraHopAPIClient -Host $ehHost -ApiKey $apikey

function getObjIDs {
    param([string]$type,
        [string]$searchtype = "any",
        [string]$name,
        [int]$limit = 500,
        [int]$activefrom = 0,
        [int]$activeuntil = 0,
        [int]$offset = 0)
    switch ($type) {
        "Application" { 
            #do application lookup
            $apps = $EHclient.GetApplications($name,$searchtype,$activefrom,$activeuntil,$limit,$offset)
            $appids = @()
            foreach ($app in $apps) {
                $appids += $app.ID    
            }
            return $appids  
         }
        "Device" {
            #do device stuff
            $devices = $EHclient.GetDevices($name,$searchtype,$activefrom,$activeuntil,$limit,$offset)
            $devids = @()
            foreach ($dev in $devices) {
                $devids += $dev.ID    
            }
            return $devids

        }
        "DeviceGroup" {
            #do devgrp stuff
            $devgroups = $EHclient.GetDeviceGroups()
            $devgroups = $devgroups | Where-Object {$_.Name -Like ("*"+$name+"*")}
            $devgroupIDs = @()
            foreach ($devgroup in $devgroups) {
                $devgroupIDs += $devgroup.ID 
            }
            return $devgroupIDs
        }
        Default {$err = "no valid type seen"; throw $err}
    }
    
}