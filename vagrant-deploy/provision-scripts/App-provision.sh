echo "Provisioning application"

# set env variables
export DB_HOST=localhost
export DB_USER=movie_api
export DB_PASS=movie_api
export DB_NAME=movies_db

mkdir repositories
cd repositories

# Download api repo
echo "===================== Downloading API repo ============================"
git clone https://github.com/renardete/movie-analyst-api.git
cd movie-analyst-api
npm i

# run api repo in background
echo "===================== Run API project ============================"
npm start&
cd ..

# Download ui repo
echo "===================== Downloading UI repo ============================"
git clone https://github.com/juan-ruiz/movie-analyst-ui.git
cd movie-analyst-ui
npm i

# run ui repo in background
echo "===================== Run UI project ============================"
npm start&
cd ..




