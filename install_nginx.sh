#!/bin/bash

sudo apt update
sudo apt-get install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

echo "Nginx installed and started successfully" | sudo tee /var/www/html/index.html
