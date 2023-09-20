#!/bin/bash

install_braveBrowser() {
    sudo apt update -y
    sudo apt install curl -y

    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    sudo apt update -y

    sudo apt install brave-browser -y
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
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo mv packages.microsoft.gpg /usr/share/keyrings

    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

    sudo apt-get update -y

    sudo apt-get install code -y
}

install_docker() {
    sudo apt update -y
    sudo apt install docker.io docker-compose -y

    # Add the current user to the docker group
    sudo usermod -aG docker $USER
}

# Call the functions to install the software
install_braveBrowser
install_chrome
install_common_apps
install_vscode
install_docker
#
