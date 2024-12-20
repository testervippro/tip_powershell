# Define Jenkins URL and download path
$JenkinsURL = "https://get.jenkins.io/war-stable/latest/jenkins.war"
$DownloadPath = Join-Path -Path ([Environment]::GetFolderPath("UserProfile")) -ChildPath "Downloads\jenkins.war"

# Download Jenkins WAR file
Invoke-WebRequest -Uri $JenkinsURL -OutFile $DownloadPath -UseBasicParsing

# Start Jenkins with admin credentials
Start-Process "java" -ArgumentList "-jar `"$DownloadPath`" --argumentsRealm.passwd.admin=admin --argumentsRealm.roles.admin=admin" -NoNewWindow

# Use Invoke-WebRequest to open Jenkins setup page
Invoke-WebRequest -Uri "http://localhost:8080" -UseBasicParsing
