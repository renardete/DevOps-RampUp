#!/usr/bin/bash

# ------ Provissioning script -------
# 1. MySQL DB installation and config
./MySQL-provission.sh

# 2. Install NodeJS
./NodeJS-provission.sh

# 3. Download and Run Application
./App-provission.sh
