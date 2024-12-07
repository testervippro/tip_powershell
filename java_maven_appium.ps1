# run with admin permission
# Define the download URL and the path to save the installer
$url = "https://download.oracle.com/java/17/archive/jdk-17.0.12_windows-x64_bin.exe" 
$outputPath = "C:\Users\ad\Downloads\jdk-17-installer.exe"

# Download the JDK installer
Invoke-WebRequest -Uri $url -OutFile $outputPath

# Run the installer silently
Start-Process -FilePath $outputPath -ArgumentList "/s" -NoNewWindow -Wait

# Verify the installation
java -version

# Set JAVA_HOME environment variable
$env:JAVA_HOME = "C:\Program Files\Java\jdk-17"  # Adjust the path if necessary
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", $env:JAVA_HOME, "Machine")

# Add Java to the PATH environment variable
$path = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
$path += ";C:\Program Files\Java\jdk-17\bin"  # Adjust path if necessary
[System.Environment]::SetEnvironmentVariable("Path", $path, "Machine")

# Output confirmation
Write-Host "Java Home"
[System.Environment]::GetEnvironmentVariable("JAVA_HOME", "Machine")

# Maven
# Step 1: Define Maven version and download URL
$mavenVersion = "3.9.9"  # Replace with the desired Maven version
$downloadUrl = "https://dlcdn.apache.org/maven/maven-3/$mavenVersion/binaries/apache-maven-$mavenVersion-bin.zip"
$downloadPath = "$env:USERPROFILE\Downloads\apache-maven-$mavenVersion-bin.zip"

# Step 2: Download the Maven binary
Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadPath
Write-Host "Downloaded Maven version $mavenVersion to $downloadPath"

# Step 3: Define installation directory
$installDir = "C:\Program Files\Apache\maven-$mavenVersion"

# Step 4: Create installation directory
New-Item -ItemType Directory -Path $installDir -Force

# Step 5: Extract the downloaded zip file to the installation directory
Expand-Archive -Path $downloadPath -DestinationPath $installDir -Force
Write-Host "Extracted Maven to $installDir"

# Step 6: Set Maven environment variables
# Set MAVEN_HOME
[System.Environment]::SetEnvironmentVariable('MAVEN_HOME', $installDir, [System.EnvironmentVariableTarget]::Machine)

# Set PATH variable to include Maven bin directory
$mavenBin = "$installDir\apache-maven-$mavenVersion\bin"
$existingPath = [System.Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable('Path', "$mavenBin;$existingPath", [System.EnvironmentVariableTarget]::Machine)

# Step 7: Verify the installation
$mavenVersionOutput = mvn -version 2>&1
if ($mavenVersionOutput) {
    Write-Host "Maven installed successfully:"
    Write-Host $mavenVersionOutput
} else {
    Write-Host "Maven installation failed."
}
