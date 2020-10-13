
echo "===================== Installing Nginx ============================"
echo -e "\n"
sudo apt install -y nginx
sudo ufw allow 'Nginx HTTP'

echo "===================== Configuring Nginx ============================"
echo -e "\n"
sudo mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.disabled
sudo cp /vagrant/provision-scripts/resources/nodeapp.conf /etc/nginx/sites-available/default

echo "===================== reloading Nginx ============================"
echo -e "\n"
sudo nginx -s reload