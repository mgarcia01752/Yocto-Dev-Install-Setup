# Yocto-Dev-Install-Setup
Base Installation for a Yocto Development

# Ubuntu Required Packages

## Packages

 ```shell  
sudo apt update

#OS Packages
sudo apt net-tools -y
sudo apt install -y openssh-server
sudo apt  install htop -y

#Applications
sudo apt install -y git
sudo apt install -y python3
sudo apt install -y virtualbox virtualbox-ext-pack
sudo apt-get install -y libqt5widgets5
sudo apt-get install -y icecc
sudo apt-get install -y fuse


```

## Applications

### Visual Studio Code

```shell
wget -O vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868
sudo dpkg -i vscode.deb
```

## Configurations

### Git

```shell
git config --global user.email "mgarcia01752@outlook.com"
git config --global user.name "Maurice Garcia"
```

### Virtual Box

```bash
sudo usermod -aG vboxusers $(whoami)

# Check if DISPLAY is already set
if [ -z "$DISPLAY" ]; then
    echo "DISPLAY is not set, adding to ~/.bashrc..."
    echo 'export DISPLAY=:0' >> ~/.bashrc
    echo "DISPLAY is now set to :0 and will be loaded on login."
    echo "You can run 'source ~/.bashrc' to apply it immediately."
else
    echo "DISPLAY is already set to $DISPLAY."
    echo "No changes needed."
fi
```
### IceCream

Run as sudo

```bash
# Check if Icecream repository exists for Ubuntu 22.04 LTS (or your version)
if [[ ! -f /etc/apt/sources.list.d/icecream.list ]]; then
    echo "Adding Icecream repository..."
    sudo sh -c 'echo "deb http://download.opensuse.org/repositories/home:/dmuel/minimalistic/xUbuntu_22.04/ /" > /etc/apt/sources.list.d/icecream.list'
    wget -O - https://download.opensuse.org/repositories/home:dmuel/minimalistic/xUbuntu_22.04/Release.key | sudo apt-key add -
    sudo apt-get update
fi

# Install Icecream

(IceCream)[https://github.com/icecc/icecream]

if ! command -v icecc &>/dev/null; then
    echo "Installing Icecream..."
    sudo apt-get install -y icecc
else
    echo "Icecream is already installed."
fi

# Start Icecream services
sudo systemctl start iceccd
sudo systemctl start icecc-scheduler

echo "Icecream is installed and running."

```

## Download Etcher

[Etcher Doc](https://etcher-docs.balena.io/?)

```shell

sudo modprobe fuse

wget https://github.com/balena-io/etcher/releases/download/v1.18.11/balenaEtcher-1.18.11-x64.AppImage

./balenaEtcher-1.18.11-x64.AppImage

```

