$COMMAND = $args

function ClusterSelect () 
{
    sfctl cluster select --endpoint http://localhost:19080 --debug
    Write-Output "Connected to local ServiceFabric instance..."
}

function ApplicationUpload () 
{
   sfctl application upload --path  C:\Users\housem\service-fabric-dotnet-quickstart\Voting\pkg\Debug --imagestore-string file:C:\SfDevCluster\Data\ImageStoreShare --show-progress --debug
}

function ApplicationProvision () 
{
    sfctl application provision --application-type-build-path Debug --timeout 500 --verbose --debug
    Write-Output "Application in Image Store registered with ServiceFabric..."
}

function ApplicationCreate () 
{
    sfctl application create --app-name fabric:/Voting --app-type VotingType --app-version 3.0.0 --verbose --debug
    Write-Output "Application has started successfully on http://localhost:8080"
}

function ApplicationDelete () 
{
    sfctl application delete --application-id Voting --timeout 500 --debug
}

function ApplicationUnprovision () 
{
    sfctl application unprovision --application-type-name VotingType --application-type-version 3.0.0 --timeout 500 --verbose --debug
    Write-Output "Application Type Unprovisioned..."
}

function ApplicationUpgrade () 
{
    Write-Output "Application upgrade started..."
    sfctl application upgrade --application-id fabric:/Voting --application-version 4.0.0 --parameters "{}" --mode Monitored --verbose
    Write-Output "See http://localhost:19080 for Application upgrade progress..."
}

if ($COMMAND -eq 'ClusterSelect') 
{
    ClusterSelect
}

if ($COMMAND -eq 'ApplicationUpload') 
{
    ApplicationUpload
}

if ($COMMAND -eq 'ApplicationProvision') 
{
    ApplicationProvision
}

if ($COMMAND -eq 'ApplicationCreate') 
{
    ApplicationCreate
}

if ($COMMAND -eq 'ApplicationDelete') 
{
    ApplicationDelete
}

if ($COMMAND -eq 'ApplicationUnprovision') 
{
    ApplicationUnprovision
}

if ($COMMAND -eq 'ApplicationUpgrade') {
    ApplicationUpgrade
}
