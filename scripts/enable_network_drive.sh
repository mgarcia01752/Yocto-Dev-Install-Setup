#!/bin/bash

# Update package repositories and install Samba
sudo apt update
sudo apt install samba -y

# Backup the original smb.conf file
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak

# Create a new smb.conf file
cat <<EOL | sudo tee /etc/samba/smb.conf
[global]
   workgroup = WORKGROUP
   server string = Samba Server %v
   netbios name = $(hostname)
   security = user
   map to guest = bad user
   dns proxy = no
   # Other global configuration options go here

# Share Definitions
[homes]
   comment = Home Directories
   browseable = yes
   read only = no
   create mask = 0755
   directory mask = 0755
   valid users = %S

# Add other shared folders below this line
EOL

# Restart the Samba service
sudo systemctl restart smbd

# Allow Samba through the firewall
sudo ufw allow samba

# Display a message
echo "Network drive discovery has been enabled. You can now browse network shares."
