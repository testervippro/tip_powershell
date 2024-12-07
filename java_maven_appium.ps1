# Run with admin permission
#  Get-ExecutionPolicy should return Unrestricted
# If the policy is set to Restricted or AllSigned, you may need to change it to RemoteSigned or
# Unrestricted to run your script. You can change it with
# If the policy is set to Restricted or AllSigned, you may need to change it to RemoteSigned or Unrestricted to run your script.
# You can change it wit
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

# Android Home
# Set ANDROID_HOME for the current session
$env:ANDROID_HOME = "C:\Users\ad\AppData\Local\Android\Sdk"

# Add SDK tools and platform-tools to the PATH for the current session
$env:Path += ";$env:ANDROID_HOME\tools;$env:ANDROID_HOME\platform-tools"

# Make the changes persistent
[System.Environment]::SetEnvironmentVariable('ANDROID_HOME', 'C:\path\to\your\android\sdk', [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable('Path', 
    [System.Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::User) + ";C:\path\to\your\android\sdk\tools;C:\path\to\your\android\sdk\platform-tools", 
    [System.EnvironmentVariableTarget]::User)
# Verify the installation
echo $env:ANDROID_HOME


