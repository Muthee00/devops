
#!/bin/bash

set -e

echo "======================================"
echo " Starting Docker Installation"
echo "======================================"

# 1. Update system packages
echo "[1/7] Updating System Packages..."
sudo dnf update -y

# 2. Install Docker
echo "[2/7] Installing Docker..."
sudo dnf install -y docker

# 3. Add ec2-user to Docker group
echo "[3/7] Adding ec2-user to Docker group..."
sudo usermod -aG docker ec2-user

# 4. Enable and start Docker service
echo "[4/7] Enabling and starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

# 5. Install Docker Compose plugin
echo "[5/7] Installing Docker Compose..."
sudo dnf install -y docker-compose-plugin || {
    echo "Docker Compose plugin unavailable through DNF."
    echo "You can install the Compose plugin separately if needed."
}

# 6. Verify Docker installation
echo "[6/7] Verifying Docker installation..."
sudo docker --version

# 7. Verify Docker service
echo "[7/7] Checking Docker service status..."
sudo systemctl status docker --no-pager

echo "======================================"
echo " Docker Installation Completed!"
echo "======================================"

echo "IMPORTANT: Log out and log back in for Docker group changes to take effect."

echo "To test Docker, run:"
echo "docker run hello-world"
