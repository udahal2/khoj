param(
    $rule = "default"
)
<# NOTE: Update these variables to target different files with this script. #>
$MAIN = "src.app"
# ======================================================================== #
$CP_DELIM = ";"
if ( $IsMacOS -or $IsLinux ) {
    $CP_DELIM = ":" # changes to : for Mac or Linux
}
# Function to get the current branch name
function Get-CurrentBranch {
    $branch = git rev-parse --abbrev-ref HEAD
    return $branch
}
<# ======================================================================== #>
if ( $rule -eq "" -or $rule -eq "default" ) {

}

elseif ( $rule -eq "update" ) {
    git add .
    git commit -m "updated"
    Write-Debug " ** committed ** "
    $currentBranch = Get-CurrentBranch
    git fetch origin $currentBranch
    git pull origin $currentBranch
    git push origin $currentBranch
    Write-Output " **Pushing to github in $currentBranch done..."
 
} 
elseif ( $rule -eq "run" ) {
    Write-Output "Running the application..."
    #dotnet run --project $MAIN
    python app.py
}
elseif ( $rule -eq "test" ) {
    Write-Output "Starting the Python server locally..."
    python tests/test.py
}
else {
    Write-Output "build: *** No rule to make target '$rule'.  Stop."
}

