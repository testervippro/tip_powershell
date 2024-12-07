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
Write-Host "JDK 17 installation completed and environment variables set."

