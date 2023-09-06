#!/bin/bash

# Install required dependencies
echo "Installing required dependencies..."
sudo apt-get update
sudo apt-get install -y libcap-ng0 libcap-ng-dev libzstd-dev libarchive-dev

# Set PKG_CONFIG_PATH if needed
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"

# Clone the ICECC repository and checkout the desired branch
echo "Cloning ICECC repository and checking out the 1.4-branch..."
git clone https://github.com/icecc/icecream.git
cd icecream
git checkout 1.4-branch

# Configure, build, and install ICECC
echo "Configuring and building ICECC..."
autoupdate
./autogen.sh
./configure
make
sudo make install

# Start and enable the ICECC service
echo "Starting and enabling ICECC service..."
sudo systemctl start iceccd
sudo systemctl enable iceccd

# Verify the installed version of ICECC
echo "Verifying the installed version of ICECC..."
icecc --version

# Additional steps and configurations can be added here as needed

echo "ICECC installation and setup completed."
