#!/bin/bash

# Install dependencies
sudo apt update
sudo apt install -y python3-pip python3-venv nginx certbot python3-certbot-nginx

# Create virtual environment
python3 -m venv /home/ubuntu/demoapp/venv
source /home/ubuntu/demoapp/venv/bin/activate
pip install wheel
pip install gunicorn flask

# Set permissions
sudo chown -R ubuntu:www-data /home/ubuntu/demoapp
sudo chmod -R 775 /home/ubuntu/demoapp
sudo find /home/ubuntu/demoapp -type d -exec chmod 775 {} \;

# Create system user
sudo adduser --system --no-create-home --group orbisect
sudo usermod -aG www-data orbisect

# Create runtime directory
sudo mkdir -p /run/orbisect
sudo chown orbisect:www-data /run/orbisect
sudo chmod 775 /run/orbisect

# Enable and start services
sudo ln -s /etc/nginx/sites-available/orbisect /etc/nginx/sites-enabled/
sudo systemctl daemon-reload
sudo systemctl enable orbisect-dashboard
sudo systemctl start orbisect-dashboard
sudo systemctl restart nginx

# Get SSL certificate
sudo certbot --nginx -d orbisectdefense.mooo.com --non-interactive --agree-tos --email your-email@example.com
sudo certbot renew --dry-run

echo "Setup complete! Access your dashboard at:"
echo "https://orbisectdefense.mooo.com"
