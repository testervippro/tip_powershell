#!/bin/bash

case "$1" in
  "Java 1.2") export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.2.2.jdk/Contents/Home" ;;
  "Java 1.3") export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.3.1_28.jdk/Contents/Home" ;;
  ...
  "Java 21") export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home" ;;
  "Java 22") export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-22.jdk/Contents/Home" ;;
  *) echo "Unsupported Java version"; exit 1 ;;
esac

# Update PATH to prioritize this Java version
export PATH="$JAVA_HOME/bin:$PATH"

echo "$1 activated."

if [[ "$2" == "perm" ]]; then
  echo "export JAVA_HOME=\"$JAVA_HOME\"" >> ~/.bash_profile
  echo "export PATH=\"$JAVA_HOME/bin:\$PATH\"" >> ~/.bash_profile
  echo "$1 permanently activated."
fi
