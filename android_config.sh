#!/bin/bash

# Defining variables
JDK_URL="https://download.java.net/java/GA/jdk17.0.2/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/openjdk-17.0.2_linux-x64_bin.tar.gz"
JDK_TAR="openjdk-17.0.2_linux-x64_bin.tar.gz"
INSTALL_DIR="$HOME/java"
ANDROID_SDK_DIR="$HOME/Android/Sdk"

# Creating installation directories
echo "Creating installation directories..."
mkdir -p $INSTALL_DIR
mkdir -p $ANDROID_SDK_DIR/cmdline-tools

# Downloading the JDK
echo "Downloading the JDK..."
wget -O $INSTALL_DIR/$JDK_TAR $JDK_URL

# Extracting the JDK
echo "Extracting the JDK..."
tar -xzf $INSTALL_DIR/$JDK_TAR -C $INSTALL_DIR

# Removing the tar file
echo "Removing the JDK tar file..."
rm $INSTALL_DIR/$JDK_TAR

# Updating .bashrc
echo "Updating .bashrc..."
echo "export JAVA_HOME=$INSTALL_DIR/jdk-17.0.2" >> $HOME/.bashrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> $HOME/.bashrc
echo "export ANDROID_HOME=$ANDROID_SDK_DIR" >> $HOME/.bashrc
echo "export PATH=\$ANDROID_HOME/cmdline-tools/latest/bin:\$PATH" >> $HOME/.bashrc
echo "export PATH=\$ANDROID_HOME/platform-tools:\$PATH" >> $HOME/.bashrc

# Updating .zshrc
echo "Updating .zshrc..."
echo "export JAVA_HOME=$INSTALL_DIR/jdk-17.0.2" >> $HOME/.zshrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> $HOME/.zshrc
echo "export ANDROID_HOME=$ANDROID_SDK_DIR" >> $HOME/.zshrc
echo "export PATH=\$ANDROID_HOME/cmdline-tools/latest/bin:\$PATH" >> $HOME/.zshrc
echo "export PATH=\$ANDROID_HOME/platform-tools:\$PATH" >> $HOME/.zshrc

# Loading the new environment variables
echo "Loading the new environment variables..."
source $HOME/.bashrc
source $HOME/.zshrc

# Verifying the installation
echo "Verifying the installation..."
java -version

echo "Installation completed."

# Running Android Studio
echo "Use Android Studio to install SDK"
studio > /dev/null 2>&1 &
