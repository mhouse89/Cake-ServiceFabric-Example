#addin "Cake.Powershell"
var target = Argument("target", "Default");

var solutionFile = GetFiles("../*.sln").First();
var solutionDir = new FilePath(solutionFile.ToString()).GetDirectory();
var projects = GetFiles(solutionDir+"/**/*.*proj");


Task("Clean")
    .Does(() =>
{
    Information("Cleaning...");
    Information("Current solution dirctory is: " + solutionDir);
    Information("Current solution file is: " + solutionFile);

    projects.ToList().ForEach(item => DotNetCoreClean(item.FullPath));
});

Task("Default")
    .IsDependentOn("Clean")
    .Does(() =>
{
    Information("Building...");
    
    // DotNetBuild(solutionFile.FullPath);

    
    Information("Deploying Aplication to Service Fabric");
    
    StartPowershellFile("C:\\Users\\housem\\service-fabric-dotnet-quickstart\\Voting\\Scripts\\Deploy-FabricApplication.ps1", args =>
        {
            args.Append("ApplicationPackagePath", "C:\\Users\\housem\\service-fabric-dotnet-quickstart\\Voting\\pkg\\Debug")
                .Append("PublishProfileFile", "C:\\Users\\housem\\service-fabric-dotnet-quickstart\\Voting\\PublishProfiles\\Local.5Node.xml")
                .Append("-DeployOnly:$false")
                .Append("-ApplicationParameter:@{}")
                .Append("UnregisterUnusedApplicationVersionsAfterUpgrade", "$false")
                .Append("OverrideUpgradeBehavior", "None")
                .Append("OverwriteBehavior", "SameAppTypeAndVersion")
                .Append("-SkipPackageValidation:$false")
                .Append("ErrorAction", "Stop");

                
        });
});

RunTarget(target);