#!/bin/bash
# Navigate to app directory
cd /home/ubuntu/demoapp || exit 1

# Activate virtual environment
source /home/ubuntu/demoapp/venv/bin/activate

# Install dependencies
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
else
    echo "Warning: requirements.txt not found"
fi

# Restart services
sudo systemctl restart orbisect-dashboard
sudo systemctl reload nginx

echo "Deployment complete"
