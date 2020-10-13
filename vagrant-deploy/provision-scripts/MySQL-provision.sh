echo "===================== Provisioning mysql ============================"

db_root_password="root"

# Install lates updates for SO
# apt-get update && apt-get upgrade -y

Enable Firewall and allow MySql ports
ufw enable
ufw allow 3306

# Install MySQL Server in a Non-Interactive mode. Default root password will be "root"
echo "===================== installing mysql ============================"
echo -e "\n"
echo "mysql-server mysql-server/root_password password " | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password " | sudo debconf-set-selections
apt-get -y install mysql-server

# Run the MySQL Secure Installation wizard
echo "===================== Configuring mysql ============================"
echo -e "\n"
echo "securing DB"
sudo mysql --user=root <<_EOF_
  ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
  DELETE FROM mysql.user WHERE User='';
  DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
  DROP DATABASE IF EXISTS test;
  DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
  FLUSH PRIVILEGES;
_EOF_

echo "Creating new user"
sed -i 's/127\.0\.0\.1/0\.0\.0\.0/g' /etc/mysql/my.cnf
sudo mysql -u root <<_EOF_
  CREATE USER 'movie_api'@'localhost' IDENTIFIED WITH mysql_native_password BY 'movie_api';
_EOF_
sudo mysql -u root <<_EOF_
  GRANT ALL PRIVILEGES ON *.* TO 'movie_api'@'localhost';
  FLUSH PRIVILEGES;
_EOF_

service mysql restart

# Create Movies DB
echo "===================== Creating DB and Movie table ============================"
echo -e "\n"
sudo mysql -u root <<_EOF_
  CREATE DATABASE movies_db;
_EOF_
sudo mysql -u root <<_EOF_
  USE movies_db; 
  CREATE TABLE IF NOT EXISTS movies
    (movie_id INT(10) UNSIGNED PRIMARY KEY NOT NULL, 
    title VARCHAR(100) NOT NULL, 
    release_date VARCHAR(10) NOT NULL,
    score INT, 
    reviewer VARCHAR(200), 
    publication VARCHAR(300)
  );
_EOF_

# Insert movies in DB
echo "===================== Inserting test items ============================"
echo -e "\n"
sudo mysql -u root <<_EOF_
 USE movies_db;
 INSERT INTO movies (movie_id, title, release_date, score, reviewer, publication)
 VALUES (1, "juan movie", "2020", 5, "juan", "public"),
  (2, "felipe movie", "2021", 7, "felipe", "private");
_EOF_
