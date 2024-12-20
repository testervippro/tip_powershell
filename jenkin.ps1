# Define Jenkins URL and download path
$JenkinsURL = "https://get.jenkins.io/war-stable/latest/jenkins.war"
$DownloadPath = Join-Path -Path ([Environment]::GetFolderPath("UserProfile")) -ChildPath "Downloads\jenkins.war"

# Download Jenkins WAR file
Invoke-WebRequest -Uri $JenkinsURL -OutFile $DownloadPath -UseBasicParsing

# Start Jenkins with admin credentials
Start-Process "java" -ArgumentList "-jar `"$DownloadPath`" --argumentsRealm.passwd.admin=admin --argumentsRealm.roles.admin=admin" -NoNewWindow

# Wait for Jenkins to start and open the setup page
$JenkinsReady = $false
$MaxWaitTime = 300  # Maximum wait time in seconds (5 minutes)
$StartTime = (Get-Date).Ticks

Do {
    Start-Sleep -Seconds 10  # Check every 10 seconds
    $JenkinsReady = (Test-Connection -ComputerName localhost -Port 8080 -Count 1 -ErrorAction SilentlyContinue)

    $CurrentTime = (Get-Date).Ticks
    $ElapsedTime = [math]::Floor(($CurrentTime - $StartTime) / [timespan]::FromSeconds(1).Ticks)
} until ($JenkinsReady -or $ElapsedTime -ge $MaxWaitTime)

if ($JenkinsReady) {
    Invoke-WebRequest -Uri "http://localhost:8080" -UseBasicParsing
} else {
    Write-Host "Jenkins did not start within the expected time frame."
}
