#!/bin/bash

apt update -y
apt install nginx -y

systemctl enable nginx
systemctl start nginx

echo "<h1>Terraform GitHub Actions Project</h1>" > /var/www/html/index.html
