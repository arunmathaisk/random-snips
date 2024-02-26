#!/bin/bash

install_braveBrowser() {
    echo "Updating package list..."
    sudo apt update -y
    echo "Installing curl..."
    sudo apt install curl -y

    echo "Adding Brave Browser keyring..."
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

    echo "Adding Brave Browser repository..."
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    echo "Updating package list again..."
    sudo apt update -y

    echo "Installing Brave Browser..."
    sudo apt install brave-browser -y
    echo "Brave Browser installed!"
}

install_chrome() {
    echo "Downloading Google Chrome..."
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

    echo "Installing Google Chrome..."
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    sudo apt-get install -f -y
    sudo apt-get update -y
    echo "Google Chrome installed!"
}

install_common_apps() {
    echo "Installing common apps..."
    sudo apt update -y
    sudo apt install htop vlc git qbittorrent axel python3-pip python3-venv gcc thunderbird -y
}

install_vscode() {
    echo "Adding Microsoft GPG key..."
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo mv packages.microsoft.gpg /usr/share/keyrings

    echo "Adding VS Code repository..."
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

    echo "Updating package list..."
    sudo apt-get update -y

    echo "Installing Visual Studio Code..."
    sudo apt-get install code -y
    echo "Visual Studio Code installed!"
}

install_vscode_extensions() {
    echo "Installing VS Code extensions..."
    code --install-extension ms-python.python
    code --install-extension ms-vscode-remote.vscode-remote-extensionpack
    code --install-extension ms-vscode.cpptools
    code --install-extension esbenp.prettier-vscode
    code --install-extension Vue.volar
    echo "VS Code extensions installed!"
}

install_docker() {
    echo "Updating package list..."
    sudo apt update -y
    echo "Installing Docker and Docker Compose..."
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    
    echo "Adding the current user to the docker group..."
    sudo usermod -aG docker $USER
}

# Call the functions to install the software
install_braveBrowser
install_chrome
install_common_apps
install_vscode
install_vscode_extensions
install_docker
