#!/bin/bash

sudo systemctl stop docker
# Step 2: Uninstall Docker completely using purge
echo "Removing Docker and its content..."
sudo apt-get purge -y docker-ce docker-ce-cli containerd.io
sudo apt-get autoremove -y --purge
sudo rm -rf /var/lib/docker
sudo rm -rf /etc/docker
sudo rm -rf /var/run/docker.sock
sudo rm -rf /var/lib/containerd
# Step 3: Install Docker
echo "Installing Docker..."
sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
# Step 4: Start Docker Daemon
echo "Starting Docker service..."
sudo systemctl start docker
# Step 5: Enable Docker to start on boot
echo "Enabling Docker to start on boot..."
sudo systemctl enable docker
# Step 6: Give the user permission to Docker socket
echo "Granting permissions to Docker socket..."
sudo usermod -aG docker $USER
# Step 7: Verify Docker installation
echo "Docker installed successfully, verifying version..."
docker --version
echo "Docker setup is complete. Please log out and log back in for group changes to take effect."
